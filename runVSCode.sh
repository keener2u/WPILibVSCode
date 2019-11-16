xhost +local:docker
docker run -it --rm --volume /tmp/.X11-unix:/tmp/.X11-unix --env DISPLAY=$DISPLAY --env RUNUSER_UID=$(id -u) --mount source=vscode-vol,target=/home/robouser --volume /home/matt/.vscode:/home/robouser/projects/.vscode keener2u/wpilibvscode
