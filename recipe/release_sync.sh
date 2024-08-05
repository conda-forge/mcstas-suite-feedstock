#!/usr/bin/env bash
#
# This small utility-script executes curl and openssl to figure out
# a new hash for a given McCode release. Please execute
# ./release_sync x.y.z
# and the resulting sha and versioning is written to stdout

# Check that we are getting input

if [ "x$1" = "x" ]; then
    # No arguments
    echo Please provide a version-argument,e.g : $0 3.5.999
    exit 1;
fi

VERSION=$1
URL="https://github.com/McStasMcXtrace/McCode/archive/v${VERSION}.tar.gz"
SHA=`curl -sL ${URL} | openssl sha256`

OLDVERSION=`grep set\ version\ =  meta.yaml | cut -f  2 -d\"`
OLDSHA=`grep sha256: meta.yaml | cut -f2- -d: | sed s/\ //g`

echo Attempting to replace $OLDVERSION by $VERSION and
echo $OLDSHA by
echo $SHA
echo

VREPLACE="s/${OLDVERSION}/${VERSION}/g"
SREPLACE="s/${OLDSHA}/${SHA}/g"

sed -i.bak ${VREPLACE} meta.yaml
sed -i.bak ${SREPLACE} meta.yaml

rm *bak

	       
