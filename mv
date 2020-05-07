#!/bin/bash

files=($(awk -F'[<>]' '/<members>/{print $3}' package.xml))  #Create an array of filenames based on the package.xml

if (( !${#files[@]} )); then
    echo "No Files in Package.xml"
    exit
fi

cd classes #go inside the classes folder

arrayFiles=() #create an empty array for the list of class files inside the classes folder

for filename in *.cls; do #change .cls to other extension
    arrayFiles=(${arrayFiles[@]} "${filename%.*}")  #insert class files into empty array
done

if (( !${#arrayFiles[@]} )); then
    echo "No Files in the folder"
    exit
fi

declare -A map
for key in "${!files[@]}"; do map[${files[$key]}]="$key"; done ## convert array into associate array example: "calculatorServices" => "calculatorServices"

for a in ${arrayFiles[@]}; do
   [[ -n "${map[$a]}" ]] && arrayFiles=("${arrayFiles[@]/$a}") #delete an element in the array of class files inside the classes folder
done
 
mkdir ../classes_tmp #create tmp folder

for a in ${arrayFiles[@]}; do
    mv "$a.cls" "$a.cls-meta.xml" ../classes_tmp #move files to tmp folder
    #change .cls and cls-meta.xml for other file extension (visual force pages)
done

