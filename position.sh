#!/usr/bin/env bash

# 终止已有的ros_session会话（如果存在）
tmux kill-session -t ros_session 2>/dev/null

# 创建新会话并初始化第一个窗口（nodes窗口）
tmux new-session -d -s ros_session -n nodes
tmux send-keys -t ros_session:nodes.0 'roscore' C-m
sleep 3

# 分割窗口并启动mavros节点
tmux split-window -v -t ros_session:nodes.0
tmux send-keys -t ros_session:nodes.1 'cd ~/catkin_ws && source devel/setup.bash && roslaunch mavros px4.launch' C-m
sleep 3

# 分割窗口并启动vrpn_client_ros节点
tmux split-window -v -t ros_session:nodes.1
tmux send-keys -t ros_session:nodes.2 'cd ~/catkin_ws && source devel/setup.bash && roslaunch vrpn_client_ros sample.launch server:=192.168.1.100' C-m
sleep 3

# 分割窗口并启动px4_posest节点
tmux split-window -v -t ros_session:nodes.2
tmux send-keys -t ros_session:nodes.3 'cd ~/catkin_ws && source devel/setup.bash && roslaunch px4_posest monitor.launch type:=0' C-m
sleep 3

# 优化nodes窗口布局
tmux select-layout -t ros_session:nodes tiled

# 创建第二个窗口（topics窗口）并监听话题
tmux new-window -t ros_session -n topics
tmux send-keys -t ros_session:topics.0 'cd ~/catkin_ws && source devel/setup.bash && rostopic echo /vrpn_client_node/ld1/pose' C-m

tmux split-window -v -t ros_session:topics.0
tmux send-keys -t ros_session:topics.1 'cd ~/catkin_ws && source devel/setup.bash && rostopic echo /mavros/state' C-m

tmux split-window -v -t ros_session:topics.1
tmux send-keys -t ros_session:topics.2 'cd ~/catkin_ws && source devel/setup.bash && rostopic echo /mavros/vision_pose/pose' C-m

tmux split-window -v -t ros_session:topics.2
tmux send-keys -t ros_session:topics.3 'cd ~/catkin_ws && source devel/setup.bash && rostopic echo /mavros/local_position/odom' C-m

# 优化topics窗口布局
tmux select-layout -t ros_session:topics tiled

# 附加到tmux会话以便交互
tmux attach-session -t ros_session

gnome-terminal --window -t "/mavros/local_position/odom" -x bash -c "cd ~/catkin_ws;rostopic echo /mavros/local_position/odom;exec bash;"
sleep 3
