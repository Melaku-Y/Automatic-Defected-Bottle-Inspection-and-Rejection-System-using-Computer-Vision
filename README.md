# Automatic-Defected-Bottle-Inspection-and-Rejection-System-using-Computer-Vision

This project is a complete simulation of an industrial quality control line that uses computer vision to find and remove defective bottles. It integrates MATLAB for intelligent image processing, a Siemens PLC for robust industrial control, and Factory I/O for a realistic 3D virtual environment.

### How It Works:
-   **Inspect:** A camera captures images of bottles moving along a conveyor.
-   **Detect:** A MATLAB script analyzes each image for flaws like incorrect fill levels, missing caps, and label defects.
-   **Reject:** When a defect is found, the system signals a PLC, which activates a pneumatic arm to eject the faulty bottle from the line.

---

## 🎥 Simulation in Action

The video below demonstrates the full system operating in a 3D environment. Good products (green boxes) continue down the line, while detected defects (blue boxes) are automatically identified and rejected.

**[Click the link to watch the simulation video](https://drive.google.com/file/d/1ZkM4jdN7LqCj2wnf1lWo73Hbv8ElXtat/view?usp=sharing)**

---

## Key Features

-   **Computer Vision**: Uses MATLAB's Image Processing Toolbox to intelligently detect a variety of product flaws.
-   **PLC Control**: Implements industry-standard ladder logic on a Siemens PLC for reliable, real-time control of the rejection mechanism.
-   **3D Simulation**: A virtual factory built in Factory I/O provides a dynamic and visually intuitive representation of the entire process.
-   **Multi-Defect Analysis**: Capable of identifying under/over-filled bottles, missing caps, and label errors.
-   **Interactive GUI**: A custom interface in MATLAB allows an operator to monitor the system and view inspection results.

---

### Project by

-   Bemnet Markos
-   Bemnetu Molla
-   Melaku Yemaneberhan
-   Mulat Getaye
-   Roza Mengesha
