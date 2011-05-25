#! /usr/bin/perl 
#Avinash Ramu, UF
#Create Random samples of the set of input trees
#Usage perl randomreplicates.pl ipfile opfile noofreplicates

$newick_file = $ARGV[0];
$replicate = $ARGV[1];


open IN,$newick_file || die("Unable to open Newick file !! Exiting ! \n");
open OUT,">"."$replicate"|| die("Unable to open Newick file !! Exiting ! \n");


@input_trees = <IN>;
$i=0;
$length = 200;


@mast_labels = `./nw_labels seed_file_$i`;
foreach(@mast_labels)  {
  chomp;
}


$MAST_INNER_TEMP = `./nw_prune -v $tree_file_temp @mast_labels`;	
while($i<$ARGV[2]) {
  $rnum = int(rand($length));
  print "Adding tree ".$rnum."\n";
  print OUT$input_trees[$rnum];
  
  #Swap last with picked seed and reduce length
  $temp = $input_trees[$rnum];
  $input_trees[$rnum] = $input_trees[$length-1];
  $input_trees[$length-1] = $temp;
  $length--;
  
  $i++;
  
} 

close(IN);
close(OUT);
