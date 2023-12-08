use v5.30.0;
use warnings;
use List::Util qw/all/;
my %tree;

my %inst;

open FH, "<", "day08.txt";
while (<FH>) {
  if (/(\w{3}) = \((\w{3}), (\w{3})\)/) {
    $inst{$1} = {
      left => $2, 
      right => $3
    };
  }
}

my $str = "LRRLRRLRRRLRLLRRRLLRRRLRLRRRLRLRRLRRRLRRRLRLRRRLRRRLRRLRRRLLLRLRRRLRRRLRRRLRLRLRRLLRRRLRLLRLRRRLRRLLRLRLRRLRRRLRRLLRLRRRLLRRLRRRLRLRRLLRRRLRRLLRRLRRRLRLRRRLRRLRRRLRRRLRRLRRRLRLRRLRRRLRRRLRRLLRLRRLRRLRRRLRLLLRRRLLRRRLRLRRRLRLRRLRRRLLLRLRRRLRLRRLRRRLRRRLRRLRLRLRRRR";

my @arr = split "", $str;
my @step = (0, 0, 0, 0, 0, 0);
my @val = grep {$_ =~ /A$/} keys %inst;
say join " ", @val;

for my $i (0..$#val) {
  while( $val[$i] !~ /Z$/) {
    if ($arr[$step[$i] % length($str)] eq "L") {
      $val[$i] = $inst{$val[$i]}->{left};
    } else {
      $val[$i] = $inst{$val[$i]}->{right};
    }
    $step[$i]++;
  }
}

say join " ", @step;
