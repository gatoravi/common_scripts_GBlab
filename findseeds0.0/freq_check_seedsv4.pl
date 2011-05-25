#freq count of seeds
#Avinash Ramu - University of Florida.
#sample usage - perl freq_check_seeds.pl $seeds.txt $trees.txt $opfile


#! /usr/bin/perl
$seeds_file = $ARGV[0];
#print "\n\nseeds file is $seeds_file";
$trees = $ARGV[1];
$opfile = $ARGV[2];

if($#ARGV != 2 ) {
 print"\nincorrect arguments exiting!";
}

open(IN, $seeds_file) || die("\nCould not open seeds file! Exiting !");
#@file = split /\./,$seeds_file;
#$out_file = ">frequent_".$file[0]."_".$trees;

print"\n\nCalculating Frequency of seeds..";
$first_line = 0;

while (<IN>)
{
    
    if($first_line == 0)
    {
      	
      	chomp;
      	$m = $_;
      	$cutoff1 = 0.5 * $m;
	$cutoff2 = 0.7 * $m;
	$cutoff3 = 0.8 * $m;
	$cutoff4 = 0.9 * $m;
	$cutoff5 = $m;


	$out_file1 = ">".$opfile."50";
	open(OUT1, $out_file1);
	$out_file2 = ">".$opfile."70";
	open(OUT2, $out_file2);
	$out_file3 = ">".$opfile."80";
	open(OUT3, $out_file3);
	$out_file4 = ">".$opfile."90";
	open(OUT4, $out_file4);
	$out_file5 = ">".$opfile."100";
	open(OUT5, $out_file5);

	$count1 = 0;
	$count2 = 0;
	$count3 = 0;
	$count4 = 0;
	$count5 = 0;
	$first_line = 1;
	
	next;
      
    }
    
    #print "Cutoff freq $cutoff_freq";
    chomp $_;
    $freq = `./nw_match $trees '$_' | wc -l`;
    
     
    if($freq >= $cutoff1)
    {
      print OUT1"$_\n";
      $count1 = $count1 + 1;
    }    
    
    if($freq >= $cutoff2)
    {
      print OUT2"$_\n";
      $count2 = $count2 + 1;
    }  
    
    if($freq >= $cutoff3)
    {
      print OUT3"$_\n";
      $count3 = $count3 + 1;
    }  
    
    if($freq >= $cutoff4)
    {
      print OUT4"$_\n";
      $count4 = $count4 + 1;
    }  
    
    if($freq >= $cutoff5)
    {
      print OUT5"$_\n";
      $count5 = $count5 + 1;
    }     
    
}

print"\nDone!";
print"\n\nNumber of frequent seeds (50)\t$count1";
print"\nNumber of frequent seeds (60)\t$count2";
print"\nNumber of frequent seeds (80)\t$count3";
print"\nNumber of frequent seeds (90)\t$count4";
print"\nNumber of frequent seeds (100)\t$count5";

print"\n";
close(IN);
close(OUT);
