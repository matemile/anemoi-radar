#!/bin/bash
#$ -N MMMmem_radar5m_v2
#$ -j y
#$ -b n
#$ -S /bin/bash
#$ -l h_data=500G
#$ -l h_rss=500G
#$ -l h_rt=72:00:00
#$ -q bigmem-r8.q
#$ -o /lustre/storeB/users/matem/anemoi_logs/
#$ -e /lustre/storeB/users/matem/anemoi_logs/

cd /home/matem/MLPP/datasets
source lenv.sh

dataset=$1
part=$2
parts=$3

echo $1 $2 $3

anemoi-datasets load $dataset --part $part/$parts
