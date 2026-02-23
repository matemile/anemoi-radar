#!/bin/bash
#SBATCH --account=EUHPC_R06_263
#SBATCH --partition=boost_usr_prod
#SBATCH --qos=boost_qos_dbg
#SBATCH --gres=gpu:4
#SBATCH --nodes=2
#SBATCH --ntasks-per-node=4
#SBATCH --cpus-per-task=4
#SBATCH --mem=0
#SBATCH --time=0-00:30:00
#SBATCH --job-name=test_radar-unorm
#SBATCH --output=logs/%x.out
#SBATCH --error=logs/%x.err
module load cuda/12.2                         # Load CUDA toolkit
module load openmpi                           # Load MPI implementation

# Optional: Set environment variables for performance tuning
export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK   # Set OpenMP threads per task
export HYDRA_FULL_ERROR=1
# Debug: show SLURM env that Python will use to build TF_CONFIG
export PYTORCH_CUDA_ALLOC_CONF=expandable_segments:True
# NCCL / fabric settings
CONFIG_NAME=radar_fcst_work.yaml
CONFIG_DIR=/leonardo_work/EUHPC_R06_263/mmile000/anemoi-hpc-benchmarks/config
cd /leonardo_work/EUHPC_R06_263/mmile000/anemoi-hpc-benchmarks
source .venv/bin/activate

srun anemoi-training train --config-name=${CONFIG_NAME} --config-path=${CONFIG_DIR}
