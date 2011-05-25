#Modified 4/16/2011
#Avinash Ramu - University of Florida.
#Find the frequent seeds amongst the potential seeds!
#sample usage - perl freq_check_seeds.pl $seeds_file $trees_file $op_file


#! /usr/bin/perl


#Read in Command Line Arguments
$seeds_file = $ARGV[0];
print "\n\nSeeds file is $seeds_file";

$trees_file = $ARGV[1];
print "\n\nTrees file is $trees_file";

$op_file = $ARGV[2];
print "\n\nOutput file is $op_file";

if($#ARGV != 2 ) {
    print"\nincorrect arguments exiting!";
    print"\n\t Usage perl freq_check_seeds.pl \$seeds_file \$trees_file \$op_file \n";
    die;
}

open(IN, $seeds_file) || die("\nCould not open seeds file! Exiting !");
#@file = split /\./,$seeds_file;
#$out_file = ">frequent_".$file[0]."_".$trees_file;

print"\n\nCalculating Frequency of seeds..";
$first_line = 0;

while (<IN>){    
    if($first_line == 0) {      	
      	chomp;
      	$m = `wc -l $trees_file`;
      	print"Number of trees is $m";
      	$cutoff1 = 0.5 * $m;
	$cutoff2 = 0.7 * $m;
	$cutoff3 = 0.8 * $m;
	$cutoff4 = 0.9 * $m;
	$cutoff5 = $m;
	
	#pass the false cutoff to nw_match
	$false_cutoff = 0.5 * $m;
	print"\nFalse cutoff is $false_cutoff";
	
	
	$out_file = ">".$op_file."all";
	open(OUT, $out_file);
	$out_file_f = ">".$op_file."all_frequencies";
	open(OUT_f, $out_file_f);


	$out_file1 = ">".$op_file."50";
	open(OUT1, $out_file1);
	$out_file1_f = ">".$op_file."50_frequencies";
	open(OUT1_f, $out_file1_f);
	
	$out_file2 = ">".$op_file."70";
	open(OUT2, $out_file2);
	$out_file2_f = ">".$op_file."70_frequencies";
	open(OUT2_f, $out_file2_f);
	
	
	$out_file3 = ">".$op_file."80";
	open(OUT3, $out_file3);
	$out_file3_f = ">".$op_file."80_frequencies";
	open(OUT3_f, $out_file3_f);
	
	
	$out_file4 = ">".$op_file."90";
	open(OUT4, $out_file4);
	$out_file4_f = ">".$op_file."90_frequencies";
	open(OUT4_f, $out_file4_f);
	
	$out_file5 = ">".$op_file."100";
	open(OUT5, $out_file5);
	$out_file5_f = ">".$op_file."100_frequencies";
	open(OUT5_f, $out_file5_f);

	$count1 = 0;
	$count2 = 0;
	$count3 = 0;
	$count4 = 0;
	$count5 = 0;
	$first_line = 1;
	
	
    }
    
    #print "Cutoff freq $cutoff_freq";
    chomp $_;
    $freq = `./nw_match_416 $trees_file '$_' $false_cutoff| wc -l`;
    
    #print all frequencies
    print OUT"$_\n";
    print OUT_f"$freq";
    
    #50 pc
    if($freq >= $cutoff1) {
	print OUT1"$_\n";
	print OUT1_f"$freq";
	$count1 = $count1 + 1;
    }    
    
    #70 pc
    if($freq >= $cutoff2) {
	print OUT2"$_\n";
	print OUT2_f"$freq";
	$count2 = $count2 + 1;
    }  
    
    #80 pc
    if($freq >= $cutoff3) {
	print OUT3"$_\n";
	print OUT3_f"$freq";
	$count3 = $count3 + 1;
    }  
    
    #90 pc
    if($freq >= $cutoff4) {
	print OUT4"$_\n";
	print OUT4_f"$freq";
	$count4 = $count4 + 1;
    }  
    
    #100 pc
    if($freq >= $cutoff5) {
	print OUT5"$_\n";
	print OUT5_f"$freq";
	$count5 = $count5 + 1;
    }     
    
}

print"\nDone!";
print"\n\nNumber of frequent seeds (50)\t$count1";
print"\nNumber of frequent seeds (70)\t$count2";
print"\nNumber of frequent seeds (80)\t$count3";
print"\nNumber of frequent seeds (90)\t$count4";
print"\nNumber of frequent seeds (100)\t$count5";

print"\n";
close(IN);
close(OUT1);
close(OUT2);
close(OUT3);
close(OUT4);
close(OUT5);
close(OUT1_f);
close(OUT2_f);
close(OUT3_f);
close(OUT4_f);
close(OUT5_f);

#Sort the 70 pc file based on frequencies
$seeds70 = $op_file."70";
print"\nSorting $seeds70\n";
`./sortseeds $seeds70`;
print"Done !\n";
