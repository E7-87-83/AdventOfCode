use v5.30.0;
use warnings;
use List::Util qw/all min max/;

open FH , '<', 'aoc_day4.txt';
my @arr;

my $ans = 0;

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
    say $s;
    $ans += 1 << ($s-1);
}


say $ans;
