#!/usr/bin/env sh

# Download all the parts needed.
url_base="http://columbia.qubit.it/video/fisica2-lectures-2020"
for i in {01..36}; do
  echo -n "trying to reach $url_base/$i/$i.pdf... "
  wget -q "$url_base/$i/$i.pdf"
  if [ $? == 0 ]
    then echo "downloaded: $i.pdf"
    else echo "cannot download: $i.pdf"
  fi
done

# Remove fisica2.pdf is it exists.
[ -f fisica2.pdf ] && rm -rf fisica2.pdf

# The retrieved pdfs are named from 01.pdf to 36.pdf. This is fine
# for the following command.
echo -n "creating fisica2.pdf... "
pdftk *.pdf output fisica2.pdf
[ $? == 0 ] && echo "OK!"

# After the merge, remove all the pieces used to create fisica2.pdf.
echo -n "cleaning... "
ls -1 | grep -P '^\d\d\.pdf$' | xargs rm -rf
echo "END!"

