use v5.30.0;
use warnings;
use List::Util qw/product/;

#my $time = 71530;
#my $dist = 940200;
my $time = 38947970;
my $dist = 241154910741091;
my @arr;

my $ans1 = 0;
my $t = 1;
my $ans2 = 0;
while ($t*($time-$t) < $dist) {
    $ans1++ if $t*($time-$t) < $dist;
    $t++;
}
$t = $time;
while ($t*($time-$t) < $dist) {
    $ans2++ if $t*($time-$t) < $dist;
    $t--;
}
say $time-$ans1-$ans2;
