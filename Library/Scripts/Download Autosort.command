#!/bin/bash


cd ~/Downloads

for f in *
do
  echo "Processing $f file..."
  source ~/.scripts/autosort_downloads "$f"
done
