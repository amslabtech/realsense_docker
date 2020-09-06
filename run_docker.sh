#!/bin/bash

IMAGE_NAME=realsense_docker:latest

xhost +

docker run -it --rm \
  --gpus all \
  --privileged \
  --env=QT_X11_NO_MITSHM=1 \
  --env=DISPLAY=$DISPLAY \
  --volume="/etc/group:/etc/group:ro" \
  --volume="/etc/passwd:/etc/passwd:ro" \
  --volume="/etc/shadow:/etc/shadow:ro" \
  --volume="/etc/sudoers.d:/etc/sudoers.d:ro" \
  --volume="/tmp/.X11-unix:/tmp/.X11-unix:rw" \
  --volume="/dev:/dev" \
  --net="host" \
  $IMAGE_NAME \
  bash -c "source /root/catkin_ws/devel/setup.bash;roslaunch realsense2_camera rs_rgbd.launch"
