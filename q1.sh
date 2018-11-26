## Location: Working from directory containing gene sequence data
## Code Description (For loops): Combining individual sporecoat and transporter sequencing file contents into individual sporecoat (sporecoat.fasta)
##	 and transporter (transporter.fasta) files.
##	(Code Description continued, sed portion) The appended files that combine the sporecoat and transport sequences append the files without creating a new line; 
##	the sed command is used to mark the positions where appendages occured, and the tr command is used to convert these marked positions to new lines. These modifications 
##	are output to new files called spore.fasta and trans.fasta. The original files without the modifications are removed with the rm function
##	(Code Description continued for Muscle portion, after the sed portion) Making two separate alignments from the newly compiled sporecoat sequence file and the transporter
##	 sequence file. The first argument in both lines is the particular path to the muscle function in my remote machine
##	(Code Description continued to final portion of code, removal of files) The final two lines remove the compiled sequence files as only the compiled alignment files
##	 are needed.
##	Usage: bash script.sh
##	(Usage description):  This script is to be used without inputs in the directory containing the desired sequencing files. If used with different sequences, the set in
##	 the for-loop can be amended to match the file names, and the name of the output file can also be amended.
##	(Usage continued) Since the compiled sequences have been put into files above, the muscle portion of the code should run automatically once spore.fasta and trans.fasta 
## 	have been created
## *Code Begins Below*


for file in spore*.fasta
	do
	cat $file >> sporecoat.fasta
done

for file in trans*.fasta
	do
	cat $file >> transporter.fasta
done

sed -E 's/([A-Z])>/\1\*>/g' sporecoat.fasta | tr '*' '\n' > spore.fasta
        rm sporecoat.fasta
sed -E 's/([A-Z])>/\1\*>/g' transporter.fasta | tr '*' '\n' > trans.fasta
        rm transporter.fasta

/afs/nd.edu/user24/wphilli2/local/bin/muscle3.8.31_i86linux64 -in spore.fasta -out sporecoat.fasta.align
/afs/nd.edu/user24/wphilli2/local/bin/muscle3.8.31_i86linux64 -in trans.fasta -out transporter.fasta.align

rm spore.fasta
rm trans.fasta


