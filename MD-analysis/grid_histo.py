# Script to analyze the RMSD density distribution for different systems. It's aimed to be plotted in a same graph

import numpy as np
import matplotlib.pyplot as plt
from scipy.stats import gaussian_kde

# Use the Agg backend for Matplotlib (does not require an interactive display)
plt.switch_backend('agg')

# Function to read data from a file and extract a specific column
def read_column(file_path, column_index):
    with open(file_path, 'r') as file:
        # Skip the first row
        next(file)
        data = [float(line.split()[column_index - 1]) for line in file]
    return np.array(data)

# List of input file names grouped by mutants
mutant_files = [
    ['pr1_6_15.dat', 'pr1_6_18.dat'],
    ['pr2_6_15.dat', 'pr2_6_18.dat'],
    ['pr3_6_15.dat', 'pr3_6_18.dat'],
    ['pr4_6_15.dat', 'pr4_6_18.dat'],
    ['pr5_6_15.dat', 'pr5_6_18.dat'],
    ['pr6_6_15.dat', 'pr6_6_18.dat'],
]

# Create a 2x3 grid of subplots
fig, axs = plt.subplots(2, 3, figsize=(12, 8), sharex=True, sharey=True)

for i, rep_files in enumerate(mutant_files):
    for j, rmsd_file in enumerate(rep_files):
        # Read the RMSD data from the file (ignoring the first row)
        rmsd_data = read_column(rmsd_file, column_index=2)

        # Smooth the data using Kernel Density Estimation (KDE)
        kde = gaussian_kde(rmsd_data)

        # Generate values for the x-axis
        x_smooth = np.linspace(min(rmsd_data), max(rmsd_data), 1000)

        # Calculate the KDE values for the x-axis values
        y_smooth = kde(x_smooth)

        # Plot the smoothed curve in the corresponding subplot
        axs[i // 3, i % 3].plot(x_smooth, y_smooth,
                               label=f'igamd={15 if j == 0 else 18}', linewidth=2)

        axs[i // 3, i % 3].set_title(f"Short_peptide {i+1}")
        axs[i // 3, i % 3].legend()
        axs[i // 3, i % 3].grid(False)

# Add overall titles, labels, etc., for the entire figure if needed
plt.suptitle('Probability Density of RMSD for Mutants')

# Common x and y axis titles
fig.text(0.5, 0.04, 'RMSD (Å)', ha='center', va='center')
#fig.text(0.06, 0.5, 'Probability Density', ha='center', va='center', rotation='vertical')

# Ensure that the common x and y axes labels do not overlap with the subplots
plt.tight_layout(rect=[0, 0.05, 1, 0.95])

# Save the plot to a file instead of showing it (change the path as needed)
plt.savefig('test.png')


