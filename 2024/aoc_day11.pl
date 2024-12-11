use v5.30;
use warnings;
use List::MoreUtils qw/arrayify/;

sub transform {
    my $v = $_[0];
    return 1 if $v == 0;
    if ((length $v) % 2 == 0) {
        my $s0 = substr $v, 0, (length $v)/2;
        my $s1 = substr $v, (length $v)/2;
        $s1 =~ s/^0+(?=[0-9])//;
        return [$s0, $s1];
    }
    return $v*2024;
}

$_ = <STDIN>;
chomp;
my @arr = split " ";

for (1..25) {
    @arr = arrayify (map {transform $_} @arr);
}

# say join " ", @arr;
say scalar @arr;

