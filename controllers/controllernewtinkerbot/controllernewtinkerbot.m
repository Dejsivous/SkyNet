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
wheel_left_front = wb_robot_get_device('wheel_left_front');
wheel_left_back = wb_robot_get_device('wheel_left_back');
wheel_right_front = wb_robot_get_device('wheel_right_front');
wheel_right_back = wb_robot_get_device('wheel_right_back');

DS = wb_robot_get_device('ds')

wb_motor_set_position(wheel_left_front, inf);
wb_motor_set_velocity(wheel_left_front, -1);
wb_motor_set_position(wheel_left_back, inf);
wb_motor_set_velocity(wheel_left_back, -1);
wb_motor_set_position(wheel_right_front, inf);
wb_motor_set_velocity(wheel_right_front, 1);
wb_motor_set_position(wheel_right_back, inf);
wb_motor_set_velocity(wheel_right_back, 1);

wb_distance_sensor_enable(DS, TIME_STEP)
%GPS Settings
GPS = wb_robot_get_device('gps')
wb_gps_enable(GPS,TIME_STEP)

% main loop:
% perform simulation steps of TIME_STEP milliseconds
% and leave the loop when Webots signals the termination
%
while wb_robot_step(TIME_STEP) ~= -1
  distance = wb_distance_sensor_get_value(DS)
  disp(distance)
  
x_y_z = wb_gps_get_values(GPS)
disp(x_y_z)
  
  if distance < 80
  
    wb_motor_set_velocity(wheel_left_back, 0);
    wb_motor_set_velocity(wheel_left_front, 0);
    wb_motor_set_velocity(wheel_right_back, 0);
    wb_motor_set_velocity(wheel_right_front, 0);
   else
     wb_motor_set_velocity(wheel_left_back,-2);
     wb_motor_set_velocity(wheel_left_front,-2);
     wb_motor_set_velocity(wheel_right_back, 2);
     wb_motor_set_velocity(wheel_right_front, 2);
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
