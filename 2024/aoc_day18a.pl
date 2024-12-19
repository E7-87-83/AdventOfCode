use v5.30;
use warnings;
use Storable qw/dclone/;
use List::Util qw/min/;
my $m;
my $n;

# ($m,$n) = (7,7); #to be changed 
($m, $n) = (71, 71);
my @arr;

while (<>) {
    chomp;
    /^(\d+),(\d+)$/;
    push @arr, [$1,$2];
}
my $left = 1024;
my $right = 3449;
WLOOP: while ($left < $right - 1) {
    my $mid = int(($left+$right)/2);
    say $mid;
    my @map;

    for (1..$m) {
        push @map, [(".") x $n];
    }


    for my $i (0..$mid-1) {
        $map[$arr[$i]->[0]][$arr[$i]->[1]] = "#";
    }

    my @dir = ([0,1], [0,-1], [1,0], [-1,0]);

    my @ans;
    my @q;
    my $count = 0;
    push @q, [0,0, "0,0"];
    my %visited;
    $visited{"0,0"} = 1;
    WLOOP: while (@q > 0) {
        my $c = shift @q;
        for my $d (@dir) {
            my $ny = $c->[0]+$d->[0];
            my $nx = $c->[1]+$d->[1];
            next if $ny < 0 || $nx < 0 || $ny >= $m || $nx >= $n;
            if ($ny == $m-1 && $nx == $n-1) {
                my $h = $c->[2];
                $count++;
                $h = join ",",$h,$ny,$nx;
                push @ans, $h;
            }
            if (!defined $visited{"$ny,$nx"} && $map[$ny][$nx] eq ".") {
                my $h = $c->[2];
                $h = join ",",$h,$ny,$nx;
                $visited{"$ny,$nx"} = $h;
                push @q, [$ny, $nx, $h];
            }
            if (defined $visited{"$ny,$nx"}) {
                my $h = $c->[2];
                $h = join ",",$h,$ny,$nx;
                if ((scalar split ",",$visited{"$ny,$nx"}) > (scalar split ",",$h))
                {$visited{"$ny,$nx"} = $h;}
            }
        }
    }

    if (!$visited{"70,70"}) {
        $right = $mid-1;
    } else {
        $left = $mid+1;
    }
}

say $left;
