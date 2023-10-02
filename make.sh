#!/usr/bin/env sh

#
# Contact $url_base and get all the pdf files you can get from there. Those
# are the notes for the UNIPV course named "Fisica 2". The pdfs are stored
# in a directory called `./parts`. Afterwards, they are sewn together into
# a unique pdf. The single pieces are always kept though.
#

[ -d ./pieces ] || mkdir ./pieces

cd ./pieces

url_base="http://columbia.qubit.it/video/fisica2-lectures-2020"
for i in $(seq -w 1 36); do  
  if wget -q -c -nc "$url_base/$i/$i.pdf"; then
    echo ":: downloaded: $i.pdf"
  else
    echo "!! cannot download: $i.pdf"
  fi
done

cd ..

[ -f fisica2.pdf ] && rm fisica2.pdf

if (which pdftk 2>&1) > /dev/null; then
  echo ":: creating fisica2.pdf... "
  pdftk ./pieces/*.pdf output fisica2.pdf
else
  echo "!! no pdftk!"
fi

