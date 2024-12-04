use v5.30;
use warnings;

my @dir = ([1,1],[1,-1],[1,0],[0,1]);

my $sum;

my @map;

while (<>) {
    chomp;
    push @map, [split ""];
}

for my $d (@dir) {
    for my $i (0..$#map) {
        for my $j (0..$map[0]->$#*) {
            if ("X" eq $map[$i]->[$j]) {
                $sum++ if ($i+3*$d->[0] >= 0 && $i+3*$d->[0] <= $#map)
                            &&
                          ($j+3*$d->[1] >= 0 && $j+3*$d->[1] <= $map[0]->$#*)
                            &&
                          "M" eq $map[$i+$d->[0]][$j+$d->[1]] 
                            &&
                          "A" eq $map[$i+2*$d->[0]][$j+2*$d->[1]] 
                            &&
                          "S" eq $map[$i+3*$d->[0]][$j+3*$d->[1]];
                $sum++ if ($i-3*$d->[0] >= 0 && $i-3*$d->[0] <= $#map)
                            &&
                          ($j-3*$d->[1] >= 0 && $j-3*$d->[1] <= $map[0]->$#*)
                            &&
                           "M" eq $map[$i-$d->[0]][$j-$d->[1]] 
                            &&
                          "A" eq $map[$i-2*$d->[0]][$j-2*$d->[1]] 
                            &&
                          "S" eq $map[$i-3*$d->[0]][$j-3*$d->[1]];
            }
        }
    }
}

say $sum;
