#!/bin/sh

fail=false

curl -sS -X POST -F "File=@$1" https://www.pdf-online.com/osa/validate.aspx > /tmp/pdfa_validation.json
if grep -F "The document does conform to the PDF/A-" "/tmp/pdfa_validation.json"
then
    echo "$1 validated successful"
else
    fail=true
    1>&2 echo
    1>&2 echo "1 VALIDATION FAILED"
    1>&2 cat /tmp/pdfa_validation.json
fi

if [ "$fail" = true ] ; then
	1>&2 echo
	1>&2 echo
	1>&2 echo "Validation of at least one pdf failed. Exiting with 1"
	exit 1
fi
