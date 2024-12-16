use v5.30;
use warnings;
my $best_score = 85480; # to be changed
# my $best_score = 11048; # to be changed

my @paths;
my @map;

while (<>) {
    chomp;
    push @map, [split ""];
}

my $m = $#map+1;
my $n = $map[0]->$#*+1;

my %dir = (
    '^' => [-1,0],
    'v' => [1,0],
    '>' => [0,1],
    '<' => [0,-1],
);

my @stack;
my %visited;
$visited{join",",$m-2,1} = 0;
push @stack, [[$m-2, 1], 0, '>', (join",",$m-2,1)];
while (@stack > 0) {
    my $c = pop @stack;
    my $deer_loc = $c->[0];
    my $score = $c->[1];
    my $cur_d = $c->[2];
    my $path = $c->[3];
    for my $dd (keys %dir) {
        next if $dd eq '>' && $cur_d eq '<';
        next if $dd eq '<' && $cur_d eq '>';
        next if $dd eq '^' && $cur_d eq 'v';
        next if $dd eq 'v' && $cur_d eq '^';
        my $w = $dir{$dd};
        my $ny = $deer_loc->[0]+$w->[0];
        my $nx = $deer_loc->[1]+$w->[1];
        my $temp_score = $score + 1 + ($dd eq $cur_d ? 0 : 1000);
        next if $temp_score > $best_score;
        if ($map[$ny][$nx] eq '.' && !defined $visited{"$ny,$nx"}) {
            push @stack, [[$ny,$nx], $temp_score, $dd, (join",",$path,$ny,$nx)];
            $visited{"$ny,$nx"} = $temp_score;
        }
        if ($map[$ny][$nx] eq '.' && defined $visited{"$ny,$nx"}) {
            my $temp_score = $score + 1 + ($dd eq $cur_d ? 0 : 1000);
            if ($temp_score < $visited{"$ny,$nx"}) {
                push @stack, [[$ny,$nx], $temp_score, $dd,(join",",$path,$ny,$nx)];
                $visited{"$ny,$nx"} = $temp_score;
            } elsif ($temp_score == $visited{"$ny,$nx"}) {
                push @stack, [[$ny,$nx], $temp_score, $dd,(join",",$path,$ny,$nx)]; 
            } elsif ($temp_score > $visited{"$ny,$nx"} && $visited{"$ny,$nx"}+1999 > $temp_score) {
                push @stack, [[$ny,$nx], $temp_score, $dd,(join",",$path,$ny,$nx)]; 
            }
        }
        if ($map[$ny][$nx] eq 'E') {
            my $temp_score = $score + 1 + ($dd eq $cur_d ? 0 : 1000);
            if ($temp_score == $best_score) {
                push @paths, $path;
            }
        }
    }
}



use List::Util qw/pairs/;
my %sitable;
$sitable{join",",1,$n-2} = 1;
for my $p (@paths) {
    my @path = pairs split ",", $p;
    for my $l (@path) {
        $sitable{join ",",@$l} = 1;
    }
}
say scalar keys %sitable;
for my $i (0..$m-1) {
    for my $j (0..$n-1) {
        print $sitable{"$i,$j"} ? "O" : $map[$i][$j];
    }
    say "";
}

=pod
real	21m20.000s
user	21m19.409s
sys	0m0.036s
