use v5.30;
use warnings;

my @map;
my @inst;

while (<>) {
    chomp;
    if (/^\#/) {
        push @map, [split ""];
    } elsif (/^$/) {
    } else {
        push @inst, split "";
    }
}

my $m = $#map+1;
my $n = $map[0]->$#*+1;

my %dir = (
    '^' => [-1,0], 
    'v' => [1,0],
    '>' => [0,1],
    '<' => [0,-1],
);

my $robot_loc;
LOOP: for my $i (0..$m-1) {
    for my $j (0..$n-1) { 
        if ($map[$i][$j] eq '@') {
            $robot_loc = [$i, $j];
            last LOOP;
        }
    }
}

for my $w (@inst) {
    my $ny = $robot_loc->[0]+$dir{$w}->[0];
    my $nx = $robot_loc->[1]+$dir{$w}->[1];
    if ($map[$ny][$nx] eq '.') {
        $map[$robot_loc->[0]][$robot_loc->[1]] = '.';
        $robot_loc->[0] = $ny;
        $robot_loc->[1] = $nx;
    } elsif ($map[$ny][$nx] eq '#') {
    } elsif ($map[$ny][$nx] eq 'O') {
        my $ty = $ny;
        my $tx = $nx;
        while ($map[$ty][$tx] eq 'O') {
            $ty += $dir{$w}->[0];
            $tx += $dir{$w}->[1];
        }
        if ($map[$ty][$tx] eq '#') {
        } elsif ($map[$ty][$tx] eq '.') {
            $map[$robot_loc->[0]][$robot_loc->[1]] = '.';
            $robot_loc->[0] = $ny;
            $robot_loc->[1] = $nx;
            $map[$ny][$nx] = '.';
            $map[$ty][$tx] = 'O';
        }
    }
    #print_screen();
}

my $sum;
for my $i (0..$m-1) {
    for my $j (0..$n-1) {
        $sum += 100*$i+$j if $map[$i][$j] eq 'O';
    }
}

say $sum;



sub print_screen {
    for my $i (0..$m-1) {
        say $map[$i]->@*;
    }
    say "";
}
