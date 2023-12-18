use v5.30.0;
use warnings;
use List::Util qw/sum/;

my @old_steps;
my @steps;

open FH,"<","input18.txt";
while (<FH>) {
    chomp;
    push @old_steps, $_;
}

for my $s (@old_steps) {
    my $dist = hex substr($s,0,5);
    my $i = substr($s,-1,1);
    my $inst;
    $inst = "R" if $i == 0;
    $inst = "D" if $i == 1;
    $inst = "L" if $i == 2;
    $inst = "U" if $i == 3;
    push @steps, "$inst $dist";
}


my @pos = ([0,0]);

for my $s (@steps) {
    my $inst = substr($s,0,1);
    my $dist = substr($s,2);
    my $y = $pos[-1]->[0];
    my $x = $pos[-1]->[1];
    $x += $dist if $inst eq "R";
    $y += $dist if $inst eq "D";
    $x -= $dist if $inst eq "L";
    $y -= $dist if $inst eq "U";
    push @pos, [$y, $x];
}

sub shoelace {
    my $ans = 0;
    my @p = @_;
    for my $i (0..$#p) {
        $ans += 0.5*($p[$i]->[1]*$p[$i-1]->[0]-$p[$i-1]->[1]*$p[$i]->[0]);
    }
    $ans = abs $ans;
}

sub perimeter {
    my @steps = @_;
    return sum map {substr($_,2)} @steps;

}

say shoelace(@pos) + perimeter(@steps)/2 + 1;
