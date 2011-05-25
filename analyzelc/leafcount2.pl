#Combination of seeds
#Avinash Ramu - University of Florida.
#sample usage - perl count_leaves.pl trees_file
#counts the number of leaves in each tree in a file containing a bunch of trees.

#! /usr/bin/perl
$trees_file = $ARGV[0];

#open trees file

open(IN_TREES, $trees_file) || die("Could not open trees file!");
@trees_array = <IN_TREES>;
close(IN_TREES);

$outfile = $trees_file."_lc";
$outfile_s = $trees_file."_lc_s";

open(OUT_leafcount, ">$outfile") || die("Could not open trees file!");

foreach(@trees_array)
    {
    	
    	open(OUT_temp, ">temp_lc.txt") || die("Could not open trees file!");
    	print OUT_temp"$_";
    	close(OUT_temp);
    	$leaf_count = `./nw_labels_old -I temp_lc.txt | wc -l`;    	
	print OUT_leafcount"$leaf_count";
    }

`sort -n $outfile > $outfile_s`;
`rm temp_lc.txt`;
#`rm $outfile`;
   
close(OUT_leafcount);
print"done LC!\n";
