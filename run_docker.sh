#!/bin/bash

IMAGE_NAME=realsense_docker:latest

docker run -it --rm \
  --privileged \
  --env=ROS_IP=$ROS_IP \
  --env=ROS_MASTER_URI=$ROS_MASTER_URI \
  --volume="/dev:/dev" \
  --net="host" \
  $IMAGE_NAME \
  bash -c "source /root/catkin_ws/devel/setup.bash; roslaunch realsense2_camera rs_rgbd.launch"
