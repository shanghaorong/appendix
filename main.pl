#author:Shanghao Rong
#date:08/16
#discript: this script is for find which protein occur insertion and in which reion,
#the results of this need to be normallze by timeofinser.pl  nw program have been use in this script, install it first.
use strict;
use warnings;

my@in =<>;
my $file;
my @data;
my $bestresults;
my $chains;
my $region1;
my $region2;
my $region3;
my $region4;
my $region5;
my $region6;
my $region7;
my $proteinid;
my $filename1 = "mainoutput.txt";
foreach my $line (@in) {
	$file .= $line;
}
my @entries =split(/(?<=\*)/,$file);
open(my $fh,">",$filename1) or die "could not open file '$filename1' $!";
foreach my$entry(@entries){
    if(SequenceLength($entry) >= 80)
    {
    my $tmpFile = "/Users/R/desktop/project/stage2/nw_V3.16/gg.pir";

    if(open(my $fp, '>', $tmpFile))
    {
        print $fp $entry;
        close $fp;

        ### Align with light chain consensus
        my $lightResults = `/Users/R/Desktop/project/stage2/nw_V3.16/nw -r -m consensus.mat  $tmpFile LightConsensus.pir`;

        ### Align with heavy chain consensus
        my $heavyResults = `/Users/R/Desktop/project/stage2/nw_V3.16/nw -r -m consensus.mat  $tmpFile HeavyConsensus.pir`;
        #print "$lightResults\n";
		    while ($lightResults =~ /HOMOL:\s(\d+\.\d+)/g) {
            my $ls = $1;
			#print "$entry\n$ls\n";
			while ($heavyResults =~/HOMOL:\s(\d+\.\d+)/g) {
            my $hs = $1;
			#print "$entry\n$hs\n$ls";
			if ($ls > $hs) {
                $bestresults = $lightResults;
			    $chains = "lightchain";
				#print "$ls\n$chains";
            }elsif ($hs > $ls){
				$bestresults = $heavyResults;
			$chains = "Heavychain";
            #print  "$hs\n$chains\n";
			}
			#print "$bestresults\n $chains\n";
        #(my $chain, my $bestResults) = FindBestAlignment($lightResults, $heavyResults);
        #print "$bestResults\n";
		@data = split (/\n/,$bestresults);
        #print "@data\n";
		my @alignment = ExtractAlignment($bestresults);
		#print "$alignment[1]\n";
		#print "$alignment[0]\n";
		$alignment[1] =~ s/\$/1/g;
        $alignment[1]  =~ s/\%/2/g;
        $alignment[1]  =~ s/\^/3/g;
        $alignment[1]  =~ s/\~/4/g;
        $alignment[1]  =~ s/\!/5/g;
        $alignment[1]  =~ s/\@/6/g;
        $alignment[1]  =~ s/\#/7/g;
        $alignment[1]  =~ s/\&/8/g;
	 if(CysteinesAligned(@alignment)){
		
            #print "$alignment[0]\n\n\n\n";
            #print "$chain\n $alignment[0]\n";
            #CheckForInserts($entry, $chain, @alignment);
            if ($chains eq "Heavychain") {
            my $FR1 = 'XVQLXXSGXXL5XPGXS515SCX5SG72F2';
            my $CDR1 = 'XXXXXXX';
            my $FR2 = 'WV1QXPG1XLEW55';
            my $CDR2 = 'XIXXXXXXGXXXYXXXXK5';
            my $FR3 = '1XX52XDXSXX25YXXXXSLXXED2AXYYCAR';
            my $CDR3 = 'XXXXXXXXXXXXXXXXXXXXXXXXXX';
			my $FR4 = 'WGQGTXVTVSS';
            #print "$entry\n";
			if ($alignment[1] !~/$FR1/) {
             $region1 = "FR1";
            print $fh "$chains...\n$region1$entry\n";
			}
            if ($alignment[1] !~/$CDR1/) {
             my $region2 = "CDR1";
            print $fh "$chains...\n$region2$entry\n";
			}
            if ($alignment[1] !~ /$FR2/) {#/WV\$QXPG\$XLEW!!/g
             $region3 = "FR2";
            print $fh "$chains...\n$region3$entry\n";
			}
            if ($alignment[1] !~ /$CDR2/) {
            $region4 = "CDR2";
            print $fh "$chains...\n$region4$entry\n";
			}
            if ($alignment[1] !~/$CDR3/) {
            $region5 = "FR3";
            print $fh "$chains...\n$region5$entry\n";
			}
            if ($alignment[1] !~/XXXXXXXXXXXXXXXXXXXXXXXXXX/g) {
            $region6 = "CDR3";
            print $fh "$chains...\n$region6$entry\n";
			}
			if ($alignment[1] !~ /WGQGTXVTVSS/g) {
            $region7 = "FR4";

			print $fh "$chains...\n$region7$entry\n";
            }
        #print $fh "$entry\n$chains...\n$region1\n$region2\n$region3\n$region4\n$region5\n$region6\n$region7$entry\n";
            
			
			}elsif ($chains eq "lightchain"){
			my $FR1 = '4AVLTQPPXS525S5GXXVTI2C';
            my $CDR1 = "XXSXXXXXXXXXXXX5X";
            my $FR2 = 'WYQQKXGXXPK5LIY';
            my $CDR2 = "XX2XXXS";
            my $FR3 = 'GVPXRFSGS5SGTXX2LXISX5XXEDX5XY7C';
            my $CDR3 = "XXXXXXXXXXXXXXX";
			my $FR4 = 'FGXGTKLEIXKRA';
			if ($alignment[1] !~ /$FR1/) {
            $region1 = "FR1";
				print $fh "$chains...\n$region1$entry\n\n";
            }
			if ($alignment[1] !~ /$CDR1/) {
            $region2 = "CDR1";
			print $fh "$chains...\n$region2$entry\n";
            }
			if ($alignment[1] !~ /$FR2/) {
            $region3 = "FR2";
            print $fh "$chains...\n$region3$entry\n";
            }
			if ($alignment[1] !~ /$CDR2/) {
            $region4 = "CDR2";
            print $fh "$chains...\n$region4$entry\n";
            }
            if ($alignment[1] !~/$FR3/) {
            $region5 = "FR3";
            print $fh "$chains...\n$region5$entry\n";
            }
			if ($alignment[1] !~/$CDR3/g) {
            $region6 = "CDR3";
            print $fh "$chains...\n$region6$entry\n";
            }
			if ($alignment[1] !~ /$FR4/) {
            $region7 = "FR4";
            print $fh "$chains...\n$region7$entry\n";
            }
        #print $fh "$entry\n$chains...\n$region1\n$region2\n$region3\n$region4\n$region5\n$region6\n$region7$entry\n";
			}

	 }
	}
}

}

	}

	}
close $fh;
sub FindBestAlignment
{
    my($lightResults, $heavyResults) = @_;
    while ($lightResults =~ /HOMOL:\s(\d+\.\d+)/g) {
            my $ls = $1;
			#print "$ls\n";
			while ($heavyResults =~/HOMOL:\s(\d+\.\d+)/g) {
            my $hs = $1;
			#print "$hs\n";
			if ($ls > $hs) {
                my $bestResults = $lightResults;
				my $chain = "lightchain";
            }elsif ($hs > $ls){
				my $bestResults = $heavyResults;
				my $chain = "Heavychain";
         ### See which one has the higher similarity and return it
         ### also need to indicate whether it was light or heavy that
         ### was best
    return($chain, $bestResults);
}
            }
    }
}


sub ExtractAlignment
{

    my $state = 0;
    my $recordNum = 0;
    my @alignment = ();

    foreach $_ (@data)
    {
        chomp;

        if(/^Alignment\.\.\./)
        {
            $state = 1;
        }
        elsif(/^------------/ && ($state == 1))
        {
            $state = 2;
            $recordNum = 0;
        }
        elsif(/^Score/ && ($state == 2))
        {
            $state = 0;
        }
        elsif($state == 2)
        {
            my $slot = $recordNum % 3;
            if($slot < 2)
            {
                $alignment[$slot] .= $_;
            }
            $recordNum++;
        }
    }
    return(@alignment);
}


sub SequenceLength
{   my @fields;
    my($entry) = @_;
    @fields = split(/\n/, $entry);
    return(length($fields[3]));
}

sub CysteinesAligned
{
    my(@alignment) = @_;
    my @pos;
    foreach my $n(@alignment) {
        while ($alignment[1] =~ /C/g) {
            push @pos,(pos($alignment[1]));
        }                                             ########### bug?
        foreach my $s(@pos){
        my $test = substr($alignment[0],$s-1,1);
            if ($test eq 'C') {
            return (1);
        }elsif ($test ne 'C'){
            return(2);
        }
    }
    
}
	}
