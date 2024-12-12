use v5.30;
use warnings;
use List::Util qw/uniqnum uniqstr/;
use Data::Printer;
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

my %uhori_side;
my %rvert_side;

my %dhori_side;
my %lvert_side;


my @visited;
my %seq;
my %cnt;
my %sid;
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
                $rvert_side{join ",",$i,$j} = "$id|$j" if $vert[$i][$j];
                $lvert_side{join ",",$i,$j} = "$id|$j" if $vert[$i][$j+1];
                $dhori_side{join ",",$i,$j} = "$id|$i" if $hori[$i][$j];
                $uhori_side{join ",",$i,$j} = "$id|$i" if $hori[$i+1][$j];
                push @stack, [$i-1, $j] if $i > 0 && !$visited[$i-1][$j] && $map[$i-1][$j] eq $map[$i][$j];
                push @stack, [$i+1, $j] if $i+1 < $m && !$visited[$i+1][$j] && $map[$i+1][$j] eq $map[$i][$j];
                push @stack, [$i, $j-1] if $j > 0 && !$visited[$i][$j-1] && $map[$i][$j-1] eq $map[$i][$j];
                push @stack, [$i, $j+1] if $j+1 < $n && !$visited[$i][$j+1] && $map[$i][$j+1] eq $map[$i][$j];
            }
        }
    }
}

my %vert_side;
my @verts = ({%rvert_side}, {%lvert_side});
my @vind = ("r", "l");
for my $v (0..1) { 
    my $w = 0;
    for my $c (sort { [split ",",$a]->[0] <=> [split ",",$b]->[0] } keys $verts[$v]->%*) {
        my @ind = split ",", $c;
        my $upp = $verts[$v]->{join",",$ind[0]-1,$ind[1]};
        if (defined $upp && $verts[$v]->{$c} eq $upp) {
            $vert_side{join ",",$vind[$v],@ind} = $vert_side{join ",",$vind[$v],$ind[0]-1,$ind[1]};
        } else {
            $vert_side{join ",",$vind[$v],@ind} = join "|",$vind[$v],$verts[$v]->{$c},++$w;
        }
    }
}

my %hori_side;
my @horis = ({%dhori_side}, {%uhori_side});
my @hind = ("d", "u");
for my $h (0..1) { 
    my $w = 0;
    for my $c (sort { [split ",",$a]->[1] <=> [split ",",$b]->[1] } keys $horis[$h]->%*) {
        my @ind = split ",", $c;
        my $upp = $horis[$h]->{join",",$ind[0],$ind[1]-1};
        if (defined $upp && $horis[$h]->{$c} eq $upp) {
            $hori_side{join ",",$hind[$h],@ind} = $hori_side{join ",",$hind[$h],$ind[0],$ind[1]-1};
        } else {
            $hori_side{join ",",$hind[$h],@ind} = join "|",$hind[$h],$horis[$h]->{$c},++$w;
        }
    }
}

#say scalar uniqstr values %vert_side;
#say scalar uniqstr values %hori_side;


#p %vert_side;
#p %hori_side;

for my $v (uniqstr values %hori_side) {
    my @ind = split /\|/, $v;
    $sid{$ind[1]}++;
}
for my $v (uniqstr values %vert_side) {
    my @ind = split /\|/, $v;
    $sid{$ind[1]}++;
}


my $sum;

for my $c (keys %cnt) {
    # say $c," ", $cnt{$c}, " ", $sid{$c}," ",$cnt{$c} * $sid{$c};
    $sum += $cnt{$c} * $sid{$c};
}

say $sum;
=cut
