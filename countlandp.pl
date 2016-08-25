#####
#author:Shanghao Rong
#date:08/16
#discript: this script is for count the insertion occur at same position and count the insertions which have same lengthse
use strict;
use warnings;

my $filename = "positionandlength.txt";
my $outfilename1 = ">result1.txt";
my $outfilename2 = ">result2.txt";

open OUTPUTFILE1, $outfilename1 or die "cannot open $outfilename1: $!";
open OUTPUTFILE2, $outfilename2 or die "cannot open $outfilename2: $!";
open INPUTFILE, $filename or die "cannot open $filename: $!";

my %hash1; ##????????
my %hash2; ##????????

while (<INPUTFILE>) {
	chomp;
	my $line1 = $_;
	
	my $line2 = <INPUTFILE>;
	chomp $line2; 

	my $line3 = <INPUTFILE>;
	chomp($line3);
	
	
	$line3 =~ s/://;
	$line3 =~ s/\*//;

	my @cmds = split /\s+/, $line3;
	
	my $r1 = $line2."\t".$cmds[2]."\tposition_".$cmds[5];
	my $r2 = $r1."\tlength_".$cmds[7];
	$hash1{$r1} = 0 unless defined $hash1{$r1};
	$hash2{$r2} = 0 unless defined $hash2{$r2};
	$hash1{$r1} = $hash1{$r1} + 1;
	$hash2{$r2} = $hash2{$r2} + 1;

}
my @keys1 = sort keys %hash1;
foreach my $key (@keys1) {
	print OUTPUTFILE1 $key."\t".$hash1{$key}."\n";
}
my @keys2 = sort keys %hash2;
foreach my $key (@keys2) {
	print OUTPUTFILE2 $key."\t".$hash2{$key}."\n";
}