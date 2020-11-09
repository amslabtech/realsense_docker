#!/bin/sh

ROS_DISTRO=melodic
IMAGE_NAME=ghcr.io/amslabtech/realsense_ros:${ROS_DISTRO}
CONTAINER_NAME=realsense_ros
echo "IMAGE_NAME=${IMAGE_NAME}"
echo "CONTAINER_NAME=${CONTAINER_NAME}"

ROS_MASTER_URI="http://`hostname -I | cut -d' ' -f1`:11311"
ROS_IP=`hostname -I | cut -d' ' -f1`
echo "ROS_MASTER_URI=${ROS_MASTER_URI}"
echo "ROS_IP=${ROS_IP}"

if [ $# -eq 0 ]; then
    LAUNCH=rs_camera.launch
else
    LAUNCH=$1
fi

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