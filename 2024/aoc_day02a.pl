use v5.30;
use warnings;

my $sum;

while (<>) {
    chomp;
    my @arr = split " ";
    $sum++ if check(@arr);
}

say $sum;

sub check {
    my $bad = 0;
    my @arr = @_;
    my $sgn;
    for my $i (0..$#arr-1) {
        my $diff = $arr[$i]-$arr[$i+1];
        $bad++ if $diff == 0;
        if ($diff != 0 && !defined($sgn)) {
            $sgn = $diff/abs($diff);
            my $df1 = $arr[$i+1]-$arr[$i+2];
            my $df2 = $arr[$i+2]-$arr[$i+3];
            return 0 if $df1 == 0 || $df2 == 0;
            my $sgn1 = $df1/abs($df1);
            my $sgn2 = $df2/abs($df2);
            my $s = $sgn1+$sgn2+$sgn;
            $sgn = $s / abs($s);
        }
        $bad++ if $diff != 0 && $diff/abs($diff) != $sgn;
        $bad++ if abs($diff) > 3;
        return 0 if $bad >= 2
    }
    say join " ", @arr;
    return 1 if $bad <= 1;
}
