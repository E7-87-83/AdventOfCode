use v5.30.0;
use warnings;
use List::Util qw/all min max/;

open FH , '<', 'aoc_day2.txt';
my @arr;
while (<FH>) {
    chomp;
    my $line = substr($_, 8);
    my @text_arr = split "; ", $line;
    my @my_arr = map {process($_)} @text_arr;
    push @arr, [@my_arr];
}


sub process {
    my $result = $_[0];
    my $plain = {"G"=>0,"R"=>0,"B"=>0};
    if ($result =~ /(\d+) green/) {
        $plain->{"G"}=$1;
    }
    if ($result =~ /(\d+) red/) {
        $plain->{"R"}=$1;
    }
    if ($result =~ /(\d+) blue/) {
        $plain->{"B"}=$1;
    }
    return $plain;
}

=pod Part I
my $ans = 0;
my $m = 1;
while ($m <= 100) {
    $ans += $m if all {$_->{"R"} <= 12 && $_->{"G"} <= 13 && $_->{"B"} <= 14} $arr[$m-1]->@*;
    $m++;
}

say $ans;
=cut

my $ans = 0;
for my $m (0..99) {
    my $green = max map {$_->{"G"}} $arr[$m]->@*;
    my $red = max map {$_->{"R"}} $arr[$m]->@*;
    my $blue = max map {$_->{"B"}} $arr[$m]->@*;
    $ans += $green*$red*$blue;
}
say $ans;
