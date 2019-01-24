#!/usr/bin/env bash

# Uses https://joeyh.name/code/moreutils/

printf "\nchronic: runs a command quietly unless it fails\n"
printf "\tnchronic noisyscript.sh"

printf "\ncombine: combine the lines in two files using boolean operations\n"
printf "\tcombine file1 and file2\n"
printf "\tcombine file1 not file2\n"
printf "\tcombine file1 or file2\n"
printf "\tcombine file1 xor file2\n"

printf "\nerrno: look up errno names and descriptions\n"
printf "\terrno 2\n"
printf "\terrno -l\n"

printf "\nifdata: get network interface info without parsing ifconfig output\n"
printf "\tifdata -p en0\n"
printf "\tifdata -pa en0 \t# ipv4 address\n"
printf "\tifdata -pn en0 \t# netmask\n"

printf "\nifne: run a program if the standard input is not empty\n"
printf "\tfind . -name core | ifne mail -s 'Core files found' root\n"

printf "\nisutf8: check if a file or standard input is utf-8\n"

printf "\nparallel: run multiple jobs at once\n"
printf "\tparallel sh -c 'echo hi; sleep 2; echo bye' -- 1 2 3\n"

printf "\npee: tee standard input to pipes\n"
printf "\techo 'Hello World' | tee file1 file2 \t# Standard use of tee\n"
printf "\techo 'Hello World' | pee cat cat \t# Like tee, but pipe to another command\n"

printf "\nsponge: soak up standard input and write to a file\n"
printf "\tsort file1 > file1_sorted \t# Normally would need to write to a new file\n"
printf "\tsort file1 | sponge file1 \t# Writes back to same file\n"

printf "\nts: timestamp standard input\n"
printf "\tping -c 2 localhost | ts\n"

printf "\nvidir: edit a directory in your text editor\n"
printf "\t# Deleting lines = deleting files, editing lines = renaming or moving, etc\n"

printf "\nvipe: insert a text editor into a pipe\n"
printf "\techo 'Hello World' | vipe\n \t# Lets you edit the pipe data mid stream"

printf "\nzrun: automatically uncompress arguments to command\n"
printf "\t# A quick way to run a command that does not itself support compressed files, without manually uncompressing the files\n"
