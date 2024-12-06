use v5.30;
use warnings;
use Data::Printer;

my @map;
my @trace;

while (<>) {
    chomp;
    push @map, [split ""];
}

my $y;
my $x;
my $cur;

my $m = $#map+1;
my $n = $map[0]->$#*+1;

FD: for my $i (0..$m-1) {
    for my $j (0..$n-1) {
        if ($map[$i][$j] =~ /\^|v|\>|\</) {
            $y = $i;
            $x = $j;
            $cur = $map[$i][$j];
            last FD;
        }
    }
}

for (0..$m-1) {
    push @trace, [ (0) x $n ];
}

my %m = (
    "v" => [1,0],
    '^' => [-1,0],
    '>' => [0,1],
    '<' => [0,-1],
);

my %nxt = (
    "v" => '<',
    '<' => '^',
    '^' => '>',
    '>' => 'v',
);

while ($y < $m && $y >= 0 && $x < $n && $x >= 0) {
    $trace[$y][$x] = 1;
    my $ny = $y+$m{$cur}->[0];
    my $nx = $x+$m{$cur}->[1];
    if ($ny < $m && $ny >= 0 && $nx < $n && $nx >= 0 && $map[$ny][$nx] eq "#") {
        $cur = $nxt{$cur};
    } else {
        $y = $ny;
        $x = $nx;
    }
}

my $sum;

for my $i (0..$m-1) {
    for my $j (0..$n-1) {
        $sum++ if $trace[$i][$j];
    }
}

say $y, " ", $x;

say $sum;
