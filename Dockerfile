FROM ubuntu:18.04
ARG userid
ARG groupid
ARG username

# change apt mirror server to KR
RUN apt-get update && apt-get install ca-certificates -y
RUN sed -i 's/http\:\/\/archive.ubuntu.com/https\:\/\/ftp.kaist.ac.kr/g' /etc/apt/sources.list

# install essential package for build android
RUN apt-get update && apt-get install git-core gnupg flex bison build-essential zip curl zlib1g-dev gcc-multilib g++-multilib libc6-dev-i386 libncurses5 lib32ncurses5-dev x11proto-core-dev libx11-dev lib32z1-dev libgl1-mesa-dev libxml2-utils xsltproc unzip fontconfig python imagemagick -y

# install openjdk-8-jdk
RUN apt-get install openjdk-8-jre-headless openjdk-8-jre openjdk-8-jdk -y
# RUN mkdir -p /usr/lib/jvm/java-8-openjdk-amd64
# RUN curl -o jdk8.tgz https://android.googlesource.com/platform/prebuilts/jdk/jdk8/+archive/master.tar.gz \
# && tar -zxf jdk8.tgz linux-x86 \
# && mv linux-x86 /usr/lib/jvm/java-8-openjdk-amd64 \
# && rm -rf jdk8.tgz

# remove verifying checksum
RUN curl -o /usr/local/bin/repo https://storage.googleapis.com/git-repo-downloads/repo \
 && chmod a+x /usr/local/bin/repo

RUN groupadd -g $groupid $username \
 && useradd -m -u $userid -g $groupid $username \
 && echo $username >/root/username \
 && echo "export USER="$username >>/home/$username/.gitconfig
COPY gitconfig /home/$username/.gitconfig
RUN chown $userid:$groupid /home/$username/.gitconfig
ENV HOME=/home/$username
ENV USER=$username

ENTRYPOINT chroot --userspec=$(cat /root/username):$(cat /root/username) / /bin/bash -i

