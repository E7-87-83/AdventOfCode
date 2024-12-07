use v5.30;
use warnings;
use Data::Printer;

my @cmap;

while (<>) {
    chomp;
    push @cmap, [split ""];
}

my $ccur;
my $cx;
my $cy;

my $m = $#cmap+1;
my $n = $cmap[0]->$#*+1;
my $sum;

FD: for my $i (0..$m-1) {
    for my $j (0..$n-1) {
        if ($cmap[$i][$j] =~ /\^|v|\>|\</) {
            $cy = $i;
            $cx = $j;
            $ccur = $cmap[$i][$j];
            last FD;
        }
    }
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

sub new_ob {
    my @trace;
    for (0..$m-1) {
        push @trace, [(0) x $n];
    }
    say "try ", $_[0], " ", $_[1];
    my @map;
    for my $i (0..$m-1) {
        for my $j (0..$n-1) {
            $map[$i][$j] = $cmap[$i][$j];
        }
    } 
    $map[$_[0]][$_[1]] = "O";
    my $total_trace = 0;
    my $step = 0;
    my $y = $cy;
    my $x = $cx;
    my $cur = $ccur;
    my $flag = 0;

    while (!($step > $total_trace*2 && $flag) && 
        $y < $m && $y >= 0 && $x < $n && $x >= 0
    ) {
        # say $cur, " ", $y, " ", $x;
        if (!$trace[$y][$x]) {
            $trace[$y][$x] = 1;
            $total_trace++;
        } else {
            $flag = 1;
        }
        my $ny = $y+$m{$cur}->[0];
        my $nx = $x+$m{$cur}->[1];

        if ($ny < $m && $ny >= 0 && $nx < $n && $nx >= 0 && 
            ($map[$ny][$nx] eq "#" || $map[$ny][$nx] eq "O")
        ) {
            $cur = $nxt{$cur};
        } else {
            $y = $ny;
            $x = $nx;
            $step++;
        }
    }

    $sum++ if $step > $total_trace*2 && $flag;

}

# BEGIN: From Part I
my @trace;
my $y = $cy;
my $x = $cx;
my $cur = $ccur;
while ($y < $m && $y >= 0 && $x < $n && $x >= 0) {
    $trace[$y][$x] = 1;
    my $ny = $y+$m{$cur}->[0];
    my $nx = $x+$m{$cur}->[1];
    if ($ny < $m && $ny >= 0 && $nx < $n && $nx >= 0 && $cmap[$ny][$nx] eq "#") {
        $cur = $nxt{$cur};
    } else {
        $y = $ny;
        $x = $nx;
    }
}
# END: From Part I

for my $i (0..$m-1) {
    for my $j (0..$n-1) {
        new_ob($i,$j) if $cmap[$i][$j] eq "." && $trace[$i][$j];
    }
}


say $sum;

# 38.855s
