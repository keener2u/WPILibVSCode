FROM wpilib/gazebo-ubuntu:18.04
WORKDIR /opt
RUN apt-get update && apt-get install -y git libx11-xcb-dev libssl1.0-dev nodejs-dev npm
RUN curl -sSLf https://go.microsoft.com/fwlink/?LinkID=760868 > code.deb
/bin/sh -c curl -SL https://github.com/wpilibsuite/roborio-toolchain/releases/download/v2020-2/FRC-2020-Linux-Toolchain-7.3.0.tar.gz | sh -c 'mkdir -p /usr/local && cd /usr/local && tar xzf - --strip-components=2'
RUN apt-get -y install ./code.deb
RUN mkdir vscode-plugin
RUN curl -sSLf https://github.com/wpilibsuite/vscode-wpilib/archive/v2020.1.1-beta-1.tar.gz | tar -C vscode-plugin --strip-components 1 -xzvf -
WORKDIR /opt/vscode-plugin/vscode-wpilib
RUN npm install
WORKDIR /opt/vscode-plugin/wpilib-utility-standalone
RUN npm install
WORKDIR /opt/vscode-plugin
RUN ./gradlew updateAllDependencies
WORKDIR /opt
RUN mkdir frc-2020
RUN curl -sSLf https://github.com/wpilibsuite/allwpilib/archive/v2020.1.1-beta-1.tar.gz | tar -C frc-2020 --strip-components 1 -xzvf -
WORKDIR frc-2020
RUN ./gradlew build -PmakeSim
RUN useradd -c 'robouser' -m -d /home/robouser -s /bin/bash robouser
RUN chown -R robouser.robouser /opt
USER robouser
ENV HOME /home/robouser
