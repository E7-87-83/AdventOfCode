use v5.30;
use warnings;

my $sum;
while (<>) {
    chomp;
    /(\d+):([0-9\s]+)$/;
    my $ans = $1;
    my $remain = $2;
    my @arr = split " ", $remain;
    my $numOfOp = 1<<$#arr;
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
            last;
        }
    }
}

say $sum;
