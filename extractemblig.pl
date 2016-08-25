#
#author:Shanghao Rong
#date:08/16
#discript: this script is for extract data from emblig, the format of output is pir format
use strict;
use warnings;

my@in =<>;
my $file;
my @store;
my @rabbit;
my $id;
my $proteinid;
my $translation;
my $filename1 = "emboutput.pir";
foreach my $line (@in) {
	chomp $line;
	$file .= $line;

}
#$file =~ s/\s+//g;
@store =split(/\/\//,$file);
#print "$store[1]";
foreach my $entry (@store){
        while($entry =~ /OS\s+Oryctolagus\s+cuniculus\s+\(rabbit\)/g){
        push @rabbit,$entry;
                                                                  }
        
                          }
open(my $fh,">",$filename1) or die "could not open file '$filename1' $!";
foreach my $n(@rabbit){
     #print "$n\n";
    if ( $n =~ /AC\s+(\w+\d+);/) {
         $id = $1;
        #print "$id\n";
                                 }
    if ($n =~ /FT\s+\/protein_id="(\w+\d+\.\d+)"/) {
         $proteinid = $1;
        #FT                   /protein_id="AAC39178.1"
        #print "$proteinid\n";
                                                    }

    if ($n =~ /\/translation="(.+?)"/) {
    #FT                   /translation="QSVEESRGGLIKPTDTLTHTCTVSGFSLSSYGVIWVRQAPGNGLE
    #FT                   YIGTIGSSGSAYYASWAKSRSTITRNTNLNTVTLKMTSPTAADTATYFCARGIYYSDPC
    #FT                   DYADIWGP"
    $translation = $1;

    $translation =~ s/\s+//g;
    #print "$translation\n";
    

        
                                            }
    print  $fh ">p1;$id\n$proteinid - rabbit\n$translation*\n"
    
                      }
close $fh;
