#!/bin/bash
#SBATCH --job-name=docking
#SBATCH --output=dock.out
#SBATCH --error=dock.err
#SBATCH --mail-type=ALL
#SBATCH --time=11:00:00
#SBATCH --ntasks=8
#SBATCH --cpus-per-task=1
#SBATCH --ntasks-per-node=8
#SBATCH --distribution=cyclic:cyclic
#SBATCH --mem-per-cpu=2000
#SBATCH --qos=alberto.perezant

cd $SLURM_SUBMIT_DIR

module purge

module load autodock-vina/1.2.5

vina --receptor protein.pdbqt --ligand ligand.pdbqt --center_x 15.249 --center_y 129.208 --center_z 11.972 --size_x 20 --size_y 18 --size_z 20 --out complex.pdbqt --cpu 8