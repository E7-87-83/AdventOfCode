use v5.30.0;
use warnings;
use List::Util qw/sum all reductions/;
use List::MoreUtils qw/slide/;

my @ans;
my @arr;

open FH, "<", "day9.txt";

while (<FH>) {
    chomp;
    my $line = $_;
    push @arr, [split " ", $line];
}


# @arr = ([qw/0 3 6 9 12 15/],
#  [qw/1 3 6 10 15 21/],
#  [qw/10 13 16 21 30 45/]);

for my $r (@arr) {
    my @array = $r->@*;
    my @init = ($array[0]);
    my $num = scalar @array;
    my $step = 0;
    while (!(all {$_==$array[0]} @array)) {
        @array = slide {$b-$a} @array;
        push @init, $array[0];
        $step++;
    }
    @init = reverse @init;
    my $m_a = $init[0];
    my $n_a;
    for my $i (1..$step) {
        $n_a = $init[$i]-$m_a;
        $m_a = $n_a;
    }
    say $n_a;
    push @ans, $n_a;
}



say sum(@ans);
