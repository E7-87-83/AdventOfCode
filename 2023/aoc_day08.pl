use v5.30.0;
use warnings;

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
my $step = 0;
my $val = "AAA";

while ($val ne "ZZZ") {
  if ($arr[$step % length($str)] eq "L") {
    $val = $inst{$val}->{left};
  } else {
    $val = $inst{$val}->{right};
  }
  $step++;
}

say $step;
