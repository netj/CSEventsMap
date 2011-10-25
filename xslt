#!/usr/bin/env bash
# Author: Jaeho.Shin@Stanford.EDU
# Created: 2011-10-25
set -eu

XSLT=$1; shift
In=${1:--}; shift || true
Out=${1:--}; shift || true

# XXX need to lift entityExpansionLimit, see: http://download.oracle.com/javase/1.5.0/docs/guide/xml/jaxp/JAXP-Compatibility_150.html#JAXP_security
java -Xmx2g -Xms200m \
    -DentityExpansionLimit=10000000 \
    -jar /opt/local/share/java/saxon8.jar -s "$In" "$XSLT" |
xmllint --format --encode utf-8 "$Out"
