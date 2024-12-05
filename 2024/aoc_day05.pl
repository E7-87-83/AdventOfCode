use v5.30;
use warnings;

my $isSectionOne = 1;
my @ord;
my $sum;

while (<>) {
    chomp;
    $isSectionOne = 0 if !$_;
    if ($isSectionOne) {
        push @ord, [split /\|/, $_];
    }
    if ($_ && !$isSectionOne) {
        my $mid = check($_);
        $sum += $mid if $mid != -1;
    }
}

say $sum;

sub check {
    my @arr = split ",", $_[0];
    my %p;
    for my $i (0..$#arr) {
        $p{$arr[$i]} = $i;
    }
    for my $m (@ord) {
        return -1 if defined($p{$m->[0]}) && defined($p{$m->[1]}) && ($p{$m->[0]} > $p{$m->[1]});
    }
    return $arr[$#arr/2];
}
