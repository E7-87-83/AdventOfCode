use v5.30;
use warnings;
use Math::BaseCnv "cnv";

my $sum;
my @check;
while (<>) {
    chomp;
    /(\d+):([0-9\s]+)$/;
    my $ans = $1;
    my $remain = $2;
    my @arr = split " ", $remain;
    my $numOfOp = 1<<$#arr;
    my $flag = 0;
    for my $g (0..$numOfOp-1) {
        my @guide = split "", substr(unpack("B32", pack("N", $g)),-$#arr);
        my $temp = $arr[0];
        for my $i (1..$#arr) {
            if (!$guide[$i-1]) {
                $temp += $arr[$i];
            } else {
                $temp *= $arr[$i];
            }
        }
        if ($temp == $ans) {
            $sum += $ans;
            $flag = 1;
            last;
        }
    }
    push @check, [ $ans, [@arr]] if !$flag;
}

my %sign = (
    0 => "-",
    1 => "/",
    2 => ".",
);

LOOP: for my $j (0..$#check) {
    say $j;
    my $c = $check[$j];
    my $ans = $c->[0];
    my @arr = $c->[1]->@*;
    my $numOfOp = 3**$#arr;
    for my $g (0..$numOfOp-1) {
        my @stack;
        push @stack, [$ans, $#arr, $sign{0}];
        push @stack, [$ans, $#arr, $sign{1}];
        push @stack, [$ans, $#arr, $sign{2}];
        while (@stack > 0) {
            my $cur = pop @stack;
            my $temp = $cur->[0];
            my $i = $cur->[1];
            my $sign = $cur->[2];
            #say join " ", $ans, $temp, $i, $sign;
            if ($sign eq "-") {
                $temp -= $arr[$i];
                if ($i == 0) {
                    if ($temp == 0) {
                        $sum += $ans; 
                        next LOOP;
                    }
                } elsif ($temp > 0) {
                    push @stack, [$temp, $i-1, $sign{0}];
                    push @stack, [$temp, $i-1, $sign{1}];
                    push @stack, [$temp, $i-1, $sign{2}];
                }
            } elsif ($sign eq "/") {
                if ($temp % $arr[$i] == 0) {
                    $temp /= $arr[$i];
                    if ($i == 0) {
                        if ($temp == 1) {
                            $sum += $ans;
                            next LOOP;
                        }
                    } else {
                        push @stack, [$temp, $i-1, $sign{0}];
                        push @stack, [$temp, $i-1, $sign{1}];
                        push @stack, [$temp, $i-1, $sign{2}];
                    }
                }
            } elsif ($sign eq ".") {
                if (substr($temp,-length "$arr[$i]") eq "$arr[$i]") {
                    $temp = substr( $temp, 0 , (length("$temp")-length("$arr[$i]")));
                    if ($i == 0) {
                        if ($temp eq "") {
                            $sum += $ans; 
                            next LOOP;
                        }
                    } elsif ($temp ne "") {
                        push @stack, [$temp, $i-1, $sign{0}];
                        push @stack, [$temp, $i-1, $sign{1}];
                        push @stack, [$temp, $i-1, $sign{2}];
                    }
                }
            }
        }
    }
}

say $sum;
