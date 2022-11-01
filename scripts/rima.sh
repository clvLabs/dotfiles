#!/bin/sh
WORDS=$(grep -r --color=always ${1}$ /usr/share/dict/spanish | tr '\n' ' ')
RAWWORDS=$(grep -r ${1}$ /usr/share/dict/spanish | tr '\n' ' ')
WORDCOUNT=$(grep -r --color=always ${1}$ /usr/share/dict/spanish | wc -w)

echo "${WORDS}" | sed "s/ /\n/g"
# echo "${WORDS}\n\nTotal ${1}: ${WORDCOUNT}"

if [ "${2}" = --defs ]; then
    echo ""
    for WORD in ${RAWWORDS}
    do
        echo "----[ ${WORD}"
        rae ${WORD}
    done
fi
