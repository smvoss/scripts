#!/bin/sh

if [ $# -ne 2 ]; then
	echo "Usage: $0 JDK_HOME CERTIFICATE"
	exit
fi

JDK=$1
CERT=$2

$JDK/bin/keytool -importcert -keystore $JDK/jre/lib/security/cacerts -file $2

