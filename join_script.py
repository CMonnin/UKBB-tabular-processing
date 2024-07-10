import glob
import os
import re

import polars as pl


def file_converter(file):

    with open(file, "rb") as infile:
        data = infile.read()
        data_utf8 = data.decode("ISO-8859-1").encode("UTF-8")

    new_file = "converted" + file

    with open(new_file, "wb") as outfile:
        outfile.write(data_utf8)
    return new_file


def main():
    concat_df = pl.DataFrame()
    concat_schema_ids = (5, 6, 7, 8, 11, 12, 20)
    pattern = r"(?<=schema)\d+"

    for file in glob.glob(f"*.tsv"):
        print(file)
        if re.findall(pattern, file):
            schema_id = int(re.findall(pattern, str(file))[0])
            print(schema_id)
            if schema_id in concat_schema_ids:
                print("here")
                converted_file = file_converter(file)
                df = pl.scan_csv(converted_file, separator="\t").collect()
                df = df.select(
                    pl.col("value").cast(str),
                    pl.col("meaning").cast(str),
                )
                concat_df = pl.concat([concat_df, df])
                os.remove(converted_file)
                print(concat_df.head())
    codings_filename = "TestCodings.tsv"
    concat_df.write_csv(file=codings_filename, separator="\t")


if __name__ == "__main__":
    main()
