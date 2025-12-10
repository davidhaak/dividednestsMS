#!/bin/bash

conda activate fastqtools

reads=/data1/haak_lab/maddie_data/gsc-pickup.flsi.vt.edu/Hallerman_April2023/

output=/data1/haak_lab/maddie_data/interleaved

for file in ${reads}*R1*.fastq
    do
        withpath="${file}"
        filename="${withpath##*/}"
        basebwa="${filename%*_*_*_*.fastq}"
   
       echo "${withpath}"
       echo "${filename}"
      echo "${basebwa}"

     reformat.sh in1=$reads/"${basebwa}"_L001_R1_001.fastq in2=$reads/"${basebwa}"_L001_R2_001.fastq out="${output}"/"${basebwa}"_interleaved.fq
     reformat.sh in=$output/"${basebwa}"_interleaved.fq out=$output/"${basebwa}"_interleaved.fa
     bbmerge.sh in=$output/"${basebwa}"_interleaved.fa out=$output/"${basebwa}"_merged.fa adapters=adapters.fa

done
