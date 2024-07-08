#!/bin/bash

schema_urls=(
"https://biobank.ndph.ox.ac.uk/ukb/scdown.cgi?fmt=txt&id=20"
"https://biobank.ndph.ox.ac.uk/ukb/scdown.cgi?fmt=txt&id=12"
"https://biobank.ndph.ox.ac.uk/ukb/scdown.cgi?fmt=txt&id=5"
"https://biobank.ndph.ox.ac.uk/ukb/scdown.cgi?fmt=txt&id=6"
"https://biobank.ndph.ox.ac.uk/ukb/scdown.cgi?fmt=txt&id=7"
"https://biobank.ndph.ox.ac.uk/ukb/scdown.cgi?fmt=txt&id=8"
"https://biobank.ndph.ox.ac.uk/ukb/scdown.cgi?fmt=txt&id=11"
)

for url in "${schema_urls[@]}"; do
  id=$(echo "$url" | grep -oP '(?<=id=)\d+')
  filename="schema${id}.txt"
  
  echo $url
  curl -o "$filename" "$url"

  echo "Downloaded schema ${id} to ${filename}"
done
