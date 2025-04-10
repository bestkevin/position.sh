#!/usr/bin/env bash

#roscore
gnome-terminal --window -t "roscore" -x bash -c "roscore;exec bash;"
sleep 3

#launch mavros
gnome-terminal --window -t "mavros" -x bash -c "cd;cd ~/catkin_ws;source devel/setup.bash;roslaunch mavros px4.launch;exec bash;"
sleep 3

#launch vrpn_client_ros
gnome-terminal --window -t "vicon" -x bash -c "cd ~/catkin_ws;source devel/setup.bash;roslaunch vrpn_client_ros sample.launch server:=192.168.1.100;exec bash;"
sleep 3

#launch px4_posest
gnome-terminal --window -t "px4_posest" -x bash -c "cd ~/catkin_ws;source devel/setup.bash;roslaunch px4_posest monitor.launch type:=0;exec bash;"
sleep 3

#echo /vrpn_client_node/ld1/pose
gnome-terminal --window -t "/vrpn_client_node/ld1/pose" -x bash -c "cd ~/catkin_ws;rostopic echo /vrpn_client_node/ld1/pose;exec bash;"
sleep 3

#echo /mavros/state
gnome-terminal --window -t "/mavros/state" -x bash -c "cd ~/catkin_ws;rostopic echo /mavros/state;exec bash;"
sleep 3

#echo /mavros/vision_pose/pose
gnome-terminal --window -t "/mavros/vision_pose/pose" -x bash -c "cd ~/catkin_ws;rostopic echo /mavros/vision_pose/pose;exec bash;"
sleep 3

#echo /mavros/local_position/odom
gnome-terminal --window -t "/mavros/local_position/odom" -x bash -c "cd ~/catkin_ws;rostopic echo /mavros/local_position/odom;exec bash;"
sleep 3
