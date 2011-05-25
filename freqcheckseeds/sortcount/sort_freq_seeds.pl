#!/usr/bin/perl
#Combination of seeds
#Avinash Ramu - University of Florida.

#sample usage - perl count_leaves.pl trees_file
#counts the number of leaves in each tree in a file containing a bunch of trees.


$trees_file = $ARGV[0];

#open trees file
open(IN_SEEDS, $trees_file) || die("Could not open trees file!");
@seeds_array = <IN_SEEDS>;
close(IN_SEEDS);

open(IN_FREQUENCY, $trees_file."_frequencies") || die("Could not open frequency file!");
@freq_array = <IN_FREQUENCY>;
close(IN_FREQUENCY);

$outfile_f = $trees_file."_frequencies";
$outfile_s = $trees_file;

open(OUT_seed, ">$outfile_s") || die("Could not open trees file!");
open(OUT_freq, ">$outfile_f") || die("Could not open trees file!");

for($i = 0; $i<=$#freq_array; $i++)
  {
	for($j = 0; $j<=$#freq_array-$i-1; $j++)
	    {
	       if($freq_array[$j]<$freq_array[$j+1])
		 {
		   $temp = $freq_array[$j];           
		   $freq_array[$j] = $freq_array[$j+1];
		   $freq_array[$j+1] = $temp;
		   
		   $temp2 = $seeds_array[$j];           
		   $seeds_array[$j] = $seeds_array[$j+1];
		   $seeds_array[$j+1] = $temp2;
		 }
	    }
  }
for($i = 0; $i<=$#freq_array; $i++)
  {
	print OUT_seed"$seeds_array[$i]";
	print OUT_freq"$freq_array[$i]";
  }
   
close(OUT_seed);
close(OUT_freq);
print"done! \n";
