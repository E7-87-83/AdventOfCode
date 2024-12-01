use v5.30.0;
use warnings;

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

@lst1 = sort {$a<=>$b} @lst1;
@lst2 = sort {$a<=>$b} @lst2;

my $sum;

for my $i (0..$#lst1) {
    $sum += abs($lst1[$i]-$lst2[$i]);
}

say $sum;
