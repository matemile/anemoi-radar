#!/bin/bash
#$ -N daily_radar15m_v20
#$ -j y
#$ -b n
#$ -S /bin/bash
#$ -l h_data=32G
#$ -l h_rss=32G
#$ -l h_rt=72:00:00
#$ -q research-r8.q
#$ -o /lustre/storeB/users/matem/anemoi_logs/
#$ -e /lustre/storeB/users/matem/anemoi_logs/

cd /home/matem/MLPP/datasets
source lenv.sh

dataset=$1
part=$2
parts=$3

echo $1 $2 $3

anemoi-datasets load $dataset --part $part/$parts
