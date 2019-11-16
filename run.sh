xhost +local:docker
docker run -it --rm --volume /tmp/.X11-unix:/tmp/.X11-unix --env DISPLAY=$DISPLAY --env RUNUSER_UID=$(id -u) --volume /opt/workspace:/workspace keener2u/wpilibvscode
