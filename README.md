# CMPM 163 Homework 1
This project showcases a variety of different shaders based on in-class examples. All three parts are labeled and displayed in one scene and the instructions for controlling the shaders (if users can interact with it) is displayed along with the part and name. 
<b>In order to fully rotate in the scene, you must click into the WebGL player. You can then hit escape to show the cursor again</b>

## Part A: Design a 3D Scene 
The scene was set up within a square taking into account the other parts of the assignment. The three shaders it shows are a texture shader that reacts to lighting, a texture shader that applies twisting vertex displacement, and a vertex displacement shader that changes color over time. The three lights for the project are circling the PhongTexture shader.<sup>*</sup>
![Part A Screenshot](https://github.com/VMLima/CMPM163_Assignment1/blob/master/Screenshots/PartA_Screenshot.PNG)

## Part B: Image Processing
The image processing shader combines both the blur and edge shaders shown in class. It allows the user to control several parts of the image. Users can: 
* Select from 4 different textures using the number keys 1 through 4. 
* Modify the blur amount by holding Q and pressing and holding the up and down arrows.<sup>**</sup>
* Modify the amount of texture or edge is showing by holding W and pressing and holding the up and down arrows.
* Modify the distance pixels check by holding E and pressing and holding the up and down arrows.
![Part B Screenshot](https://github.com/VMLima/CMPM163_Assignment1/blob/master/Screenshots/PartB_Screenshot.PNG)

## Part C: Game of Life
The Game of Life shader uses the shader given in class and modifies it colors. The user can press the spacebar to restart the shader which is useful if it becomes static.
![Part C Screenshot](https://github.com/VMLima/CMPM163_Assignment1/blob/master/Screenshots/PartC_Screenshot.PNG)

<sup>* There is a bug where the green light sometimes does not appear. It was working at one point, but on saving, quitting and returning, it stopped working again.
<br>
** The values are locked between 0 and 30 because I noticed severe frame drops on my computer when it when the blur value went over 30. The other two values are not locked at all.
</sup>
