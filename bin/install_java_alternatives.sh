#!/bin/sh
if [ $# -ne 2 ]; then
	echo "Usage: $0 java_dir prio";
	exit 1;
fi

dir=$1
prio=$2

cmd="update-alternatives --install /usr/bin/java java $dir/bin/java $prio"

for binary in `ls -1 $dir/bin`; do 
	if [ "java" == $binary ]; then
		continue;
	fi

	if [ ! -f $dir/bin/$binary ]; then
		continue; # prevent symlinks
	fi

	cmd="$cmd --slave /usr/bin/$binary $binary $dir/bin/$binary"
done

$cmd

if [ -f $dir/jre/lib/i386/libnpjp2.so ]; then
	plugin=$dir/jre/lib/i386/libnpjp2.so
else
	plugin=$dir/jre/plugin/i386/ns7/libjavaplugin_oji.so
fi

cmd="update-alternatives --install /usr/lib/browser-plugins/javaplugin.so javaplugin $plugin $prio"

$cmd
