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
RUN curl -sSLf https://api.github.com/repos/wpilibsuite/vscode-wpilib/releases/latest | grep browser_download_url.*vsix | cut -d '"' -f 4 | wget -qi - 
RUN cp *.vsix /opt/vscode-wpilib.vsix
WORKDIR /opt/vscode-plugin/wpilib-utility-standalone
RUN npm install
#INSTALL AND BUILD WPILIB LIBRARIES 
WORKDIR /opt
RUN mkdir frc-2020
RUN curl -sSLf https://github.com/wpilibsuite/allwpilib/archive/v2020.1.1-beta-2.tar.gz | tar -C frc-2020 --strip-components 1 -xzvf -
WORKDIR /opt/workspace
RUN git clone https://github.com/Team3128/3128-robot-2019.git
#RUN ./gradlew build -PmakeSim
#MAKE USER LOCAL AND INSTALL VSCODE EXTENSIONS
RUN useradd -c 'robouser' -m -d /home/robouser -s /bin/bash robouser
RUN chown -R robouser.robouser /opt
USER robouser
ENV HOME /home/robouser
RUN /usr/bin/code --install-extension /opt/vscode-wpilib.vsix
COPY settings.json /home/robouser/.config/Code/User/settings.json
VOLUME ["/home/robouser"]
