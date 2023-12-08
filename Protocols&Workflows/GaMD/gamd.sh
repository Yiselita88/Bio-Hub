#!/bin/bash
#SBATCH --job-name=igamd18_cMD14_sigmaOP6
#SBATCH --output=test.out
#SBATCH --error=test.err
#SBATCH --mail-type=ALL
#SBATCH --time=7-00:00:00
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --mem-per-cpu=4gb
#SBATCH --partition=gpu
#SBATCH --gpus=a100:1


echo "Date = $(date)"echo "host = $(hostname -s)"echo "Directory = $(pwd)"cd $SLURM_SUBMIT_DIRexport OMP_NUM_THREADS=1


module purge
module load cuda/11.1.0 nvhpc/20.11 openmpi/4.0.5 amber/20

pmemd.cuda_SPFP -O -i  gamd.in -o gamd.out -p system.top -c npt2.rst -r gamd.rst -x gamd.nc -inf gamd.mdinfo -gamd gamd.log -ref npt2.rst
pmemd.cuda_SPFP -O -i  product.in -o product1.out -p system.top -c gamd.rst -r product1.rst -x product1.nc -inf product1.mdinfo -gamd product1.log -ref gamd.rst
pmemd.cuda_SPFP -O -i  product.in -o product2.out -p system.top -c product1.rst -r product2.rst -x product2.nc -inf product2.mdinfo -gamd product2.log -ref product1.rst
pmemd.cuda_SPFP -O -i  product.in -o product3.out -p system.top -c product2.rst -r product3.rst -x product3.nc -inf product3.mdinfo -gamd product3.log -ref product2.rst
pmemd.cuda_SPFP -O -i  product.in -o product4.out -p system.top -c product3.rst -r product4.rst -x product4.nc -inf product4.mdinfo -gamd product4.log -ref product3.rst
pmemd.cuda_SPFP -O -i  product.in -o product5.out -p system.top -c product4.rst -r product5.rst -x product5.nc -inf product5.mdinfo -gamd product5.log -ref product4.rst
