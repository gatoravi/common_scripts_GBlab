#! /usr/bin/perl
#Combination of seeds
#Avinash Ramu - University of Florida.

#sample usage - perl sort_freq_seeds.pl seeds_file
#sort the seeds in the order of freq


$seeds_file = $ARGV[0];
print"\n\nThe seed file being sorted is $seeds_file";

if($#ARGV != 0 ) {
    print"\nIncorrect arguments exiting!\n";
    die;
}

#open trees file
open(IN_SEEDS, $seeds_file) || die("\nIn SortFreqSeeds.pl Could not open seeds file! \n");
@seeds_array = <IN_SEEDS>;
close(IN_SEEDS);

open(IN_FREQUENCY, $seeds_file."_frequencies") || die("Could not open frequency file!");
@freq_array = <IN_FREQUENCY>;
close(IN_FREQUENCY);

$outfile_f = $seeds_file."_frequencies";
$outfile_s = $seeds_file;

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
print"Done Sorting! \n";
