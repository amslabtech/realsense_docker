FROM osrf/ros:kinetic-desktop

RUN apt-get update

RUN apt-get install -y software-properties-common \ 
                       apt-utils \
					   wget && \
    rm -rf /var/lib/apt/lists/*

# librealsense
RUN apt-key adv --keyserver keys.gnupg.net --recv-key C8B3A55A6F3EFCDE || sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-key C8B3A55A6F3EFCDE

RUN apt-add-repository "deb http://realsense-hw-public.s3.amazonaws.com/Debian/apt-repo xenial main" -u

RUN apt-get update && \
    apt-get install -y librealsense2-dkms \
                       librealsense2-utils \
                       librealsense2-dev \
                       librealsense2-dbg && \
	rm -rf /var/lib/apt/lists/*

# ROS setting
WORKDIR /root

RUN /bin/bash -c "mkdir -p catkin_ws/src"

RUN cd catkin_ws/src && /bin/bash -c "source /opt/ros/kinetic/setup.bash; catkin_init_workspace"

RUN cd catkin_ws && /bin/bash -c "source /opt/ros/kinetic/setup.bash; catkin_make"

RUN cd /root && echo source /root/catkin_ws/devel/setup.bash >> .bashrc

ENV ROS_PACKAGE_PATH=/root/catkin_ws:$ROS_PACKAGE_PATH

ENV ROS_WORKSPACE=/root/catkin_ws

# realsense ros (2.2.3)
WORKDIR /root/catkin_ws/src

RUN git clone https://github.com/intel-ros/realsense -b 2.2.3

RUN cd /root/catkin_ws && /bin/bash -c "source /opt/ros/kinetic/setup.bash; catkin_make"

RUN apt-get update && \
    apt-get install -y ros-kinetic-rgbd-launch && \
	rm -rf /var/lib/apt/lists/*

WORKDIR /root

# nvidia
LABEL com.nvidia.volumes.needed="nvidia_driver"
ENV PATH /usr/local/nvidia/bin:${PATH}
ENV LD_LIBRARY_PATH /usr/local/nvidia/lib:/usr/local/nvidia/lib64:${LD_LIBRARY_PATH}

WORKDIR /root
