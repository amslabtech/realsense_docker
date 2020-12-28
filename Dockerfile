ARG ros_distro=melodic
FROM ros:${ros_distro}-ros-base

SHELL ["/bin/bash", "-c"]

ENV DEBIAN_FRONTEND=noninteractive

ARG ros_distro
ENV ROS_DISTRO=${ros_distro}
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        ros-${ROS_DISTRO}-realsense2-camera \
        ros-${ROS_DISTRO}-image-transport* \
        ros-${ROS_DISTRO}-rgbd-launch && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN echo 'source /opt/ros/${ROS_DISTRO}/setup.bash && exec "$@"' \
    > /root/ros_entrypoint.sh

ENTRYPOINT ["bash", "/root/ros_entrypoint.sh"]
