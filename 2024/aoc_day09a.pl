use v5.30;
use warnings;
use Data::Printer;
my @arr;
my @f_arr;
my @s_arr;
my @f_arr_location;
my @s_arr_location;
my $partial;
$_ = <>;
# $_ = $ARGV[0];
chomp;
my @format = split "";

for my $i (0..$#format) {
    if ($i % 2 == 0) {
        push @f_arr, [$i/2, $format[$i]];
        push @f_arr_location, $partial;
        push @arr, ($i/2) x $format[$i];
        $partial += $format[$i];
    } else {
        push @s_arr, $format[$i];
        push @s_arr_location, $partial;
        push @arr, (".") x $format[$i];
        $partial += $format[$i];
    }
}



for my $k (reverse 1..$#f_arr) {
    for my $s (0..$k-1) {
        if ($s_arr[$s] >= $f_arr[$k]->[1]) {
            $s_arr[$s] -= $f_arr[$k]->[1];
            $arr[$_] = "." for ($f_arr_location[$k]..$f_arr_location[$k]+$f_arr[$k]->[1]-1);
            $arr[$_] = $f_arr[$k]->[0] for ($s_arr_location[$s]..$s_arr_location[$s]+$f_arr[$k]->[1]-1);
            $s_arr_location[$s] += $f_arr[$k]->[1];
            last;
        }
    }
}


say join ",", @arr;
# say "00992111777.44.333....5555.6666.....8888..";

my $sum;
for my $i (0..$#arr) {
    $sum += $arr[$i]*$i if $arr[$i] ne ".";
}
say $sum;
