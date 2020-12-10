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
speed = 3;
distance = 90;

twister_1 = wb_robot_get_device('twister');
wb_motor_set_position(twister_1, 10);
wb_motor_set_velocity(twister_1, 1);

%pivot_1 = wb_robot_get_device('pivot_1');
%wb_motor_set_position(pivot_1, -1);
%wb_motor_set_velocity(pivot_1, 1);

pivot_2 = wb_robot_get_device('pivot_2');
wb_motor_set_position(pivot_2, -1);
wb_motor_set_velocity(pivot_2, 1);

wheel_left_front = wb_robot_get_device('wheel_left_front');
wheel_left_back = wb_robot_get_device('wheel_left_back');
wheel_right_front = wb_robot_get_device('wheel_right_front');
wheel_right_back = wb_robot_get_device('wheel_right_back');

wb_motor_set_position(wheel_left_front, inf);
wb_motor_set_position(wheel_left_back, inf);
wb_motor_set_position(wheel_right_front, inf);
wb_motor_set_position(wheel_right_back, inf);

%Distance sensor settings
ds_right = wb_robot_get_device('distance_right');
wb_distance_sensor_enable(ds_right, TIME_STEP);

ds_left = wb_robot_get_device('distance_left');
wb_distance_sensor_enable(ds_left, TIME_STEP);

%GPS Settings
GPS = wb_robot_get_device('gps');
wb_gps_enable(GPS,TIME_STEP);

%Compas Settings
Compass = wb_robot_get_device('comp');
wb_compass_enable(Compass, TIME_STEP);

% main loop:
% perform simulation steps of TIME_STEP milliseconds
% and leave the loop when Webots signals the termination
%Finish position
X1 = -0.75;
Z1 = -0.01;
%Sites
N = 0;
S = 0;
E = 0;
W = 0;
site = 0;
brain = 0;
position = 0;
while wb_robot_step(TIME_STEP) ~= -1
    ds_r = wb_distance_sensor_get_value(ds_right);
    ds_l = wb_distance_sensor_get_value(ds_left);
    %disp(ds_l);

Site = wb_compass_get_values(Compass);
A = Site(1);
B = Site(3);

%definice_sv._stran
%definice_severu
if A > 0.985 & B > -0
    N = 1;
else
    N = 0;
end
%definice_jihu
if A < -0.98 & B > -0.015
    S = 1;
else
    S = 0;
end
%definice_vychodu
if A < 0.015 & B < -0.985
    E = 1;
else
    E = 0;
end
%definice_zapadu
if A < 0.011 & B > 0.979    
    W = 1;
else
    W = 0;
end
% mozek
switch brain
    case 0
            if ds_r <= distance | ds_l <= distance
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
    case 2 %horizontalni_rotace
        wb_motor_set_velocity(wheel_left_back, 1);
        wb_motor_set_velocity(wheel_left_front, 1);
        wb_motor_set_velocity(wheel_right_back, 1);
        wb_motor_set_velocity(wheel_right_front, 1);  
                if A < 0.1
                     wb_motor_set_velocity(wheel_left_back, 0.05);
                     wb_motor_set_velocity(wheel_left_front, 0.05);
                     wb_motor_set_velocity(wheel_right_back, 0.05);
                     wb_motor_set_velocity(wheel_right_front, 0.05);              
                    if W == 1
                        if ds_r <= distance | ds_l <= distance
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
        if B < -0.95 & A < 0.1
            wb_motor_set_velocity(wheel_left_back, -0.05);
            wb_motor_set_velocity(wheel_left_front, -0.05);
            wb_motor_set_velocity(wheel_right_back, -0.05);
            wb_motor_set_velocity(wheel_right_front, -0.05);
            if E == 1
                if ds_r <= distance | ds_l <= distance
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
        if A < -0.95 & B < 0.1
            wb_motor_set_velocity(wheel_left_back, -0.05);
            wb_motor_set_velocity(wheel_left_front, -0.05);
            wb_motor_set_velocity(wheel_right_back, -0.05);
            wb_motor_set_velocity(wheel_right_front, -0.05);
                if S == 1
                    brain = 0
                end
        end
    case 5 %vertikalni_rotace
            wb_motor_set_velocity(wheel_left_back, 1);
            wb_motor_set_velocity(wheel_left_front, 1);
            wb_motor_set_velocity(wheel_right_back, 1);
            wb_motor_set_velocity(wheel_right_front, 1);  
            if A > 0.95 & B < 0.1
                 wb_motor_set_velocity(wheel_left_back, 0.05);
                 wb_motor_set_velocity(wheel_left_front, 0.05);
                 wb_motor_set_velocity(wheel_right_back, 0.05);
                 wb_motor_set_velocity(wheel_right_front, 0.05);              
                if N == 1
                    if ds_r <= distance | ds_l <= distance
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
        if A < -0.95 & B < 0.1
            wb_motor_set_velocity(wheel_left_back, -0.05);
            wb_motor_set_velocity(wheel_left_front, -0.05);
            wb_motor_set_velocity(wheel_right_back, -0.05);
            wb_motor_set_velocity(wheel_right_front, -0.05);
                if S == 1
                    if ds_r <= distance | ds_l <= distance
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
            if A > -0.1 & B < 0.95
                wb_motor_set_velocity(wheel_left_back, -0.05);
                wb_motor_set_velocity(wheel_left_front, -0.05);
                wb_motor_set_velocity(wheel_right_back, -0.05);
                wb_motor_set_velocity(wheel_right_front, -0.05);
                    if W == 1
                        brain = 0
                    end
            end
    case 8
            wb_motor_set_velocity(wheel_left_back, 0);
            wb_motor_set_velocity(wheel_left_front, 0);
            wb_motor_set_velocity(wheel_right_back, 0);
            wb_motor_set_velocity(wheel_right_front, 0); 

end

  %GPS navigate
  
x_y_z = wb_gps_get_values(GPS);
%disp(x_y_z)

X = x_y_z(1);
Z = x_y_z(3);
% %Finish position X
% if X1 - X <= 0.005 & X1 - X >= -0.005
%    brain = 8
%    position = 2
% end
% %Finish position Z
% if Z1 - Z <= 0.005 & Z1 - Z >= -0.005
%    brain = 8
%    position = 1
% end
% %Finish position
% 
% if Z1 - Z <= 0.005 & Z1 - Z >= -0.005 & X1 - X <= 0.005 & X1 - X >= -0.005
%    brain = 8
% end

switch position
    case 0
%Finish position X
if X1 - X <= 0.005 & X1 - X >= -0.005
   brain = 8;
   position = 2;
end
%Finish position Z
if Z1 - Z <= 0.005 & Z1 - Z >= -0.005
   brain = 8;
   position = 1;
end
%Finish position

if Z1 - Z <= 0.05 & Z1 - Z >= -0.05 & X1 - X <= 0.05 & X1 - X >= -0.05
   brain = 8;
end        
    case 1
        wb_motor_set_velocity(wheel_left_back, -1);
        wb_motor_set_velocity(wheel_left_front, -1);
        wb_motor_set_velocity(wheel_right_back, -1);
        wb_motor_set_velocity(wheel_right_front, -1);  
        if B < -0.95 & A < 0.1
            wb_motor_set_velocity(wheel_left_back, -0.05);
            wb_motor_set_velocity(wheel_left_front, -0.05);
            wb_motor_set_velocity(wheel_right_back, -0.05);
            wb_motor_set_velocity(wheel_right_front, -0.05);
            if E == 1
                brain = 0
                position = 0
            end
        end  
    case 2
        wb_motor_set_velocity(wheel_left_back, 1);
        wb_motor_set_velocity(wheel_left_front, 1);
        wb_motor_set_velocity(wheel_right_back, 1);
        wb_motor_set_velocity(wheel_right_front, 1);  
        if A < -0.95 & B < 0.1
            wb_motor_set_velocity(wheel_left_back, 0.05);
            wb_motor_set_velocity(wheel_left_front, 0.05);
            wb_motor_set_velocity(wheel_right_back, 0.05);
            wb_motor_set_velocity(wheel_right_front, 0.05);
                if S == 1
                    brain = 0
                    position = 0
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