use v5.30.0;
use warnings;
use List::Util qw/min/;

sub inbtw {
    my ($a, $x, $y) = @_;
    return ($a >= $x && $y >= $a);
}

my %seeds = qw/564468486 226119074 3264322485 135071952 3144185610 89794463 1560365167 555667043 2419038624 7808461 1264209624 9380035 105823719 425973940 4115473551 104486997 3784956593 300187503 975280918 257129208/;

# %seeds = qw/79 14 55 13/;
my @seed;

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





my $min = 382763561200;
my $minKey = 1;

for my $k (keys %seeds) {
    say $k;
    for (0..100) {
    # for my $s ($k..$k+$seeds{$k}-1) {
    $seed[0] = $k+int(rand($seeds{$k}));
    for my $c (0..6) {
        my $ch = 0;
        RULE: for my $i (0..$map[$c]->$#*) {

            if (inbtw($seed[$c], $map[$c][$i][1], $map[$c][$i][1]+$map[$c][$i][2]-1)) {
                $seed[$c+1] = $map[$c][$i][0]+$seed[$c]-$map[$c][$i][1];
                $ch = 1;
                last RULE;
            }

        }
        $seed[$c+1] = $seed[$c] if $ch == 0;
    }
    if ($min > $seed[7]) {
        $min = $seed[7];
        $minKey = $k;
    }
}
}
say $min;
say $minKey;

say "===========================";

my $minKKey;
for (0..1000000) {
# for my $s ($minKey..$minKey+$seeds{$minKey}-1) {
    $seed[0] = $minKey+int(rand($seeds{$minKey}));
#    $seed[0] = $s;
    for my $c (0..6) {
        my $ch = 0;
        RULE: for my $i (0..$map[$c]->$#*) {

            if (inbtw($seed[$c], $map[$c][$i][1], $map[$c][$i][1]+$map[$c][$i][2]-1)) {
                $seed[$c+1] = $map[$c][$i][0]+$seed[$c]-$map[$c][$i][1];
                $ch = 1;
                last RULE;
            }

        }
        $seed[$c+1] = $seed[$c] if $ch == 0;
    }
    if ($min > $seed[7]) {
        $min = $seed[7];
        $minKKey = $seed[0];
        say $min, " ", $minKKey;
    }
}


say $minKKey;
for my $s ($minKKey-10000..$minKKey+10000) {
    $seed[0] = $s;
    for my $c (0..6) {
        my $ch = 0;
        RULE: for my $i (0..$map[$c]->$#*) {

            if (inbtw($seed[$c], $map[$c][$i][1], $map[$c][$i][1]+$map[$c][$i][2]-1)) {
                $seed[$c+1] = $map[$c][$i][0]+$seed[$c]-$map[$c][$i][1];
                $ch = 1;
                last RULE;
            }

        }
        $seed[$c+1] = $seed[$c] if $ch == 0;
    }
    if ($min > $seed[7]) {
        $min = $seed[7];
    }
}


say $min;

=pod
...
105823719
===========================
53039804 386562935
52544447 386067578
52473870 385997001
52435804 385958935
52319613 385842744
52225395 385748526
52224160 385747291
52223973 385747104
52221046 385744177
52216717 385739848
52213406 385736537
52211935 385735066
52211322 385734453
385734453
52210644

real	1m12.935s
user	1m12.603s
sys	0m0.016s
