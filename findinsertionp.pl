#author:Shanghao Rong
#date:08/16
#discript: this script is for find where is the position of insertion occur and how long of thoses insertion,
#the results of this need to be normallze by countlanddp.pl  nw program have been use in this script, install it first.
use strict;
use warnings;

my@in =<>;
my $file;
my @data;
my $bestresults;
my $chains;
my $lcount = 0;
my $hcount = 0;
my $filename1 = "positionandlength.txt";
foreach my $line (@in) {
	$file .= $line;
                       }
my @entries =split(/(?<=\*)/,$file);
open(my $fh,">",$filename1) or die "could not open file '$filename1' $!";
	foreach my$entry(@entries){
			my @pattern = split(/\n/, $entry);
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
        #print "$bestresults\n";
		@data = split (/\n/,$bestresults);
        #print "@data\n";
		my @alignment = ExtractAlignment($bestresults);
		#print "$alignment[1]\n";
		#print "$alignment[0]\n"; sequence
		$alignment[1] =~ s/\$/1/g;
        $alignment[1]  =~ s/\%/2/g;
        $alignment[1]  =~ s/\^/3/g;
        $alignment[1]  =~ s/\~/4/g;
        $alignment[1]  =~ s/\!/5/g;
        $alignment[1]  =~ s/\@/6/g;
        $alignment[1]  =~ s/\#/7/g;
        $alignment[1]  =~ s/\&/8/g;
	 if(CysteinesAligned(@alignment)){
              #print "$alignment[1]\n";
         if ($chains eq "Heavychain") {
			$hcount ++;
            my $FR1 = 'XVQLXXSGXXL5XPGXS515SCX5SG72F2';
			my $FR2 = 'WV1QXPG1XLEW55';
			my $FR3 = '1XX52XDXSXX25YXXXXSLXXED2AXYYCAR';
			my $FR4 = 'WGQGTXVTVSS';
	for(my $a=0; $a<length($FR1); $a++)
    {
       my $newFR1 = substr($FR1, 0, $a) . "(-+)" . substr($FR1, $a);

           if ($alignment[1] =~ /$newFR1/)
           {
               print $fh "$pattern[2]\n$chains\nMatch at FR1: position at $a length " . length($1) . "*\n";
           }
    }
				
			    for(my $c=0; $c<length($FR2); $c++)
                {
                     my $newFR2 = substr($FR2, 0, $c) . "(-+)" . substr($FR2, $c);

                        if ($alignment[1] =~ /$newFR2/)
                        {
                          print $fh "$pattern[2]\n$chains\nMatch at FR2: position at $c length " . length($1) . "*\n";
                        }
                }
			        for(my $e=0; $e<length($FR3); $e++)
                    {
                        my $newFR3 = substr($FR3, 0, $e) . "(-+)" . substr($FR3, $e);

                           if ($alignment[1] =~ /$newFR3/)
                           {
                           print $fh "$pattern[2]\n$chains\nMatch at FR3: position at $e length " . length($1) . "*\n";
                           }
                    }
			                   for(my $g=0; $g<length($FR4); $g++)
                               {
                                   my $newFR4 = substr($FR4, 0, $g) . "(-+)" . substr($FR4, $g);

                                   if ($alignment[1] =~ /$newFR4/)
                                   {
                                      print $fh "$pattern[2]\n$chains\nMatch at FR4: position at $g length " . length($1) . "*\n";
                                }
                            }
                                    }
		 if ($chains eq "lightchain") {
            			$lcount ++;
            my $FR1 = '4AVLTQPPXS525S5GXXVTI2C';
			my $FR2 = 'WYQQKXGXXPK5LIY';
			my $FR3 = 'GVPXRFSGS5SGTXX2LXISX5XXEDX5XY7C';
			my $FR4 = 'FGXGTKLEIXKRA';
			for(my $a=0; $a<length($FR1); $a++)
{
    my $newFR1 = substr($FR1, 0, $a) . "(-+)" . substr($FR1, $a);

    if ($alignment[1] =~ /$newFR1/)
    {
        print $fh "$pattern[2]\n$chains\nMatch at FR1: position at $a length " . length($1) . "*\n";
    }
}
				
			for(my $c=0; $c<length($FR2); $c++)
{
    my $newFR2 = substr($FR2, 0, $c) . "(-+)" . substr($FR2, $c);

    if ($alignment[1] =~ /$newFR2/)
    {
        print $fh "$pattern[2]\n$chains\nMatch at FR2: position at $c length " . length($1) . "*\n";
    }
}
			for(my $e=0; $e<length($FR3); $e++)
{
    my $newFR3 = substr($FR3, 0, $e) . "(-+)" . substr($FR3, $e);

    if ($alignment[1] =~ /$newFR3/)
    {
        print $fh "$pattern[2]\n$chains\nMatch at FR3: position at $e length " . length($1) . "*\n";
    }
}
			for(my $g=0; $g<length($FR4); $g++)
{
    my $newFR4 = substr($FR4, 0, $g) . "(-+)" . substr($FR4, $g);

    if ($alignment[1] =~ /$newFR4/)
    {
        print $fh "$pattern[2]\n$chains\nMatch at FR4: position at $g length " . length($1) . "*\n";
    }
}
         }
         
         


             }

            #print "$chains\n$alignment[0]\n$alignment[1]\n...\n";
            #print "$chains\n $alignment[0]\n";
            #CheckForInserts($entry, $chain, @alignment);
            
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

