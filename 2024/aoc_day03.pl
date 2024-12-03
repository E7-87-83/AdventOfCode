use v5.30;
use warnings;

my $sum;

while (<>) {
    my @matches = ($_ =~ /mul\(\d{1,3},\d{1,3}\)/g);
    for my $m (@matches) {
        $m =~ /(\d+),(\d+)/;
        $sum += $1*$2;
    }
    say join "\n", @matches;
}

say $sum;
