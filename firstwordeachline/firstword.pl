#!/usr/bin/perl

#print $ARGV[0];
open(IN,$ARGV[0])|| die("Unable to open file.");


while(<IN>) {
  #print "\n$_";
  $line = $_;
  my@taxa = split(" ",$line);
  print "${taxa[0]}\n";
}
#print("\n");
close(IN);
