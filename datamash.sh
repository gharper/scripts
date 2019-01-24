#!/usr/bin/env bash

# Uses https://www.gnu.org/software/datamash/

DATA=$(printf "%s\t%d\n" a 1 b 2 a 3 b 4 a 3 a 6)

echo "First value of each group"
echo "$DATA" | datamash -s -g 1 first 2

echo "Last value of each group"
echo "$DATA" | datamash -s -g 1 last 2

echo "Count values in each group"
echo "$DATA" | datamash -s -g 1 count 2

echo "Collapse all values in each group"
echo "$DATA" | datamash -s -g 1 collapse 2

echo "Collapse unique values in each group"
echo "$DATA" | datamash -s -g 1 unique 2

echo "Print a random value from each group"
echo "$DATA" | datamash -s -g 1 rand 2

echo "Combine multiple operations"
echo "$DATA" | datamash -s -g1 --header-out count 2 collapse 2 sum 2 mean 2 | expand -t 18

echo "Simple statistical summary"
echo "$DATA" | datamash min 2 q1 2 median 2 mean 2 q3 2 max 2

echo "A simple summary of the data, with grouping"
echo "$DATA" | datamash -s --header-out -g 1 min 2 q1 2 median 2 mean 2 q3 2 max 2 | expand -t 18

echo "Reverse & transpose"
echo "$DATA" | datamash reverse
echo "$DATA" | datamash transpose
