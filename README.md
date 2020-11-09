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


## Build Docker Image from Dockerfile

```sh
./build.sh
```

Default ROS_DISTRO is `melodic`.
If you want to use `kinetic` as ROS_DISTRO, use following command.

```sh
./build.sh kinetic
```