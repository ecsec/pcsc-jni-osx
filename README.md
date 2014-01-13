OpenJDK PCSC Binding for OSX
============================

This repository contains a patched version of the PCSC JNI Binding needed in
the SmartcardIO. It fixes the SCardControl command which received an interface
change in OSX, but was not adapted correctly in the JDK.

This version contains fixes based on OpenJDK 6 and 7. Additionally a modified
SmartcardIO factory package is provided for each JDK version.


Build instructions
==================

The requirements for the build are:

* JDK
* Apache Ant
* OSX Developer Tools

The build can be triggered by the build.sh shell script in the root directory.

    $ ./build.sh

This executes the build script contained in each of the openjdkX directories.
