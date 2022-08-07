#!/bin/sh

# small utility script to compile latex files to pdf with some sensible defaults
# for calling directly from other scripts

filename=$1

# color escape codes
red='\033[0;31m'
reset='\033[0m'

# - pdflatex outputs a wall of text so redirect stdout to /dev/null.
# - pdflatex by default runs in interactive mode, which is not desirable for
#   operations like compile on save hence using nonstopmode
stdout=$(pdflatex --interaction nonstopmode --file-line-error $filename)
compilation_status=$?

if [ $compilation_status -eq 0 ]; then
    echo "Compiled $1 succesfully"
else
    echo "$red Compilation failed... $reset"
fi
