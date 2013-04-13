#!/bin/sh

mkdir java_classes class_headers x86_64

ant -f build.xml 

javah -classpath java_classes -d ./class_headers org.openecard.scio.osx.PCSC org.openecard.scio.osx.PlatformPCSC

llvm-gcc -Os -fno-strict-aliasing -fPIC -W -Wall -Wno-unused -Wno-parentheses -pipe -m64 -fno-omit-frame-pointer -D_LITTLE_ENDIAN -D__sun_jdk -DNDEBUG -DARCH='"x86_64"' -Dx86_64 -D_ALLBSD_SOURCE -DRELEASE='"1.7.0"' -D_LARGEFILE64_SOURCE -D_GNU_SOURCE -D_REENTRANT -DMACOSX -D_LP64=1 -I./class_headers -I./src_solaris_javavm_export -I./src_share_javavm_export -I. -I./MUSCLE -I./src_share_native_common -I./src_solaris_native_common -c -o x86_64/pcsc.o pcsc.c

llvm-gcc -Os -fno-strict-aliasing -fPIC -W -Wall -Wno-unused -Wno-parentheses -pipe -m64 -fno-omit-frame-pointer -D_LITTLE_ENDIAN -D__sun_jdk -DNDEBUG -DARCH='"x86_64"' -Dx86_64 -D_ALLBSD_SOURCE -DRELEASE='"1.7.0"' -D_LARGEFILE64_SOURCE -D_GNU_SOURCE -D_REENTRANT -DMACOSX -D_LP64=1 -I./class_headers -I./src_solaris_javavm_export -I./src_share_javavm_export -I. -I./MUSCLE -I./src_share_native_common -I./src_solaris_native_common -c -o x86_64/pcsc_md.o pcsc_md.c

llvm-gcc -Xlinker -rpath -Xlinker @loader_path/. -Xlinker -install_name -Xlinker @rpath/libosxj2pcsc.dylib -Wl,-install_name,@rpath/libosxj2pcsc.dylib -dynamiclib -compatibility_version 1.0.0 -current_version 1.0.0 -ljvm -ljava -L./lib -L./lib/server -o libosxj2pcsc.dylib x86_64/pcsc.o x86_64/pcsc_md.o

rm -r java_classes class_headers x86_64
