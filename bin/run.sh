#!/bin/bash

# check if root run the script
if [ `id -u` = 0 ]
then
	echo "****************************************************"
	echo "*Error: root (the superuser) can't run this script.*"
	echo "****************************************************"	
	exit 1
fi

# determine base directory; preserve where you're running from
cd `dirname $0`
BASE=`pwd`

chmod +x $BASE -R

. $BASE/env.sh


main_class=$1
shift 1

echo_and_run() {
    echo ===================================
    echo Start run command: 
    echo "$@"
    echo ===================================
    "$@"
}

echo_and_run $JAVA_HOME/bin/java $JAVA_OPTS -cp $CLASS_PATH "$main_class" "$@"
