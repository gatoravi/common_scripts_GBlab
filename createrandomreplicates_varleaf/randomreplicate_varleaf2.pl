#! /usr/bin/perl 
#Avinash Ramu, UF
#Create Random samples of the set of input trees - sample the leaves
#Usage perl randomreplicates.pl ipfile taxafile opfile nooftaxa


#Read in Command Line Arguments
$newick_file = $ARGV[0];
$taxa_file   = $ARGV[1];
$op_file     = $ARGV[2];
$oplc        = $ARGV[3];
$numtaxa     = $ARGV[4];

if($#ARGV != 4 ) {
 print"Incorrect Arguments \n\t Usage perl randomreplicates.pl ipfile taxafile opfile oplc ipnooftaxa Exiting!\n";
 die;
}

#Open File Handles
#input tree file
open(IN1,$newick_file)    || die("Unable to open Newick file !! Exiting ! \n");
#list of taxa in input trees
open(IN2,$taxa_file)      || die("Unable to open Taxa file !! Exiting ! \n");
open(OUT,">".$op_file)    || die("Unable to open Output file !! Exiting ! \n");


#Number of replicates to be created
$replicates = 100;
#Number of trees in the input newick file
$numtree    = 200;


#Copy the input trees to array
@input_trees = <IN1>;
#Copy the input taxa to array
@taxa_array  = <IN2>;



#number of taxa in taxa array
$numtaxa = $ARGV[4];
#array containing taxa to be pruned
@prune_taxa_array;
#initialize inner loop counter
$i=0;

#while number of leaves in op file
while($i<$oplc) {
  #pick a random taxa to prune
  $rnum = int(rand($numtaxa));
  $randomtaxa = $taxa_array[$rnum];
  chomp $randomtaxa;
  $prune_taxa_array[$i++] = $randomtaxa;

  #Swap last with taxa picked taxa and reduce length of the taxa array
  $temp = $taxa_array[$rnum];
  $taxa_array[$rnum] = $taxa_array[$numtaxa-1];
  $taxa_array[$numtaxa-1] = $temp;
  $numtaxa--;  
}  
  
  
#initialize outer loop counter
$j=0;
#while number of replicates
while($j<$replicates) {
  #pick jth tree
  $jtree = $input_trees[$j];
  
  #Write tree to file
  open(OUT_temp,">temp_tree")    || die("Unable to open Output file !! Exiting ! \n");
  print OUT_temp$jtree;
  close(OUT_temp);
  
  #Prune the taxa from the random tree
  $pruned_tree = `./nw_prune -v temp_tree @prune_taxa_array`;
  print OUT$pruned_tree;
 
  $j++;  
} 


close(IN1);
close(IN2);
close(OUT);
