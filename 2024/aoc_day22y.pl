# solve by guessing patterns

use v5.30;
use warnings;
use List::Util qw/sum max/;

sub process {
    my $init = $_[0];
    $init = ($init ^ ($init << 6)) % 16777216;
    $init = ($init ^ ($init >> 5)) % 16777216;
    $init = ($init ^ ($init << 11)) % 16777216;
}

sub p2 {
    my $i = $_[0];
    my @brr;
    my @orr;
    for (1..2000) {
        my $old = substr($i,-1,1);
        push @orr, $old;
        $i = process($i);
        push @brr, substr($i,-1,1)-$old;
    }
    push @orr, substr($i,-1,1);
    return [[@brr], [@orr]];
}

my @arr;
my %boss;

while (<>) {
    chomp;
    my $ans = p2($_);
    push @arr, $ans;
}


for my $c (1..$#arr) {
my @fbrr = $arr[$c]->[0]->@*;

sub f_ans {
    my ($b, $o) = $_[0]->@*;
    my $i = $_[1];
    my @brr = $b->@*; 
    my @my_orr = $o->@*;
    for my $k (3..$#fbrr) {
         return $my_orr[$k] if $brr[$k-1] == $fbrr[$i+1-1] && $brr[$k-2] == $fbrr[$i+1-2] && $brr[$k-3] == $fbrr[$i+1-3] && $brr[$k-4] == $fbrr[$i+1-4];
    }
    return 0;
}

my @jrr;

for my $ind (3..$#fbrr) {
    next if $boss{join",", ($fbrr[$ind],$fbrr[$ind-1],$fbrr[$ind-2],$fbrr[$ind-3])};
    next unless sum($fbrr[$ind],$fbrr[$ind-1],$fbrr[$ind-2],$fbrr[$ind-3]) >= 0  
                && sum($fbrr[$ind],$fbrr[$ind-1],$fbrr[$ind-2],$fbrr[$ind-3]) <= 2 
                && $fbrr[$ind-1] >= -3 && $fbrr[$ind] >= 0;
    
    my @krr;
    my $f0 = f_ans($arr[0], $ind);
    push @jrr, $f0;
    for my $j (1..$#arr) {
        push @krr, f_ans($arr[$j], $ind);
    }
    $boss{join",", ($fbrr[$ind],$fbrr[$ind-1],$fbrr[$ind-2],$fbrr[$ind-3])} = 1;
    push @jrr, sum @krr;
    say $jrr[-1] if $jrr[-1] > 1973;
    # say $jrr[-1];
}

say max @jrr;
}

=pod
e78783@penguin:~$ time perl aoc_day22y.pl < input.txt
1986
2049
2011
2221
1985
2053
2037
2008
2138
^C

real    4m44.871s
user    4m38.239s
sys     0m1.093s
