% MATLAB controller for Webots
% File:          my_controller.m
% Date:
% Description:
% Author:
% Modifications:

% uncomment the next two lines if you want to use
% MATLAB's desktop to interact with the controller:
desktop;
keyboard;

TIME_STEP = 64;

% get and enable devices, e.g.:
%  camera = wb_robot_get_device('camera');
%  wb_camera_enable(camera, TIME_STEP);
%  motor = wb_robot_get_device('motor');
<<<<<<< HEAD
speed = 3;
distance = 90;
=======
speed = 3
>>>>>>> c04add30d79c4ac414cf1fc52d9772e5529a9511
wheel_left_front = wb_robot_get_device('wheel_left_front');
wheel_left_back = wb_robot_get_device('wheel_left_back');
wheel_right_front = wb_robot_get_device('wheel_right_front');
wheel_right_back = wb_robot_get_device('wheel_right_back');

wb_motor_set_position(wheel_left_front, inf);
wb_motor_set_velocity(wheel_left_front, -speed);
wb_motor_set_position(wheel_left_back, inf);
wb_motor_set_velocity(wheel_left_back, -speed);
wb_motor_set_position(wheel_right_front, inf);
wb_motor_set_velocity(wheel_right_front, speed);
wb_motor_set_position(wheel_right_back, inf);
wb_motor_set_velocity(wheel_right_back, speed);

%Distance sensor settings
<<<<<<< HEAD
ds_right = wb_robot_get_device('distance_right');
wb_distance_sensor_enable(ds_right, TIME_STEP);

ds_left = wb_robot_get_device('distance_left');
wb_distance_sensor_enable(ds_left, TIME_STEP);
=======
DS = wb_robot_get_device('ds');
wb_distance_sensor_enable(DS, TIME_STEP);
>>>>>>> c04add30d79c4ac414cf1fc52d9772e5529a9511

%GPS Settings
GPS = wb_robot_get_device('gps');
wb_gps_enable(GPS,TIME_STEP);

%Compas Settings
Compass = wb_robot_get_device('comp');
wb_compass_enable(Compass, TIME_STEP);

% main loop:
% perform simulation steps of TIME_STEP milliseconds
% and leave the loop when Webots signals the termination
<<<<<<< HEAD

=======
%
>>>>>>> c04add30d79c4ac414cf1fc52d9772e5529a9511
N = 0;
S = 0;
E = 0;
W = 0;
site = 0;
brain = 0;
<<<<<<< HEAD

while wb_robot_step(TIME_STEP) ~= -1
    ds_r = wb_distance_sensor_get_value(ds_right);
    ds_l = wb_distance_sensor_get_value(ds_left);
    disp(ds_l)
=======
while wb_robot_step(TIME_STEP) ~= -1
distance = wb_distance_sensor_get_value(DS);
% disp(distance);
>>>>>>> c04add30d79c4ac414cf1fc52d9772e5529a9511
  
x_y_z = wb_gps_get_values(GPS);
% disp(x_y_z);

Site = wb_compass_get_values(Compass);
A = Site(1);
B = Site(3);

<<<<<<< HEAD
%definice_sv._stran
%definice_severu
=======
%Definice sv. stran
%Definice severu
>>>>>>> c04add30d79c4ac414cf1fc52d9772e5529a9511
if A > 0.979 & B < 0.021
    N = 1;
else
    N = 0;
end
<<<<<<< HEAD
%definice_jihu
=======
%Definice jihu    
>>>>>>> c04add30d79c4ac414cf1fc52d9772e5529a9511
if A < -0.979 & B < 0.021
    S = 1;
else
    S = 0;
end
<<<<<<< HEAD
%definice_vychodu
=======
%Definice východu
>>>>>>> c04add30d79c4ac414cf1fc52d9772e5529a9511
if A < 0.021 & B < -0.979
    E = 1;
else
    E = 0;
end
<<<<<<< HEAD
%definice_zapadu
=======
%Definice západu
>>>>>>> c04add30d79c4ac414cf1fc52d9772e5529a9511
if A < 0.021 & B > 0.979    
    W = 1;
else
    W = 0;
end
<<<<<<< HEAD
% mozek
switch brain
    case 0
            if ds_r <= distance | ds_l <= distance
=======
% Mozek
switch brain
    case 0
            if distance <= 80
>>>>>>> c04add30d79c4ac414cf1fc52d9772e5529a9511
                brain = 1
            else
            wb_motor_set_velocity(wheel_left_back, -speed);
            wb_motor_set_velocity(wheel_left_front, -speed);
            wb_motor_set_velocity(wheel_right_back, speed);
            wb_motor_set_velocity(wheel_right_front, speed); 
            end        
    case 1
        if N == 1 | S == 1
            brain = 2
        else
            brain = 5
        end        
<<<<<<< HEAD
    case 2 %horizontalni_rotace
=======
    case 2 %Horizontalni rotace
>>>>>>> c04add30d79c4ac414cf1fc52d9772e5529a9511
        wb_motor_set_velocity(wheel_left_back, 1);
        wb_motor_set_velocity(wheel_left_front, 1);
        wb_motor_set_velocity(wheel_right_back, 1);
        wb_motor_set_velocity(wheel_right_front, 1);  
                if A < 0.2
                     wb_motor_set_velocity(wheel_left_back, 0.5);
                     wb_motor_set_velocity(wheel_left_front, 0.5);
                     wb_motor_set_velocity(wheel_right_back, 0.5);
                     wb_motor_set_velocity(wheel_right_front, 0.5);              
                    if W == 1
<<<<<<< HEAD
                        if ds_r <= distance | ds_l <= distance
=======
                        if distance <= 80
>>>>>>> c04add30d79c4ac414cf1fc52d9772e5529a9511
                            brain = 3
                        else
                            brain = 0
                        end
                    end
                end
    case 3                   
        wb_motor_set_velocity(wheel_left_back, -1);
        wb_motor_set_velocity(wheel_left_front, -1);
        wb_motor_set_velocity(wheel_right_back, -1);
        wb_motor_set_velocity(wheel_right_front, -1);  
        if B < -0.8
            wb_motor_set_velocity(wheel_left_back, -0.5);
            wb_motor_set_velocity(wheel_left_front, -0.5);
            wb_motor_set_velocity(wheel_right_back, -0.5);
            wb_motor_set_velocity(wheel_right_front, -0.5);
            if E == 1
<<<<<<< HEAD
                if ds_r <= distance | ds_l <= distance
=======
                if distance <= 80
>>>>>>> c04add30d79c4ac414cf1fc52d9772e5529a9511
                    brain = 4
                else
                    brain = 0
                end
            end
        end
    case 4
        wb_motor_set_velocity(wheel_left_back, -1);
        wb_motor_set_velocity(wheel_left_front, -1);
        wb_motor_set_velocity(wheel_right_back, -1);
        wb_motor_set_velocity(wheel_right_front, -1);  
        if A < -0.8
            wb_motor_set_velocity(wheel_left_back, -0.5);
            wb_motor_set_velocity(wheel_left_front, -0.5);
            wb_motor_set_velocity(wheel_right_back, -0.5);
            wb_motor_set_velocity(wheel_right_front, -0.5);
                if S == 1
                    brain = 0
                end
        end
<<<<<<< HEAD
    case 5 %vertikalni_rotace
=======
    case 5 %Vertikalni rotace
>>>>>>> c04add30d79c4ac414cf1fc52d9772e5529a9511
            wb_motor_set_velocity(wheel_left_back, 1);
            wb_motor_set_velocity(wheel_left_front, 1);
            wb_motor_set_velocity(wheel_right_back, 1);
            wb_motor_set_velocity(wheel_right_front, 1);  
            if A > 0.8
                 wb_motor_set_velocity(wheel_left_back, 0.5);
                 wb_motor_set_velocity(wheel_left_front, 0.5);
                 wb_motor_set_velocity(wheel_right_back, 0.5);
                 wb_motor_set_velocity(wheel_right_front, 0.5);              
                if N == 1
<<<<<<< HEAD
                    if ds_r <= distance | ds_l <= distance
=======
                    if distance <= 80
>>>>>>> c04add30d79c4ac414cf1fc52d9772e5529a9511
                        brain = 6
                    else 
                        brain = 0
                    end
                end
            end
    case 6
        wb_motor_set_velocity(wheel_left_back, -1);
        wb_motor_set_velocity(wheel_left_front, -1);
        wb_motor_set_velocity(wheel_right_back, -1);
        wb_motor_set_velocity(wheel_right_front, -1);  
        if A < -0.8
            wb_motor_set_velocity(wheel_left_back, -0.5);
            wb_motor_set_velocity(wheel_left_front, -0.5);
            wb_motor_set_velocity(wheel_right_back, -0.5);
            wb_motor_set_velocity(wheel_right_front, -0.5);
                if S == 1
<<<<<<< HEAD
                    if ds_r <= distance | ds_l <= distance
=======
                    if distance <= 80
>>>>>>> c04add30d79c4ac414cf1fc52d9772e5529a9511
                        brain = 7
                    else
                        brain = 0
                    end
                end
        end
    case 7
                        
        wb_motor_set_velocity(wheel_left_back, -1);
        wb_motor_set_velocity(wheel_left_front, -1);
        wb_motor_set_velocity(wheel_right_back, -1);
        wb_motor_set_velocity(wheel_right_front, -1);  
            if A > -0.2
                wb_motor_set_velocity(wheel_left_back, -0.5);
                wb_motor_set_velocity(wheel_left_front, -0.5);
                wb_motor_set_velocity(wheel_right_back, -0.5);
                wb_motor_set_velocity(wheel_right_front, -0.5);
                    if W == 1
                        brain = 0
                    end
            end
end
  % read the sensors, e.g.:
  %  rgb = wb_camera_get_image(camera);

  % Process here sensor data, images, etc.

  % send actuator commands, e.g.:
  %  wb_motor_set_postion(motor, 10.0);

  % if your code plots some graphics, it needs to flushed like this:
  drawnow;

end

% cleanup code goes here: write data to files, etc.
