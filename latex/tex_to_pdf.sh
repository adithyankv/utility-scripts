#!/bin/sh

# small utility script to compile latex files to pdf with some sensible defaults
# for calling directly from other scripts. Formats the errors nicely as opposed
# to the default large wall of text

if [ $# -eq 0 ]; then
    echo "Error: Expected atleast one filename argument"
    exit 2
fi

filename=$1

# color escape codes
red='\033[0;31m'
reset='\033[0m'

# - pdflatex outputs a wall of text so redirect stdout to /dev/null.
# - pdflatex by default runs in interactive mode, which is not desirable for
#   operations like compile on save hence using nonstopmode
stdout=$(pdflatex --interaction nonstopmode --file-line-error $filename)
compilation_status=$?

# when given the file-line-error flag pdflatex outputs errors in
# filename:linenumber:error format which can be extracted using grep
errors=$(echo "$stdout"|grep "^.*:[0-9]*: .*$")

if [ $compilation_status -eq 0 ]; then
    echo "Compiled $1 succesfully"
else
    echo "$red Compilation failed... $reset"
    echo "$red $errors $reset"
fi
