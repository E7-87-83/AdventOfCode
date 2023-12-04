use v5.30.0;
use warnings;
use List::Util qw/all min max/;

open FH , '<', 'aoc_day3.txt';
my @arr = ("." x 200 , );
my @numbers;
my @number_locations;
while (<FH>) {
    chomp;
    my $line = ".". $_ . ".";
    push @arr, $line;
    my @my_arr;
    my @i_arr;
    my $i = 0;
    while ($i < length $line) {
        if (substr($line, $i) =~ /^(\d+)/) {
            my $num = $1;
            push @my_arr, $num;
            push @i_arr, $i;
            $i += 1 + length $num;
        }
        else {
            $i++;
        }
    }
    push @numbers, [@my_arr];
    push @number_locations, [@i_arr];
}

push @arr, ("." x 200);

my $ans = 0;

for my $m (0..$#numbers) {
    for my $k (0..$numbers[$m]->$#*) {
        my $surr =
          substr($arr[$m], $number_locations[$m][$k]-1, 2 + length $numbers[$m][$k])
        . substr($arr[$m+1], $number_locations[$m][$k]+length $numbers[$m][$k], 1)
        . reverse substr($arr[$m+2], $number_locations[$m][$k]-1, 2 + length $numbers[$m][$k])
        . substr($arr[$m+1], $number_locations[$m][$k]-1, 1);
        # say $numbers[$m][$k], " ", $surr;
        $ans += $numbers[$m][$k] if $surr =~ /[\*\#\$\+\&\!\%\/\=\@\-]/;
    }
}

say $ans;
