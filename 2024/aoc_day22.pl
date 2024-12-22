use v5.30;
use warnings;
use List::Util qw/sum/;

sub process {
    my $init = $_[0];
    $init = ($init ^ ($init << 6)) % 16777216;
    $init = ($init ^ ($init >> 5)) % 16777216;
    $init = ($init ^ ($init << 11)) % 16777216;
}

sub p2 {
    my $i = $_[0];
    say $i;
    for (1..2000) {
        $i = process($i);
    }
    return $i;
}

my @arr;

while (<>) {
    chomp;
    push @arr, p2($_)
}

say sum @arr;
