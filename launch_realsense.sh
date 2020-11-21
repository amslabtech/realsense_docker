#!/bin/bash

ROS_DISTRO=melodic
IMAGE_NAME=ghcr.io/amslabtech/realsense_ros:${ROS_DISTRO}
CONTAINER_NAME=realsense_ros
echo "IMAGE_NAME=${IMAGE_NAME}"
echo "CONTAINER_NAME=${CONTAINER_NAME}"

ROS_MASTER_URI="http://`hostname -I | cut -d' ' -f1`:11311"
ROS_IP=`hostname -I | cut -d' ' -f1`
LAUNCH=rs_camera.launch

if [ ! $# -eq 0 ]; then
    IP_CHECK=$(echo $1 | egrep "^(([1-9]?[0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])\.){3}([1-9]?[0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])$")
    if [ "${IP_CHECK}" ]; then
        ROS_MASTER_URI="http://$1:11311"
        if [ $# -ge 2 ]; then
            LAUNCH=${@:2}
        fi
    else
        LAUNCH=$@
    fi
fi

echo "ROS_MASTER_URI=${ROS_MASTER_URI}"
echo "ROS_IP=${ROS_IP}"
echo "LAUNCH=${LAUNCH}"

docker run -it --rm \
    --privileged \
    --gpus all \
    --volume="/dev:/dev" \
    --env ROS_MASTER_URI=${ROS_MASTER_URI} \
    --env ROS_IP=${ROS_IP} \
    --net="host" \
    --name $CONTAINER_NAME \
    $IMAGE_NAME \
    bash -c "roslaunch realsense2_camera ${LAUNCH}"
