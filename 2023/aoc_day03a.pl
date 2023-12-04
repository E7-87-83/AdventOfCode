use v5.30.0;
use warnings;

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
my %star;

for my $m (0..$#numbers) {
    for my $k (0..$numbers[$m]->$#*) {
        my @s;
        $s[0] = substr($arr[$m], $number_locations[$m][$k]-1, 2 + length $numbers[$m][$k]);
        $s[1] = substr($arr[$m+2], $number_locations[$m][$k]-1, 2 + length $numbers[$m][$k]);
        for my $i (0..1) {
            my $j=0;
            my $_m = $i ? $m+2 : $m;
            while (index($s[$i], "*", $j) > -1) {
                $j = index($s[$i], "*", $j);
                my $_k = $number_locations[$m][$k]-1+$j;
                $star{"$_m,$_k"} = [] if !$star{"$_m,$_k"};
                push $star{"$_m,$_k"}->@*, $numbers[$m][$k];
                $j = $j + 1;
            }
        }
        if ("*" eq substr($arr[$m+1], $number_locations[$m][$k]+length $numbers[$m][$k], 1)) {
            my $_m = $m+1;
            my $_k = $number_locations[$m][$k] + length $numbers[$m][$k];
            $star{"$_m,$_k"} = [] if !$star{"$_m,$_k"};
            push $star{"$_m,$_k"}->@*, $numbers[$m][$k];
        }
        if ("*" eq substr($arr[$m+1], $number_locations[$m][$k]-1, 1)) {
            my $_m = $m+1;
            my $_k = $number_locations[$m][$k]-1;
            $star{"$_m,$_k"} = [] if !$star{"$_m,$_k"};
            push $star{"$_m,$_k"}->@*, $numbers[$m][$k];
        }
    }
}

for my $ke (keys %star) {
    my $v = $star{$ke};
    if (scalar $v->@* == 2) {
        $ans += $v->[0]*$v->[1];
    }
}

say $ans;
