use v5.30;
use warnings;
use List::Util qw/pairs/;

my @map;

while (<>) {
    chomp;
    push @map, [split ""];
}

my $m = $#map+1;
my $n = $map[0]->$#*+1;
my $start;
my $dest;

for my $i (0..$m-1) {
    for my $j (0..$n-1) {
        $start = [$i,$j] if $map[$i][$j] eq "S";
        $dest = [$i,$j] if $map[$i][$j] eq "E";
    }
}
my @dir = ([0,1], [0,-1], [1,0], [-1,0]);

$map[$start->[0]][$start->[1]] = ".";
$map[$dest->[0]][$dest->[1]] = ".";

my %visited1;
$visited1{join",",$start->@*} = join",",$start->@*;
my @q;
push @q, [ $start->[0], $start->[1], (join",",$start->@*)];
WLOOP1: while (@q > 0) {
    my $c = shift @q;
    next WLOOP if (scalar split",",$c->[2]) > 9337*2;
    for my $d (@dir) {
        my $ny = $c->[0]+$d->[0];
        my $nx = $c->[1]+$d->[1];
        next if $ny < 0 || $nx < 0 || $ny >= $m || $nx >= $n;
        if (!defined $visited1{"$ny,$nx"} && $map[$ny][$nx] eq ".") {
            my $h = $c->[2];
            $visited1{"$ny,$nx"} = $h;
            $h = join ",",$h,$ny,$nx;
            push @q, [$ny, $nx, $h];
        }
        if (
            $ny == $dest->[0] && $nx == $dest->[1]
        ) {
            my $h = $c->[2];
            $h = join ",",$h,$ny,$nx;
            if (defined $visited1{"$ny,$nx"} && ((scalar split ",",$visited1{"$ny,$nx"}) > (scalar split ",",$h)))
            {
                $visited1{"$ny,$nx"} = $h;
                last WLOOP if (scalar split ",",$h) == 9337*2;
            } elsif (!defined $visited1{"$ny,$nx"}) {
                $visited1{"$ny,$nx"} = $h;
                last WLOOP if (scalar split ",",$h) == 9337*2;
            }
        }
    }
}

my @marker;
for my $i (0..$m-1) {
    for my $j (0..$n-1) {
        $marker[$i][$j] = "X";
    }
}

my @arr = pairs split ",",$visited1{join",",$dest->@*};
for my $p (@arr) {
    $marker[$p->[0]][$p->[1]] = "O";
}
$marker[$dest->[0]][$dest->[1]] = "O";

my %gap;
my $cnt;
for my $i (0..$m-1) {
    for my $j (0..$n-1) {
        print $marker[$i][$j] eq "O" ? "O" : $map[$i][$j];
        next if $i == 0 || $j == 0 || $i == $m-1 || $j == $n-1;
        if ($map[$i][$j] eq "#" 
                && 
            ($marker[$i][$j-1] eq "O" && $marker[$i][$j+1] eq "O"
                                ||
             $marker[$i-1][$j] eq "O" && $marker[$i+1][$j] eq "O")) {
            if ($marker[$i][$j-1] eq "O" && $marker[$i][$j+1] eq "O") {
                my $d1 = (scalar split ",", $visited1{join",",$i,$j-1})/2;
                my $d2 = (scalar split ",", $visited1{join",",$i,$j+1})/2;
                $gap{"$i,$j"} = abs($d1-$d2)-2;
            } elsif ($marker[$i-1][$j] eq "O" && $marker[$i+1][$j] eq "O") {
                my $d1 = (scalar split ",", $visited1{join",",$i-1,$j})/2;
                my $d2 = (scalar split ",", $visited1{join",",$i+1,$j})/2;
                my $d = abs($d1-$d2)-2;
                $gap{"$i,$j"} = defined $gap{"$i,$j"} && $d > $gap{"$i,$j"} ? $gap{"$i,$j"} : $d;
            }
            $cnt++ if $gap{"$i,$j"} >= 100;
        }
    }
    say "";
}
say $cnt;

