use v5.30.0;
use warnings;
use List::Util qw/product/;

my @time = qw/  38     94     79     70/;
my @dist = qw/ 241   1549   1074   1091/;
my @arr;

for my $r (0..3) {
    my $ans = 0;
    for my $t (1..$time[$r]) {
        $ans++ if $t*($time[$r]-$t) > $dist[$r]
    }
    push @arr, $ans;
}

say product @arr;
