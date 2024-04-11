import numpy as np

# Function to parse PDB file and extract CA atom coordinates for protein
def parse_pdb(pdb_file):
    ca_atoms = []
    with open(pdb_file, 'r') as f:
        for line in f:
            if line.startswith('ATOM'):
                atom_name = line[12:16].strip()
                residue_id = int(line[22:26])
                if atom_name == 'CA' and residue_id <= 223:
                    x = float(line[30:38])
                    y = float(line[38:46])
                    z = float(line[46:54])
                    ca_atoms.append((x, y, z, residue_id))
    return np.array(ca_atoms)

# Function to calculate distances between pairs of CA atoms
def calculate_distances(ca_atoms):
    n = len(ca_atoms)
    distances = np.zeros((n, n))
    for i in range(n):
        for j in range(n):
            if i != j:
                dist = np.linalg.norm(ca_atoms[i][:3] - ca_atoms[j][:3])
                distances[i, j] = dist
    return distances

# Function to identify CA contacts within the specified range
def identify_ca_contacts(ca_atoms, distance_max):
    n = len(ca_atoms)
    distances = calculate_distances(ca_atoms)
    close_contacts = []
    for i in range(n):
        for j in range(n):
            if i != j and distances[i, j] <= distance_max:
                close_contacts.append((int(ca_atoms[i][3]), int(ca_atoms[j][3]), distances[i, j]))
    return close_contacts

# Main function
def main():
    pdb_file = "system_nowat.pdb"
    distance_max = 8.0  # Angstroms
    ca_atoms = parse_pdb(pdb_file)
    close_contacts = identify_ca_contacts(ca_atoms, distance_max)
    with open("CA-CA_protein_distance.dat", "w") as f:
        for i, j, dist in close_contacts:
            f.write(f"{i} CA {j} CA {dist:.3f}\n")

if __name__ == "__main__":
    main()

