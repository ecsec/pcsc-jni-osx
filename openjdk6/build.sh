#!/bin/sh

mkdir java_classes class_headers i386 x86_64

JAVA_HOME="/System/Library/Frameworks/JavaVM.framework/Home" ant -f build.xml

/System/Library/Frameworks/JavaVM.framework/Commands/javah -classpath java_classes -d ./class_headers sun.security.smartcardio.PCSC sun.security.smartcardio.PlatformPCSC

llvm-gcc -Os -fno-strict-aliasing -fPIC -W -Wall -Wno-unused -Wno-parentheses -fno-omit-frame-pointer -arch i586 -D_LITTLE_ENDIAN -D__sun_jdk -Di586 -DARCH='"i586"' -D_ALLBSD_SOURCE -DRELEASE='"1.6.0"' -D_LARGEFILE64_SOURCE -D_GNU_SOURCE -D_REENTRANT -I./class_headers -I./src_solaris_javavm_export -I./src_share_javavm_export -I. -I./MUSCLE -I./src_share_native_common -I./src_solaris_native_common -I./src_solaris_javavm_include -I./src_share_javavm_include -c -o i386/pcsc.o pcsc.c

llvm-gcc -Os -fno-strict-aliasing -fPIC -W -Wall -Wno-unused -Wno-parentheses -fno-omit-frame-pointer -arch i586 -D_LITTLE_ENDIAN -D__sun_jdk -Di586 -DARCH='"i586"' -D_ALLBSD_SOURCE -DRELEASE='"1.6.0"' -D_LARGEFILE64_SOURCE -D_GNU_SOURCE -D_REENTRANT -I./class_headers -I./src_solaris_javavm_export -I./src_share_javavm_export -I. -I./MUSCLE -I./src_share_native_common -I./src_solaris_native_common -I./src_solaris_javavm_include -I./src_share_javavm_include -c -o i386/pcsc_md.o pcsc_md.c

llvm-gcc -Os -fno-strict-aliasing -fPIC -W -Wall -Wno-unused -Wno-parentheses -pipe -m64 -fno-omit-frame-pointer -D_LITTLE_ENDIAN -D__sun_jdk -DNDEBUG -DARCH='"amd64"' -Damd64 -D_ALLBSD_SOURCE -DRELEASE='"1.6.0"' -D_LARGEFILE64_SOURCE -D_GNU_SOURCE -D_REENTRANT -D_LP64=1 -I./class_headers -I./src_solaris_javavm_export -I./src_share_javavm_export -I. -I./MUSCLE -I./src_share_native_common -I./src_solaris_native_common -I./src_solaris_javavm_include -I./src_share_javavm_include -c -o x86_64/pcsc.o pcsc.c

llvm-gcc -Os -fno-strict-aliasing -fPIC -W -Wall -Wno-unused -Wno-parentheses -pipe -m64 -fno-omit-frame-pointer -D_LITTLE_ENDIAN -D__sun_jdk -DNDEBUG -DARCH='"amd64"' -Damd64 -D_ALLBSD_SOURCE -DRELEASE='"1.6.0"' -D_LARGEFILE64_SOURCE -D_GNU_SOURCE -D_REENTRANT -D_LP64=1 -I./class_headers -I./src_solaris_javavm_export -I./src_share_javavm_export -I. -I./MUSCLE -I./src_share_native_common -I./src_solaris_native_common -I./src_solaris_javavm_include -I./src_share_javavm_include -c -o x86_64/pcsc_md.o pcsc_md.c

llvm-gcc -arch i586 -Xlinker -rpath -Xlinker @loader_path/. -Xlinker -install_name -Xlinker @rpath/libj2pcsc.dylib -Wl,-install_name,@rpath/libj2pcsc.dylib -dynamiclib -compatibility_version 1.0.0 -current_version 1.0.0 -ljvm -ljava -L./lib_i386 -L./lib_i386/server -o i386/libj2pcsc.dylib i386/pcsc.o i386/pcsc_md.o

llvm-gcc -Xlinker -rpath -Xlinker @loader_path/. -Xlinker -install_name -Xlinker @rpath/libj2pcsc.dylib -Wl,-install_name,@rpath/libj2pcsc.dylib -dynamiclib -compatibility_version 1.0.0 -current_version 1.0.0 -ljvm -ljava -L./lib_x86_64 -L./lib_x86_64/server -o x86_64/libj2pcsc.dylib x86_64/pcsc.o x86_64/pcsc_md.o

lipo -create i386/libj2pcsc.dylib x86_64/libj2pcsc.dylib -output libj2pcsc.dylib

install_name_tool -change @rpath/libjava.dylib @rpath/libjava.jnilib libj2pcsc.dylib
install_name_tool -change @rpath/libjvm.dylib @rpath/libjvmlinkage.dylib libj2pcsc.dylib

rm -r i386 x86_64 java_classes class_headers
