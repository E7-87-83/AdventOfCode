use v5.30;
use warnings;

my @dir = ([1,1],[-1,-1],[-1,1],[1,-1]);

my $sum;

my @map;

while (<>) {
    chomp;
    push @map, [split ""];
}

for my $i (0..$#map) {
    LP: for my $j (0..$map[0]->$#*) {
        if ("A" eq $map[$i]->[$j]) {
            next LP unless ($i+1 >= 0 && $i+1 <= $#map)
                                 &&
                           ($j+1 >= 0 && $j+1 <= $map[0]->$#*)
                                 &&
                           ($i-1 >= 0 && $i-1 <= $#map)
                                 &&
                           ($j-1 >= 0 && $j-1 <= $map[0]->$#*);
            my $str = "";
            for my $d (@dir) {
                $str .= $map[$i-$d->[0]][$j-$d->[1]];
            }
            $sum++ if $str =~ /MSMS|MSSM|SMSM|SMMS/;
        }
    }
}

say $sum;
