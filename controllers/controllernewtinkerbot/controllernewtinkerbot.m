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
speed = 2
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
DS = wb_robot_get_device('ds');
wb_distance_sensor_enable(DS, TIME_STEP);

%GPS Settings
GPS = wb_robot_get_device('gps');
wb_gps_enable(GPS,TIME_STEP);

%Compas Settings
Compass = wb_robot_get_device('comp');
wb_compass_enable(Compass, TIME_STEP);

% main loop:
% perform simulation steps of TIME_STEP milliseconds
% and leave the loop when Webots signals the termination
%
m = 0
while wb_robot_step(TIME_STEP) ~= -1
distance = wb_distance_sensor_get_value(DS);
% disp(distance);
  
x_y_z = wb_gps_get_values(GPS);
% disp(x_y_z);

Site = wb_compass_get_values(Compass);
A = Site(1);
B = Site(3);
switch m
    case 0
            if distance < 80
                m = 1
            end
%             wb_motor_set_position(wheel_left_back, inf);
%             wb_motor_set_velocity(wheel_left_back, speed*2);
%             wb_motor_set_position(wheel_left_front, inf);
%             wb_motor_set_velocity(wheel_left_front, speed*2);
%             wb_motor_set_position(wheel_right_back, inf);
%             wb_motor_set_velocity(wheel_right_back, speed*2);
%             wb_motor_set_position(wheel_right_front, inf);
%             wb_motor_set_velocity(wheel_right_front, speed*2);
%             if Site(1) < 0.5
%                 m = 1
%             end
    case 1
            wb_motor_set_position(wheel_left_back, inf);
            wb_motor_set_velocity(wheel_left_back, speed*2);
            wb_motor_set_position(wheel_left_front, inf);
            wb_motor_set_velocity(wheel_left_front, speed*2);
            wb_motor_set_position(wheel_right_back, inf);
            wb_motor_set_velocity(wheel_right_back, speed*2);
            wb_motor_set_position(wheel_right_front, inf);
            wb_motor_set_velocity(wheel_right_front, speed*2);  
            if A < 0.5
                m = 2
            end
    case 2
     wb_motor_set_velocity(wheel_left_back,0);
     wb_motor_set_velocity(wheel_left_front,0);
     wb_motor_set_velocity(wheel_right_back, 0);
     wb_motor_set_velocity(wheel_right_front, 0);
end
     %wb_motor_set_velocity(wheel_left_back,-2);
     %wb_motor_set_velocity(wheel_left_front,-2);
     %wb_motor_set_velocity(wheel_right_back, 2);
     %wb_motor_set_velocity(wheel_right_front, 2);

  
  % read the sensors, e.g.:
  %  rgb = wb_camera_get_image(camera);

  % Process here sensor data, images, etc.

  % send actuator commands, e.g.:
  %  wb_motor_set_postion(motor, 10.0);

  % if your code plots some graphics, it needs to flushed like this:
  drawnow;

end

% cleanup code goes here: write data to files, etc.
