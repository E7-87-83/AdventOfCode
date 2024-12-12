use v5.30;
use warnings;

my @map;

while (<>) {
    chomp;
    push @map, [split ""];
}

my $m = $#map+1;
my $n = $map[0]->$#*+1;

my @vert;
my @hori;

for (1..$m) {
    push @vert, [(0) x ($n+1)];
}

for (1..$m+1) {
    push @hori, [(0) x $n];
}

for my $i (0..$m-1) {
    for my $j (0..$n-1) {
        if ($j == 0) {
            $vert[$i][$j] = !$vert[$i][$j];
        } elsif ($map[$i][$j-1] eq $map[$i][$j]) {
            $vert[$i][$j] = !$vert[$i][$j];
        }
        $vert[$i][$j+1] = !$vert[$i][$j+1];
        if ($i == 0) {
            $hori[$i][$j] = !$hori[$i][$j];
        } elsif ($map[$i-1][$j] eq $map[$i][$j]) {
            $hori[$i][$j] = !$hori[$i][$j];
        }
        $hori[$i+1][$j] = !$hori[$i+1][$j];
    }
}

my @visited;
my %seq;
my %cnt;
my %per;
for my $i (0..$m-1) {
    push @visited, [(0) x $n];
}

for my $pi (0..$m-1) {
    for my $pj (0..$n-1) {
        if (!$visited[$pi][$pj]) {
            $seq{$map[$pi][$pj]}++;
            my @stack = ();
            push @stack, [$pi, $pj];
            my $id = $map[$pi][$pj].",".$seq{$map[$pi][$pj]};
            while (@stack > 0) {
                my $c = pop @stack;
                my ($i, $j) = ($c->[0], $c->[1]);
                next if $visited[$i][$j];
                $visited[$i][$j] = 1;
                $cnt{$id}++;
                $per{$id} +=  $hori[$i][$j] + $vert[$i][$j]
                            + $hori[$i+1][$j] + $vert[$i][$j+1];
                            
                push @stack, [$i-1, $j] if $i > 0 && !$visited[$i-1][$j] && $map[$i-1][$j] eq $map[$i][$j];
                push @stack, [$i+1, $j] if $i+1 < $m && !$visited[$i+1][$j] && $map[$i+1][$j] eq $map[$i][$j];
                push @stack, [$i, $j-1] if $j > 0 && !$visited[$i][$j-1] && $map[$i][$j-1] eq $map[$i][$j];
                push @stack, [$i, $j+1] if $j+1 < $n && !$visited[$i][$j+1] && $map[$i][$j+1] eq $map[$i][$j];
            }
        }
    }
}

my $sum;

for my $c (keys %cnt) {
    say $c," ", $cnt{$c}, " ", $per{$c}," ",$cnt{$c} * $per{$c};
    $sum += $cnt{$c} * $per{$c};
}

say $sum;
