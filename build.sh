#!/bin/sh

if [ $# -eq 0 ]; then
    ROS_DISTRO=melodic
else
    ROS_DISTRO=$1
fi

IMAGE_NAME=realsense_ros

docker build . \
    --file Dockerfile \
    --tag ${IMAGE_NAME}:${ROS_DISTRO} \
    --build-arg ros_distro=${ROS_DISTRO}
