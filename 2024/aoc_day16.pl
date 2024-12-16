use v5.30;
use warnings;

my @map;

while (<>) {
    chomp;
    push @map, [split ""];
}

my $m = $#map+1;
my $n = $map[0]->$#*+1;

my %dir = (
    'v' => [1,0],
    '^' => [-1,0],
    '>' => [0,1],
    '<' => [0,-1],
);

my @stack;
my %visited;
$visited{join",",$m-2,1} = 0;
push @stack, [[$m-2, 1], 0, '>'];
while (@stack > 0) {
    my $c = pop @stack;
    my $deer_loc = $c->[0];
    my $score = $c->[1];
    my $cur_d = $c->[2];
    for my $dd (keys %dir) {
        next if $dd eq '>' && $cur_d eq '<';
        next if $dd eq '<' && $cur_d eq '>';
        next if $dd eq '^' && $cur_d eq 'v';
        next if $dd eq 'v' && $cur_d eq '^';
        my $w = $dir{$dd};
        my $ny = $deer_loc->[0]+$w->[0];
        my $nx = $deer_loc->[1]+$w->[1];
        if ($map[$ny][$nx] eq '.' && !defined $visited{"$ny,$nx"}) {
            push @stack, [[$ny,$nx], $score+1+ ($dd eq $cur_d ? 0 : 1000), $dd];
            $visited{"$ny,$nx"} = $score+1+ ($dd eq $cur_d ? 0 : 1000);
        }
        if ($map[$ny][$nx] eq '.' && defined $visited{"$ny,$nx"}) {
            my $temp_score = $score + 1 + ($dd eq $cur_d ? 0 : 1000);
            if ($temp_score < $visited{"$ny,$nx"}) {
                push @stack, [[$ny,$nx], $temp_score, $dd];
                $visited{"$ny,$nx"} = $temp_score;
            }
        }
        if ($map[$ny][$nx] eq 'E') {
            my $temp_score = $score + 1 + ($dd eq $cur_d ? 0 : 1000);
            if (!defined $visited{"$ny,$nx"} || $temp_score < $visited{"$ny,$nx"}) {
                $visited{"$ny,$nx"} = $temp_score;
            }
        }
    }
}

say $visited{join",",1,$n-2};
