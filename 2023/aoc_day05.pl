use v5.30.0;
use warnings;
use List::Util qw/min/;

sub inbtw {
    my ($a, $x, $y) = @_;
    return ($a >= $x && $y >= $a);
}

my @seeds = qw/564468486 226119074 3264322485 135071952 3144185610 89794463 1560365167 555667043 2419038624 7808461 1264209624 9380035 105823719 425973940 4115473551 104486997 3784956593 300187503 975280918 257129208/;


my @seed = map {[$_]} @seeds;

my @map;
open FH , '<', 'aoc_day5.txt';
my $m = -1;
my $i = 0;
while (<FH>) {
    chomp;
    if (/[a-z]+/) {
        $m++;
        $map[$m] = [];
        $i = 0;
        next;
    }
    elsif (/^$/) {
        next;
    }
    $map[$m][$i] = [];
    /^(\d+) (\d+) (\d+)$/;
    push $map[$m][$i]->@*, $1, $2, $3;
    $i++;
}


# if inbtw($seed[$s][0], $map[0][$i][1], $map[0][$i][1]+$map[0][$i][2]) {
#     $seed[$s][1] = $map[0][$i][0]+$seed[$s][0]-$map[0][$i][1]
# }

for my $s (0..$#seed) {
    for my $c (0..6) {
        my $ch = 0;
        RULE: for my $i (0..$map[$c]->$#*) {

if (inbtw($seed[$s][$c], $map[$c][$i][1], $map[$c][$i][1]+$map[$c][$i][2]-1)) {
    $seed[$s][$c+1] = $map[$c][$i][0]+$seed[$s][$c]-$map[$c][$i][1];
    $ch = 1;
    last RULE;
}

        }
        $seed[$s][$c+1] = $seed[$s][$c] if $ch == 0;
    }
}

say min map {$_->[7]} @seed;
