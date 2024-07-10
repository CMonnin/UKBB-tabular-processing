#!/bin/bash
concat_schema_ids=(5,6,7,8,11,12,20)
schema_urls=(
"https://biobank.ndph.ox.ac.uk/ukb/scdown.cgi?fmt=txt&id=1"  # Data field properties
"https://biobank.ndph.ox.ac.uk/ukb/scdown.cgi?fmt=txt&id=5"  # Values for simple integer encodings
"https://biobank.ndph.ox.ac.uk/ukb/scdown.cgi?fmt=txt&id=6"  # Values for simple string encodings
"https://biobank.ndph.ox.ac.uk/ukb/scdown.cgi?fmt=txt&id=7"  # Values for simple real (floating-point encodings)
"https://biobank.ndph.ox.ac.uk/ukb/scdown.cgi?fmt=txt&id=8"  # Values for simple data encodings
"https://biobank.ndph.ox.ac.uk/ukb/scdown.cgi?fmt=txt&id=11" # Values for hierarchical string encodings
"https://biobank.ndph.ox.ac.uk/ukb/scdown.cgi?fmt=txt&id=12" # Values for hierarchical string encodings
"https://biobank.ndph.ox.ac.uk/ukb/scdown.cgi?fmt=txt&id=13" # Catgegory browse tree structure
"https://biobank.ndph.ox.ac.uk/ukb/scdown.cgi?fmt=txt&id=20" # Values for simple time encodings
)

codings_filename='TestCodings.tsv'

for url in "${schema_urls[@]}"; do
  id=$(echo "$url" | grep -oP '(?<=id=)\d+')
  filename="schema${id}.tsv"
  
  echo $url
  curl -o "$filename" "$url"

  echo "Downloaded schema ${id} to ${filename} "

#  if echo "${concat_schema_ids}" | grep -q "${id}"; then
#    cat $filename >> $codings_filename
#    echo "appended ${filename} to ${codings_filename}"
#  fi

done

echo "Downloads complete. Some files concatenated to $codings_filename"

