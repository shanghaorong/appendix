#author:Shanghao Rong
#date:08/16
#discript: this script is for extract the data from imgt and the results is print directly.
use warnings;
use strict;


my@in =<>;
my $file;
my@store;
my$id;
my$count;
my@rabbit;
my@irabbit;
foreach my $line (@in) {
	chomp $line;
	$file .= $line;
}
$file =~ s/\s+//g;
$count =0;
@store =split(/\/\//,$file);
#print scalar(@store);
foreach my $n(@store){
    while($n =~ /OSOryctolaguscuniculus\(rabbit\)/g){
		$count++;
        push @rabbit,$n;
            }

}
print "$count\n";
#print "$rabbit[2041]\n";
#/OSOryctolaguscuniculus\(rabbit\)/g  match specise rabbit
#my$count1 = 0;
#foreach my$j(@rabbit){
#    while($j=~ /^ID(\w+)\;/g){
#        $count1 ++;
#		$id = $1;
#		print "$id\n";
#	}
#}
#print "$count1\n";
#FT(\w+\-IMGT)\d+\.\.\d+FT\/translation="(\w+)"FT\/AA_IMGT="(\w+)including"
foreach my$j(@rabbit){
		while ($j =~/^ID(\w+)\;/g) {
        $id = $1;
    }
	while ($j =~ /FT(\w+\-IMGT)\d+\.\.\d+FT\/translation="(\w+)"FT\/AA_IMGT="(\w+)including(.*)"/g) {
               push @irabbit,$j;
			   my$region = $1;
			   my$AA= $2;
			   my $prefer =length $AA;
			   my$putin =$3;
			while ($putin =~ /AA(\d+)to(\d+)/g) {
    #print "$1,$2\n";
	my$caculate = $2-$1+1;
	my$start =$1;
	my$end = $2;
		print "ID:$id region:$region sequence:$AA standard:$caculate actual:$prefer\n";
                }
  
}
   
}