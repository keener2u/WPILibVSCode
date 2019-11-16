FROM wpilib/gazebo-ubuntu:18.04
WORKDIR /opt
RUN apt-get update && apt-get install -y git libx11-xcb-dev libssl1.0-dev nodejs-dev npm
#INSTALL VSCODE
RUN curl -sSLf https://go.microsoft.com/fwlink/?LinkID=760868 > code.deb
RUN apt-get -y install ./code.deb
#INSTALL LINUX TOOLCHAIN
RUN curl -SL https://github.com/wpilibsuite/roborio-toolchain/releases/download/v2020-2/FRC-2020-Linux-Toolchain-7.3.0.tar.gz | sh -c 'mkdir -p /usr/local && cd /usr/local && tar xzf - --strip-components=2'
#INSTALL AND BUILD VSCODE PLUGIN
RUN mkdir vscode-plugin
RUN curl -sSLf https://github.com/wpilibsuite/vscode-wpilib/archive/v2020.1.1-beta-1.tar.gz | tar -C vscode-plugin --strip-components 1 -xzvf -
WORKDIR /opt/vscode-plugin
RUN ./gradlew build updateVersions updateAllDependencies
WORKDIR /opt/vscode-plugin/vscode-wpilib
RUN npm install
RUN npm run gulp
RUN npm run webpack
RUN npm run vscePackage
RUN cp *.vsix /opt/vscode-wpilib.vsix
WORKDIR /opt/vscode-plugin/wpilib-utility-standalone
RUN npm install
WORKDIR /opt
RUN mkdir frc-2020
RUN curl -sSLf https://github.com/wpilibsuite/allwpilib/archive/v2020.1.1-beta-1.tar.gz | tar -C frc-2020 --strip-components 1 -xzvf -
WORKDIR /opt/workspace
#RUN ./gradlew build -PmakeSim
#MAKE USER LOCAL AND INSTALL VSCODE EXTENSIONS
RUN useradd -c 'robouser' -m -d /home/robouser -s /bin/bash robouser
RUN chown -R robouser.robouser /opt
USER robouser
ENV HOME /home/robouser
RUN /usr/bin/code --install-extension /opt/vscode-wpilib.vsix
VOLUME ["/home/robouser"]
