use v5.30;
use warnings;

my %adj;
my %conn;
my %node;

while (<>) {
    chomp;
    /^(\w{2})-(\w{2})$/;
    $conn{"$1-$2"} = 1 if $1 le $2;
    $conn{"$2-$1"} = 1 if $2 le $1;
    $node{$1} = 1;
    $node{$2} = 1;
    $adj{$1} = [] if !defined $adj{$1};
    $adj{$2} = [] if !defined $adj{$2};
    push $adj{$1}->@*, $2;
    push $adj{$2}->@*, $1;
}

my @arr;
my @ans;

for my $k (sort {$a cmp $b} keys %node) {
    for my $j (grep {$_ ge $k} $adj{$k}->@*) {
        for my $l (grep {$_ ge $j} $adj{$j}->@*) {
            push @arr, "$k-$j-$l" if $conn{"$k-$l"};
            push @ans, "$k-$j-$l" if  $conn{"$k-$l"} && (substr($k,0,1) eq "t" ||  substr($j,0,1) eq "t" || substr($l,0,1) eq "t");
        }
    }
}

use Data::Printer;
p @arr;  
say scalar @ans;  
