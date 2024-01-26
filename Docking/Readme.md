# Tutorial to run AutoDock & AutoDock Vina for dummies
# the installer can be found here: https://vina.scripps.edu/downloads/ 
1.- Install:
    1.1) Autodock4
    1.2) Autogrid4
    1.3) MGLTools
2.- Make sure to add the path to your ~./bashrc file (for Linux)
3.- Install vina by typing on your command prompt:
>>> sudo apt-get install vina

# AutoDockTools tutorial
4.- After installing MGLTools you'll be able to open the graphic interface by typing on your command prompt:
>>> adt
5.- Copy the PDB files of your ligand and receptor (protein) in your work directory
# the slash in the following steps indicates the actions that will be performed consecutively
6.- With ADT graphical interface open go to:
File/Read Molecule/Choose-your-path/protein.pdb/Open  # I'm assuming the PDB file corresponding to the receptor is named: "protein.pdb"
7.- With the loaded receptor go to:
Edit/Hydrogens/Add/Polar Only/Click "OK"
8.- Grid/Macromolecule/Choose/protein/Select Molecule
9.- To know the dimensions and position of the box of the space the ligand will explore, go to:
Grid/Grid Box (Here adjust the dimensions and the center of the box)
10.- Save the dimensions of the box
11.- Now we need to use the ligand, then go to:
Ligand/Input/Open/Choose-your-path/Choose PDB/ligand.pdb
12.- Ligand/Output/Save as PDBQT

Now with all the saved dimensions and the PDBQT for the ligand and the receptor, run the "docking.sh" bash script to execute Vina and obtain the top models






