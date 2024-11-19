FROM jenkins/jenkins:lts

USER root

# Docker 설치에 필요한 패키지 설치
RUN apt-get update && \
    apt-get -y install \
    ca-certificates \
    curl \
    gnupg \
    lsb-release

# Docker의 공식 GPG key 추가
RUN curl -fsSL https://download.docker.com/linux/debian/gpg | gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

# Docker repository 추가
RUN echo \
    "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/debian \
    $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null

# Docker 설치
RUN apt-get update && \
    apt-get -y install docker-ce docker-ce-cli containerd.io

# jenkins 유저를 docker 그룹에 추가
RUN usermod -aG docker jenkins

USER jenkins
