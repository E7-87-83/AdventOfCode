use v5.30;
use warnings;
use Data::Printer;
my $ind;
my @cond;
my @t_arr;
while (<>) {
    chomp;
    if (/Button A: X\+(\d+), Y\+(\d+)/) {
        @t_arr = ();
        push @t_arr, $1, $2;
    }
    if (/Button B: X\+(\d+), Y\+(\d+)/) {
        push @t_arr, $1, $2;
    }
    if (/Prize: X=(\d+), Y=(\d+)/) {
        push @t_arr, $1, $2;
        push @cond, [@t_arr];
    }
}

my $sum;

for my $row (@cond) {
    my @arr = $row->@*;
    my $cost = 411;
    for my $i (0..100) {
        for my $j (0..100) {
            if ($arr[0]*$i+$arr[2]*$j == $arr[4] && 
                 $arr[1]*$i+$arr[3]*$j == $arr[5]) {
                my $t_cost = 3*$i + $j;
                $cost = $t_cost < $cost ? $t_cost : $cost;
            }
        }
    }
    if ($cost != 411) {
        $sum += $cost;
    }
}

say $sum;
