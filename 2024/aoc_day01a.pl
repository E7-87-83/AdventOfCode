use v5.30.0;
use warnings;
use List::MoreUtils qw/frequency/;

my @list;

while (<>) {
    chomp;
    my @row = split /\s+/;
    push @list, [@row]; 
}

my @lst1, my @lst2;

for (@list) {
    push @lst1, $_->[0];
    push @lst2, $_->[1];
}

my %freq = frequency @lst2;


my $sum;

for (@lst1) {
    $sum += $_* $freq{$_} if defined $freq{$_};
}

say $sum;
