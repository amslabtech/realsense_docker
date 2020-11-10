FROM ros:melodic-ros-base

# librealsense
RUN apt-get update && apt-get install --no-install-recommends -y \
    apt-utils \
    wget \
    git \
    libssl-dev \
    libusb-1.0-0-dev \
    pkg-config \
    libgtk-3-dev \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*

WORKDIR root

RUN git clone https://github.com/IntelRealSense/librealsense.git

RUN apt-get update && apt-get install --no-install-recommends -y \
    libglfw3-dev \
    libgl1-mesa-dev \
    libglu1-mesa-dev \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*

WORKDIR /root/librealsense

# RUN mkdir -p /etc/udev/rules.d/
#
# RUN ./scripts/setup_udev_rules.sh
#
# WORKDIR /root/librealsense/scripts
#
# RUN ./patch-arch.sh
#
# WORKDIR /root/librealsense

RUN mkdir build

WORKDIR /root/librealsense/build

RUN cmake ../

RUN make && make install

# for realsense-ros
WORKDIR /root

RUN mkdir -p catkin_ws/src

WORKDIR /root/catkin_ws/src

RUN git clone https://github.com/IntelRealSense/realsense-ros.git -b 2.2.17

WORKDIR /root/catkin_ws

RUN apt-get update && apt-get install --no-install-recommends -y \
    python-catkin-tools \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*

RUN apt-get update && apt-get install --no-install-recommends -y \
        ros-melodic-rgbd-launch \
 && /bin/bash -c "source /opt/ros/melodic/setup.bash; \
                  rosdep install -i -y --from-paths src; \
                  catkin build" \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*


