BASNAM=`basename $1 .md`
pandoc -s -o ${BASNAM}.pdf "$1"