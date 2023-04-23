# Ubuntu 18.04 (Bionic) with OpenJDK 8
## This image support Android 7.0 (Nougat) - Android 8.0 (Oreo)
### you can check original code at http://android.googlesource.com/platform/build/+/master/tools/docker

First, build the image:
```
# Copy your host gitconfig, or create a stripped down version
$ cp ~/.gitconfig gitconfig
$ docker build --build-arg userid=$(id -u) --build-arg groupid=$(id -g) --build-arg username=$(id -un) -t android-build-bionic-openjdk-8 .
```

Then you can start up new instances with:
```
$ docker run -it --rm -v $(pwd):/src android-build-bionic-openjdk-8
> cd /src; source build/envsetup.sh
> lunch aosp_arm-eng
> m -j50 
```
