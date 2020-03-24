# WPILibVSCode


# Mac How-to GUI Docker Run Setup:
## download XQuartz 2.7.11 and open it
# go to the XQuartz "Preferences" menu, go to "Security", and make sure the bottom checkbox is checked

# Script:
## xhost +127.0.0.1
## docker run -it --rm --volume /tmp/.X11-unix:/tmp/.X11-unix:ro --env DISPLAY=host.docker.internal:0 --env RUNUSER_UID=$(id -u) --mount source=vscode-vol,target=/home/robouser --volume /home/robouser/projects/.vscode keener2u/wpilibvscode
