use v5.30;
use warnings;

my $sum;
my $do = 1;

while (<>) {
    my @matches = ($_ =~ /mul\(\d{1,3},\d{1,3}\)|do\(\)|don\'t\(\)/g);
    for my $m (@matches) {
        if ($m eq 'do()') {
            $do = 1;
            next;
        } elsif ($m eq 'don\'t()') {
            $do = 0;
            next;
        } else {
            $m =~ /(\d+),(\d+)/;
            $sum += $1*$2 if $do;
        }
    }
    say join "\n", @matches;
}

say $sum;
