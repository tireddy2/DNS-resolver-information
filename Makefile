DRAFT:=draft-add-server-selection-information
VERSION:=$(shell ./getver ${DRAFT}.xml )
EXAMPLES=

${DRAFT}-${VERSION}.txt: ${DRAFT}.txt
	cp ${DRAFT}.txt ${DRAFT}-${VERSION}.txt
	: git add ${DRAFT}-${VERSION}.txt ${DRAFT}.txt

%.txt: %.xml
	unset DISPLAY; XML_LIBRARY=$(XML_LIBRARY):./src xml2rfc $? $@

%.html: %.xml
	unset DISPLAY; XML_LIBRARY=$(XML_LIBRARY):./src xml2rfc --html -o $@ $?

submit: ${DRAFT}.xml
	curl -S -F "user=mcr+ietf@sandelman.ca" -F "xml=@${DRAFT}.xml" https://datatracker.ietf.org/api/submit

version:
	echo Version: ${VERSION}

clean:
	-rm -f ${DRAFT}.xml

.PRECIOUS: ${DRAFT}.xml
