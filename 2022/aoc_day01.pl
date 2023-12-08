use v5.30.0;
use warnings;

open FH,"<","day01.txt";

my $max1 = 0;
my $max2 = 0;
my $max3 = 0;
my $cur = 0;
while (<FH>) {
    if (/^$/) {
        if ($max3 < $cur) {
            my $max = $cur;
            ($max1, $max2, $max3) = sort {$b<=>$a} ($max1, $max2, $max);
        }
        $cur = 0;
    } elsif (/(\d+)/) {
        $cur += $1;
    }
}

say $max1;
say $max2;
say $max3;
say $max1+$max2+$max3;
