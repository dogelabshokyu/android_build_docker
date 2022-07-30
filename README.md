# Ubuntu 14.04 (Trusty) with OpenJDK 7
## This image support Android 5.x(Lollipop) - Android 6.0 (Marshmallow)
### you can check original code at http://android.googlesource.com/platform/build/+/master/tools/docker

First, build the image:
```
# Copy your host gitconfig, or create a stripped down version
$ cp ~/.gitconfig gitconfig
$ docker build --build-arg userid=$(id -u) --build-arg groupid=$(id -g) --build-arg username=$(id -un) -t android-build-trusty-openjdk-7 .
```

Then you can start up new instances with:
```
$ docker run -it --rm -v $(pwd):/src android-build-trusty-7
> cd /src; source build/envsetup.sh
> lunch aosp_arm-eng
> m -j50 
```
