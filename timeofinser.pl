#author:Shanghao Rong
#date:08/16
#discript: this script is for count how many protein occur insertion and in which region.

use warnings;

my@in =<>;
my $file;
my $hccount =0;
my $lccount = 0;
my $LFR1 = 0;
my $LCDR1 = 0;
my $LFR2 = 0;
my $LCDR2 = 0;
my $LFR3 = 0;
my $LCDR3 = 0;
my $LFR4 = 0;
my $HFR1 = 0;
my $HCDR1 = 0;
my $HFR2 = 0;
my $HCDR2 = 0;
my $HFR3 = 0;
my $HCDR3 = 0;
my $HFR4 = 0;
foreach my $line (@in) {
	$file .= $line;
}
my @entries =split(/(?<=\*)/,$file);
foreach my $entry (@entries){
      if ($entry =~ /lightchain.../) {
        $lccount ++;
        if ($entry =~/FR1/) {
            $LFR1 ++;
        }
        if ($entry =~ /CDR1/) {
            $LCDR1 ++;
        }
        if ($entry =~ /FR2/) {
            $LFR2 ++;
        }
        if ($entry =~ /CDR2/) {
            $LCDR2 ++;
        }
        if ($entry =~ /FR3/) {
            $LFR3 ++;
        }
        if ($entry =~ /CDR3/) {
            $LCDR3 ++;
        }
        if ($entry =~ /FR4/) {
            $LFR4 ++;
        }
        }elsif ($entry =~ /Heavychain.../) {
        $hccount ++;
        if ($entry =~/FR1/) {
            $HFR1 ++;
        }
        if ($entry =~ /CDR1/) {
            $HCDR1 ++;
        }
        if ($entry =~ /FR2/) {
            $HFR2 ++;
        }
        if ($entry =~ /CDR2/) {
            $HCDR2 ++;
        }
        if ($entry =~ /FR3/) {
            $HFR3 ++;
        }
        if ($entry =~ /CDR3/) {
            $HCDR3 ++;
        }
        if ($entry =~ /FR4/) {
            $HFR4 ++;
        }
      }
      
      
}
print "lightchain:$lccount\nheavychain:$hccount\n";
print "lightchain\nfr1:$LFR1\ncdr1:$LCDR1\nfr2:$LFR2\ncdr2:$LCDR2\nfr3:$LFR3\ncdr3:$LCDR3\nfr4:$LFR4\n";
print "Heavychain\nfr1:$HFR1\ncdr1:$HCDR1\nfr2:$HFR2\ncdr2:$HCDR2\nfr3:$HFR3\ncdr3:$HCDR3\nfr4:$HFR4\n"; 