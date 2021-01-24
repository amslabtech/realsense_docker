# realsense_docker

## Prerequisites
- docker 19.03 or later

## How to Use

```sh
./launch_realsense.sh
```

Default launch file is `rs_camera.launch` .

If you want to use other launch file or set parameters, give it as an argument as follows.

```sh
./launch_realsense.sh rs_camera.launch align_depth:=true filters:=pointcloud
```

If you want to set ROS_MASTER_URI, git it an argument as follows.

```sh
./launch_realsense.sh 192.168.0.100 rs_camera.launch align_depth:=true filters:=pointcloud
```

## Build Docker Image from Dockerfile

```sh
docker build . -t realsense_ros --file Dockerfile
```

Default ROS_DISTRO is `noeitc`.
If you want to use `kinetic` or `melodic` as ROS_DISTRO, use following command.

```sh
# for kinetic
docker build . -t realsense_ros:kinetic --file Dockerfile --build-arg ros_distro=kinetic
# for melodic
docker build . -t realsense_ros:melodic --file Dockerfile --build-arg ros_distro=melodic
```
