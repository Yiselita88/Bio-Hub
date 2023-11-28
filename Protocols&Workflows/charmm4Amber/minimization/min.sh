#!/bin/bash
#SBATCH --job-name=1GB1_minim
#SBATCH --output=1GB1_minim.out
#SBATCH --error=1GB1_minim.err
#SBATCH --mail-type=ALL
#SBATCH --mail-user=ymartineznoa@ufl.edu
#SBATCH --time=6:00:00
#SBATCH --ntasks=16
#SBATCH --cpus-per-task=1
#SBATCH --ntasks-per-node=8
#SBATCH --distribution=cyclic:cyclic
#SBATCH --mem-per-cpu=500
#SBATCH --qos=alberto.perezant

cd $SLURM_SUBMIT_DIR

export OMP_NUM_THREADS=16

module load cuda/10.0.130
module load intel/2018.1.163
module load openmpi/4.0.3
module load amber/20

srun --mpi=pmix_v2 -n 16 sander.MPI -O -i min1.in -o min1.out -p ../amber/step3_input.parm7 -c ../amber/step3_input.rst7 -r min1.rst7 -inf min1.mdinfo -ref ../amber/step3_input.rst7
srun --mpi=pmix_v2 -n 16 sander.MPI -O -i min2.in -o min2.out -p ../amber/step3_input.parm7 -c min1.rst7 -r min2.rst7 -inf min2.mdinfo -ref min1.rst7
srun --mpi=pmix_v2 -n 16 sander.MPI -O -i min3.in -o min3.out -p ../amber/step3_input.parm7 -c min2.rst7 -r min3.rst7 -inf min3.mdinfo -ref min2.rst7
srun --mpi=pmix_v2 -n 16 sander.MPI -O -i min4.in -o min4.out -p ../amber/step3_input.parm7 -c min3.rst7 -r min4.rst7 -inf min4.mdinfo -ref min3.rst7
srun --mpi=pmix_v2 -n 16 sander.MPI -O -i min5.in -o min5.out -p ../amber/step3_input.parm7 -c min4.rst7 -r min5.rst7 -inf min5.mdinfo -ref min4.rst7
srun --mpi=pmix_v2 -n 16 sander.MPI -O -i min6.in -o min6.out -p ../amber/step3_input.parm7 -c min5.rst7 -r min6.rst7 -inf min6.mdinfo -ref min5.rst7
