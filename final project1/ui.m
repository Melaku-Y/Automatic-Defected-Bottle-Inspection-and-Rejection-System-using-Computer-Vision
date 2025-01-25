function varargout = ui(varargin)
% UI MATLAB code for ui.fig
%      UI, by itself, creates a new UI or raises the existing
%      singleton*.
%
%      H = UI returns the handle to a new UI or the handle to
%      the existing singleton*.
%
%      UI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in UI.M with the given input arguments.
%
%      UI('Property','Value',...) creates a new UI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before ui_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to ui_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help ui

% Last Modified by GUIDE v2.5 06-May-2022 05:04:23

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @ui_OpeningFcn, ...
                   'gui_OutputFcn',  @ui_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before ui is made visible.
function ui_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to ui (see VARARGIN)

% Choose default command line output for ui
handles.output = hObject;
clc
handles.myImage = imread('AASTU.jpg');
 axes(handles.axes5);
 imshow(handles.myImage)
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes ui wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = ui_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in Reference_image.
function Reference_image_Callback(hObject, eventdata, handles)
% hObject    handle to Reference_image (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[filename pathname] = uigetfile({'*.jpg';'*.bmp'},'File Selector');
 handles.myImage = strcat(pathname, filename);
 axes(handles.axes1);
 imshow(handles.myImage)
 guidata(hObject,handles);


% --- Executes on button press in test_image.
function test_image_Callback(hObject, eventdata, handles)
% hObject    handle to test_image (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[filename pathname] = uigetfile({'*.jpg';'*.bmp'},'File Selector');
 handles.myImage = strcat(pathname, filename);
 axes(handles.axes2);
 imshow(handles.myImage)
 imh = findobj(handles.axes1, 'type', 'image');
imh = findobj(handles.axes2, 'type', 'image');
T = get(imh, 'CData');
gray_T = rgb2gray(T);
axes(handles.axes3);
imshow(gray_T);
bw_T = im2bw(T, 0.6);
axes(handles.axes4);
imshow(bw_T);
 guidata(hObject,handles);


% --- Executes on selection change in popupmenu1.
function popupmenu1_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
contents = get(hObject,'Value');
imh = findobj(handles.axes1, 'type', 'image');
O = get(imh, 'CData');
imh = findobj(handles.axes2, 'type', 'image');
T = get(imh, 'CData');
switch contents
    case 1
        myicon =  imread('delete.png');
        msgbox('Please select a test to proceed','ERROR !!','custom',myicon); 
        
    case 2
        if CheckBottleOver_filled(O,T) == 1
            disp('Overfilled Bottle')
            set(handles.text40, 'string', '1');
            set(handles.text35, 'string', '0');
        elseif CheckBottleUnder_filled(O,T) == 1
            disp('Underfilled Bottle')
            set(handles.text40, 'string', '0');
            set(handles.text35, 'string', '1');
        else 
            disp('Standard Level')
            set(handles.text40, 'string', '0');
            set(handles.text35, 'string', '0');
        end 
    case 3
        if BottleTopMissing(O,T) == 1
            disp('No Cap');
            set(handles.text38, 'string', '1');
        else 
            disp('Bottle has Cap');
            set(handles.text38, 'string', '0');
        end
    case 4
        if CheckMissingLabel(O,T) == 0
            set(handles.text41, 'string', '0');
            if LabelNotPrinted(O,T) == 0 && CheckIfLabelIsStr8t(O,T) == 0
                disp('label has no defect');
                set(handles.text40, 'string', '0');
                set(handles.text36, 'string', '0');
            elseif CheckIfLabelIsStr8t(O,T) == 1
                disp('label is not straight');
                set(handles.text36, 'string', '1');
            else 
                disp('no label printed on the bottle');
                set(handles.text36, 'string', '0');
                set(handles.text44, 'string', '1');
            end
        else
            disp('No label in the bottle')
            set(handles.text41, 'string', '1');
        end 
    case 5 
        if DeformedBottle(O,T) == 1
            disp('Deformed Bottle');
            set(handles.text43, 'string', '1');
        else 
            disp('No Deformation');
            set(handles.text43, 'string', '0');
        end
    case 6
        if CheckMissingBottle(O,T) == 0 && BottleTopMissing(O,T) == 0 && CheckBottleUnder_filled(O,T) == 0 && CheckMissingLabel(O,T) == 0 && LabelNotPrinted(O,T) == 0 && CheckBottleOver_filled(O,T) == 0 && CheckIfLabelIsStr8t(O,T) == 0 && DeformedBottle(O,T) == 0
        disp('Bottle is Standard!')
        set(handles.text35, 'string', '0');
        set(handles.text40, 'string', '0');
        set(handles.text35, 'string', '0');
        set(handles.text36, 'string', '0');
        set(handles.text44, 'string', '0');
        set(handles.text41, 'string', '0');
        set(handles.text43, 'string', '0');
        set(handles.text38, 'string', '0');
        set(handles.text39, 'string', 'Pass');
        myicon =  imread('tick.png');
        msgbox('Has no Defect','PASS !!','custom',myicon);
        end
        if CheckMissingBottle(O,T) == 1 || BottleTopMissing(O,T) == 1 || CheckBottleUnder_filled(O,T) == 1 || CheckMissingLabel(O,T) == 1 || LabelNotPrinted(O,T) == 1 || CheckBottleOver_filled(O,T) == 1 || CheckIfLabelIsStr8t(O,T) == 1 || DeformedBottle(O,T) == 1
        disp('Bottle has Defect!');
        set(handles.text39, 'string', 'Reject');
        myicon =  imread('delete.png');
        msgbox('Has Defect','REJECT !!','custom',myicon);
        end
    otherwise  
end


% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu1


% --- Executes during object creation, after setting all properties.
function popupmenu1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit2_Callback(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double


% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit3_Callback(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit3 as text
%        str2double(get(hObject,'String')) returns contents of edit3 as a double


% --- Executes during object creation, after setting all properties.
function edit3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit4_Callback(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit4 as text
%        str2double(get(hObject,'String')) returns contents of edit4 as a double


% --- Executes during object creation, after setting all properties.
function edit4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit5_Callback(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit5 as text
%        str2double(get(hObject,'String')) returns contents of edit5 as a double


% --- Executes during object creation, after setting all properties.
function edit5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit6_Callback(hObject, eventdata, handles)
% hObject    handle to edit6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit6 as text
%        str2double(get(hObject,'String')) returns contents of edit6 as a double


% --- Executes during object creation, after setting all properties.
function edit6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit7_Callback(hObject, eventdata, handles)
% hObject    handle to edit7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit7 as text
%        str2double(get(hObject,'String')) returns contents of edit7 as a double


% --- Executes during object creation, after setting all properties.
function edit7_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit8_Callback(hObject, eventdata, handles)
% hObject    handle to edit8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit8 as text
%        str2double(get(hObject,'String')) returns contents of edit8 as a double


% --- Executes during object creation, after setting all properties.
function edit8_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit9_Callback(hObject, eventdata, handles)
% hObject    handle to edit9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit9 as text
%        str2double(get(hObject,'String')) returns contents of edit9 as a double


% --- Executes during object creation, after setting all properties.
function edit9_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
 


% --- Executes on button press in Start_inspection.
function Start_inspection_Callback(hObject, eventdata, handles)
% hObject    handle to Start_inspection (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
imh = findobj(handles.axes1, 'type', 'image');
O = get(imh, 'CData');
imh = findobj(handles.axes2, 'type', 'image');
T = get(imh, 'CData');
gray_T = rgb2gray(T);
axes(handles.axes3);
imshow(gray_T);
bw_T = im2bw(T, 0.6);
axes(handles.axes4);
imshow(bw_T);

    MissingBottleCap = 0;
    Underfilled = 0;
    overfilled = 0;
    labelmissing = 0;
    labelnotPrinted = 0;
    labelnotstraight = 0;
    bottleDeformed = 0;
      isMissing = CheckMissingBottle(O,T);
    if isMissing == 1
       disp('No bottle in the frame');
    else
        MissingBottleCap = BottleTopMissing(O,T);
        
        if MissingBottleCap == 1
            disp('Bottle cap is Missing');
            set(handles.text38, 'string', '1');
        else 
            set(handles.text38, 'string', '0');
        end
        
        Underfilled = CheckBottleUnder_filled(O,T);
       
        if Underfilled == 1
            disp('Bottle is Underfilled');
            set(handles.text35, 'string', '1');
            set(handles.text36, 'string', '0');
            set(handles.text43, 'string', '0');
            set(handles.text44, 'string', '0');
        else 
            set(handles.text35, 'string', '0');
        end
        
        overfilled = CheckBottleOver_filled(O,T);
        
        if overfilled == 1
            disp('Bottle is Overfilled');
            set(handles.text40, 'string', '1');
        else 
            set(handles.text40, 'string', '0');
        end
        
        labelmissing = CheckMissingLabel(O,T);
        
        if labelmissing == 1
            disp('Label is Missing');
            set(handles.text41, 'string', '1');
             set(handles.text36, 'string', '0');
            set(handles.text43, 'string', '0');
            set(handles.text44, 'string', '0');
        else
            set(handles.text41, 'string', '0');
            labelnotPrinted = LabelNotPrinted(O,T);
            if labelnotPrinted == 1
                disp('Label not printed')
                set(handles.text44, 'string', '1');
                set(handles.text43, 'string', '0');
                set(handles.text36, 'string', '0');
            elseif labelnotPrinted == 0 && Underfilled == 0
                labelnotstraight = CheckIfLabelIsStr8t(O,T);
                if labelnotstraight == 1
                   disp('Label is not Straight')
                   set(handles.text36, 'string', '1');
                   set(handles.text43, 'string', '0');
                else
                    set(handles.text36, 'string', '0');
                    bottleDeformed = DeformedBottle(O,T);
                    if bottleDeformed == 1
                        disp('Bottle is Deformed'); 
                        set(handles.text43, 'string', '1');
                    else 
                        set(handles.text43, 'string', '0');
                    end 
                end
                set(handles.text44, 'string', '0');
            end
        end
    end
    if CheckMissingBottle(O,T) == 0 && BottleTopMissing(O,T) == 0 && CheckBottleUnder_filled(O,T) == 0 && CheckMissingLabel(O,T) == 0 && LabelNotPrinted(O,T) == 0 && CheckBottleOver_filled(O,T) == 0 && CheckIfLabelIsStr8t(O,T) == 0 && DeformedBottle(O,T) == 0
        disp('Bottle is Standard!')
        set(handles.text39, 'string', 'Pass');
        ledPin = 'D6';
        deltaT_blink = 3;
        port = 'COM19';
        board = 'Mega2560';
        a = arduino(port, board);
        a.writeDigitalPin(ledPin,1);
        pause(deltaT_blink)
    end
    if CheckMissingBottle(O,T) == 1
        myicon =  imread('delete.png');
        msgbox('No Bottle in the frame','REJECT !!','custom',myicon);
    end
    if BottleTopMissing(O,T) == 1 || CheckBottleUnder_filled(O,T) == 1 || CheckMissingLabel(O,T) == 1 || LabelNotPrinted(O,T) == 1 || CheckBottleOver_filled(O,T) == 1 || CheckIfLabelIsStr8t(O,T) == 1 || DeformedBottle(O,T) == 1
        disp('Bottle has Defect!')
        set(handles.text39, 'string', 'Reject');
        ledPin = 'D5';
        deltaT_blink = 3;
        port = 'COM19';
        board = 'Mega2560';
        a = arduino(port, board);
        a.writeDigitalPin(ledPin,1);
        pause(deltaT_blink);
    end
    
    
    

function edit11_Callback(hObject, eventdata, handles)
% hObject    handle to edit11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit11 as text
%        str2double(get(hObject,'String')) returns contents of edit11 as a double


% --- Executes during object creation, after setting all properties.
function edit11_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit12_Callback(hObject, eventdata, handles)
% hObject    handle to edit12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit12 as text
%        str2double(get(hObject,'String')) returns contents of edit12 as a double


% --- Executes during object creation, after setting all properties.
function edit12_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit13_Callback(hObject, eventdata, handles)
% hObject    handle to edit13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit13 as text
%        str2double(get(hObject,'String')) returns contents of edit13 as a double


% --- Executes during object creation, after setting all properties.
function edit13_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit14_Callback(hObject, eventdata, handles)
% hObject    handle to edit14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit14 as text
%        str2double(get(hObject,'String')) returns contents of edit14 as a double


% --- Executes during object creation, after setting all properties.
function edit14_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit15_Callback(hObject, eventdata, handles)
% hObject    handle to edit15 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit15 as text
%        str2double(get(hObject,'String')) returns contents of edit15 as a double


% --- Executes during object creation, after setting all properties.
function edit15_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit15 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit16_Callback(hObject, eventdata, handles)
% hObject    handle to edit16 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit16 as text
%        str2double(get(hObject,'String')) returns contents of edit16 as a double


% --- Executes during object creation, after setting all properties.
function edit16_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit16 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit17_Callback(hObject, eventdata, handles)
% hObject    handle to edit17 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit17 as text
%        str2double(get(hObject,'String')) returns contents of edit17 as a double


% --- Executes during object creation, after setting all properties.
function edit17_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit17 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit18_Callback(hObject, eventdata, handles)
% hObject    handle to edit18 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit18 as text
%        str2double(get(hObject,'String')) returns contents of edit18 as a double


% --- Executes during object creation, after setting all properties.
function edit18_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit18 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
