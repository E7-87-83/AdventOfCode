use v5.30;
use warnings;
use Data::Printer;

my @map;

while (<>) {
    chomp;
    push @map, [split ""];
}

my $num_of_anta;
my %anta;
my $m = $#map+1;
my $n = $map[0]->$#*+1;
for my $i (0..$m-1) {
    for my $j (0..$n-1) {
        if ($map[$i][$j] ne ".") {
            $anta{$map[$i][$j]} = [] if !defined $anta{$map[$i][$j]};
            push $anta{$map[$i][$j]}->@*, [$i,$j];
            $num_of_anta++;
        }
    }
}

my %anti;

for my $c (keys %anta) {
    my @arr = $anta{$c}->@*;
    for my $i (0..$#arr-1) {
        for my $j ($i+1..$#arr) {
            my $y1 = $arr[$i]->[0];
            my $y2 = $arr[$j]->[0];
            my $x1 = $arr[$i]->[1];
            my $x2 = $arr[$j]->[1];
            my $w1 = $x1+$x1-$x2;
            my $v1 = $y1+$y1-$y2;
            while ($v1 >= 0 && $v1 < $m && $w1 >= 0 && $w1 < $n) {
                $anti{"$v1,$w1"} = 1 if $map[$v1][$w1] eq ".";
                $w1 = $w1 + $x1-$x2;
                $v1 = $v1 + $y1-$y2;
            }
            my $w2 = $x2+$x2-$x1;
            my $v2 = $y2+$y2-$y1;
            while ($v2 >= 0 && $v2 < $m && $w2 >= 0 && $w2 < $n) {
                $anti{"$v2,$w2"} = 1 if $map[$v2][$w2] eq ".";
                $w2 = $w2 + $x2-$x1;
                $v2 = $v2 + $y2-$y1;
            }
        }
    }
}

# p %anti;
say ((scalar values %anti) + $num_of_anta);