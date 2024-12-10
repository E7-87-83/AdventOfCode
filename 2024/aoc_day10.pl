use v5.30;
use warnings;
use Data::Printer;

my @map;
while (<>) {
    chomp;
    push @map, [split ""];
}

my $m = $#map+1;
my $n = $map[0]->$#*+1;

my %zero;

for my $i (0..$m-1) {
    for my $j (0..$n-1) {
        $zero{"$i,$j"} = 1 if $map[$i][$j] eq "0";
    }
}

my @dir = ([0,1], [0,-1], [1,0], [-1,0]);
my %com_trail;

for my $ind (keys %zero) {
    my ($si, $sj) = split ",", $ind;
    my @stack = ();
    push @stack, [[$si, $sj], 0, [$si,$sj]];
    while (@stack > 0) {
        my $c = pop @stack;
        for my $d (@dir) {
            my $ni = $c->[0][0]+$d->[0];
            my $nj = $c->[0][1]+$d->[1];
            next if $ni < 0 || $ni >= $m;
            next if $nj < 0 || $nj >= $n;
            if ($map[$ni][$nj] eq "@{[1+$c->[1]]}") {
                push @stack, [[$ni, $nj], 1+$c->[1], $c->[2]];
                # say join " ", $ni, $nj, 1+$c->[1];
            } 
            if ($c->[1] == 8 && $map[$ni][$nj] eq "9") {
                pop @stack;
                $com_trail{join",",$c->[2]->@*,$ni,$nj} = 1;
            }
        }
    }
}

# p %com_trail;
say scalar keys %com_trail;
