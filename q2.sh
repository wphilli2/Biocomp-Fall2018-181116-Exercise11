## Location: This script must be run in the directory containing the files of interest, in this case the proteome files to be searched. The transporter.fasta.align file had to 
##	be copied from its location in a separate folder to the proteome folder for the purposes of this exercise
## Description: The first line builds a hidden markov model(transportprofile.hmm) from the aligned transporter sequences in transporter.fasta.align. The first argument is the path
##	 to the	hmmbuild function in my specific remote machine.
##	(Description continued, for loop): The for loop uses *.fasta as its set, something which can be varied if this script is used in different situations. There is no argument
##	needed for the script, but it must be run in the directory containing the fasta files of interest (see location above). The for-loop creates a temporary file for each
##	 sequence as it is examined in the loop ($filename.hits). This temporary file stores the results of the hmmsearch. Before extracting the results of the hmmsearch, the name
##	 of the file being examined is appended to the text file proteomehits.txt. Next, the grep function is performed on the temporary file to remove all lines except for the
##	 hits from the search, and the wc function is used to count the number of hits. This number is output to proteomehits.txt immediately below the name of sequence that was 
##	searched. The temporary file is then removed; if desired, the line coding for the removal of the temporary file can be deleted in order to save the specific hits for each
##	 proteome sequence. At the completion of the for-loop, the text file proteomehits.txt contains the number of hits derived from the hmmsearch of each proteome file against
##	 the hidden markov model transportprofile.hmm
## Usage: bash script.sh
## *Code begins below* 


/afs/nd.edu/user24/wphilli2/local/bin/hmmer/hmmbuild transportprofile.hmm transporter.fasta.align

for file in *.fasta
do
filename=$(echo $file)
/afs/nd.edu/user24/wphilli2/local/bin/hmmer/hmmsearch --tblout $filename.hits transportprofile.hmm $file
echo $file >> proteomehits.txt
grep -v "#" $filename.hits | wc -l >> proteomehits.txt
rm  $filename.hits
done
