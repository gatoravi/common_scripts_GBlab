#freq count of seeds
#Avinash Ramu - University of Florida.
#sample usage - perl freq_check_seeds.pl $seeds.txt $trees.txt freq


#! /usr/bin/perl
$seeds_file = $ARGV[0];
#print "\n\nseeds file is $seeds_file";
$trees = $ARGV[1];

if($#ARGV != 2)
{
  print"Incorrect Arguments exiting";
  print"\nSample usage = perl freq_check_seeds.pl $seeds.txt $trees.txt cutoff_frequencypc\n";
  die;
}
$tree_no = `wc -l $ARGV[1]`;
print"Number of trees is $tree_no\n";
#calculate cutoff number of trees.
$cutoff     = int($ARGV[2] * $tree_no /100 + 0.99);
print"Cutoff is $cutoff trees";


open(IN, $seeds_file) || die("Could not open seeds file!");
@seeds_array = <IN>;
close(IN);

#@file = split /\./,$seeds_file;
#$out_file = ">frequent_".$file[0]."_".$trees;

print"\n\nCalculating Frequency of seeds..";
$first_line = 0;


foreach (@seeds_array)
{
    
    if($first_line == 0)
    {
      	
      	chomp; 	

	$out_file1 = ">".$seeds_file."_".$trees."_f_".$ARGV[2];
	open(OUT_fseeds, $out_file1);	
	
	$out_file2 = ">".$seeds_file."_".$trees."_f_".$ARGV[2]."_frequencies";
	open(OUT_f, $out_file2);	

	$count = 0;
	$first_line = 1;	
	next;
      
    }
    
    #print "Cutoff freq $cutoff_freq";
    chomp $_;
    $freq = `./nw_match $trees '$_' | wc -l`;    
     
    if($freq >= $cutoff)
    {
      print OUT_fseeds"$_\n";
      print OUT_f"$freq";
      $count = $count + 1;
    }     
    
    
}

print"\nDone!";
print"\nNumber of frequent seeds ".$ARGV[2]."%: \t$count";

print"\n";
close(OUT);
close(OUT_f);
