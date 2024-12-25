use v5.30;
use warnings;
use List::Util qw/all/;

my @arr;
my @new;
my $cnt=0;
while (<>) {
    chomp;
    if (/^$/) {
        @new = ();
        $cnt = 0;
    }
    if (/[#\.]{5}/) {
        push @new, $_;
        $cnt++;
    }
    if ($cnt == 7) {
        push @arr, [@new];
    }
}

my @lck;
my @key;

for my $tol (@arr) {
    my @brr;
    if ($tol->[0] eq '.....') {
        JLOOP: for my $j (0..5) {
            for my $i (reverse 1..6) {
                if (substr($tol->[$i-1],$j,1) eq "." && substr($tol->[$i], $j, 1) eq "#") {
                    $brr[$j] = 7-$i;
                    next JLOOP;
                }
            }
        }
        push @lck, [@brr];
    }
    if ($tol->[0] eq '#####') {
        JLOOP: for my $j (0..5) {
            for my $i (0..5) {
                if (substr($tol->[$i],$j,1) eq "#" && substr($tol->[$i+1], $j, 1) eq ".") {
                    $brr[$j] = $i+1;
                    next JLOOP;
                }
            }
        }
        push @key, [@brr];
    }
}

# use Data::Printer;
# p @key;
# p @lck;

my $count = 0;

for my $k (@key) {
    for my $l (@lck) {
        my @sums = map {$l->[$_] + $k->[$_]} 0 .. $k->$#*;
        $count++ if all {$_ <= 7} @sums;
    }
}

say $count;
