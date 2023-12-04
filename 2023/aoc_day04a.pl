use v5.30.0;
use warnings;
use List::Util qw/all min max sum/;

open FH , '<', 'aoc_day4.txt';

my @arr;

while (<FH>) {
    chomp;
    my $line = substr($_, 10);
    my @a = split " \\| ", $line;
    my $first = $a[0];
    my $second = $a[1];
    my @win = split /\s+/, $first;
    my @i_have = split /\s+/, $second;
    my $s = 0;
    ELF: for my $w (@win) {
        next if $w eq "";
        for my $i (@i_have) {
            next if $i eq "";
            if ($w==$i) {
                $s++;
                next ELF;
            }
        }
    }
    push @arr, $s;
}

my $ans = 0;
my @card_arr = (1) x (1+$#arr);
for my $card (0..$#arr) {
    for my $add (1..$arr[$card]) {
        $card_arr[$card+$add] += $card_arr[$card];
    }
}
say sum @card_arr;
