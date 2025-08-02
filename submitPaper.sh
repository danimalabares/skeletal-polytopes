#!/bin/bash
# !/bin/bash
POSITIONAL=()
img="source"
src="source"
main="main.tex"
imgE="pdf"
out=$(realpath "./")
poor=true
delDir=true

#parse options
while [[ $# -gt 0 ]]
do
key="$1"

case $key in
    -h|--help)
    echo "Usage: submit -m (--main) <mainfile.tex> [-i (--img) <img_dir>] [-s (--source) <source_dir>] [-e (--img_ext) <img_extension>] [-o (--output) <output-dir>] [-p (--poorman) If given, poorman is skipped] [-k (-keepdir) If given, the directory is kept]"
    exit
    shift # past argument
    shift # past value
    ;;
    -m|--main)
    main="$2"
#     OUTPUT="$2"
    shift # past argument
    shift # past value
    ;;
    -i|--img)
    img="$2"
    shift # past argument
    shift # past value
    ;;
    -s|--source)
    src="$2"
    shift # past argument
    shift # past value
    ;;
    -e|--img_ext)
    imgE="$2"
    shift # past argument
    shift # past value
    ;;
    -o|--output)
    out="$2"
    shift # past argument
    shift # past value
    ;;
    -p|--poorman)
    poor=false
#     poorFlag= 1
    shift # past argument
    # shift # past value
    ;;
    -k|--keepdir)
    delDir=false
#     poorFlag= 1
    shift # past argument
    # shift # past value
    ;;
    *)    # unknown option
    POSITIONAL+=("$1") # save it in an array for later
    shift # past argument
    ;;
esac
done
set -- "${POSITIONAL[@]}" # restore positional parameters

echo $out
echo $main
echo $img
echo $src
if  [ "$poor" = true ] ; then
    echo "poor is true"
fi
if  [ "$delDir" = true ] ; then
    echo "delDir is true"
fi
create the directories and copy files
name=${main%.*}
echo $name
folder=$name-$(date "+%y%m%d_%H%M%S")
echo $folder
mkdir $out/$folder
echo "se creo folder"
mkdir $out/$folder/repo
echo "se creo folder/repo"
cp -r ./* $out/$folder/repo
echo "se copio el repo"
repo="$out/$folder/repo"
echo $repo
cd $repo
if [ "$poor" = true ]; then
   pdflatex  -interaction=nonstopmode  $main
   latexmk  -interaction=nonstopmode -usepretex='\PassOptionsToPackage{poorman}{cleveref}\makeatletter\disable@package@load{hyperref}{}\makeatother' -pdflatex='touch %D; pdflatex -draftmode   %O %P' $main
    echo "creating poorman"
fi

latexpand $main -o $out/$folder/$main
##[]
##Moving images
cd $repo/$img

for f in *.$imgE
do
    echo 'Moving ' $f;
    cp $f $out/$folder/
done
#
# #changing paths
sed -i'' -e "s|\\graphicspath{{.\/$img\/}}|\\graphicspath{{.\/}}|" "$out/$folder/$main"
# sed -i "s|\newcommand{\src}{./$src}|\newcommand{\src}{.}|" "/tmp/$folder/$main"
#moving bib
cd $repo/$src
pwd
for f in *.bib
do
    echo 'Moving ' $f;
    cp $f $out/$folder/
    sed -i'' -e "s|$src\/$f|$f|" "$out/$folder/$main"
done
#
cd $repo
#poorman on final
if [ "$poor" = true ]; then
    echo "poorman on final"
    mv $out/$folder/$main $out/$folder/$main.rich
    sed -f $repo/$name.sed $out/$folder/$main.rich > $out/$folder/$main
fi
echo "Cleaning up"
rm -rf $repo
rm $out/$folder/$main.rich
rm $out/$folder/$main-e
echo 'All done'

echo "Zippppppping"
cd $out
zip -r $folder.zip $folder
if [ "$delDir" = true ]; then
    rm -rf $folder
fi

