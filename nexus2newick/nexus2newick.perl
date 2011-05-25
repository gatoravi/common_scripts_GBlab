#! /usr/bin/perl 


$nexus_file = $ARGV[0];
$newick_file = $ARGV[1];


open IN,$nexus_file;
open OUT,">"."$newick_file";


while(<IN>) {

  @pruned = split(/\d+/,$_,2);
  print OUT$pruned[1];
} 

close(IN);
close(OUT);
