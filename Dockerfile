FROM linuxserver/ffmpeg:latest 

#RUN echo "deb https://repos.uclv.edu.cu/ubuntu bionic main restricted universe multiverse\n\
#deb https://repos.uclv.edu.cu/ubuntu bionic-updates main restricted universe multiverse\n\
#deb https://repos.uclv.edu.cu/ubuntu bionic-security main restricted universe multiverse\n\
#deb https://repos.uclv.edu.cu/ubuntu bionic-proposed main restricted universe multiverse\n\
#deb https://repos.uclv.edu.cu/ubuntu bionic-backports main restricted universe multiverse\n" > /etc/apt/sources.list

WORKDIR /usr/src/app
SHELL ["/bin/bash", "-c"]
RUN chmod 777 /usr/src/app

RUN apt-get -y update && DEBIAN_FRONTEND="noninteractive" \
    apt-get install -y --no-install-recommends python3 python3-pip aria2 qbittorrent-nox \
    tzdata p7zip-full p7zip-rar xz-utils curl pv jq \
    locales git unzip rtmpdump libmagic-dev libcurl4-openssl-dev \
    libssl-dev libc-ares-dev libsodium-dev libcrypto++-dev \
    libsqlite3-dev libfreeimage-dev libpq-dev libffi-dev \
    && locale-gen en_US.UTF-8 \
    && curl -L https://github.com/anasty17/megasdkrest/releases/download/latest/megasdkrest-amd64 -o /usr/local/bin/megasdkrest \
    && chmod +x /usr/local/bin/megasdkrest \
    && apt-get clean autoclean \
    && apt-get autoremove --yes \
    && rm -rf /var/lib/{apt,dpkg,cache,log}/

ENV LANG="en_US.UTF-8" LANGUAGE="en_US:en"

COPY requirements.txt .
RUN pip3 install --no-cache-dir -r requirements.txt

COPY . .

CMD ["bash", "start.sh"]
