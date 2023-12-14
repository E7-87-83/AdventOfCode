use v5.30.0;
use warnings;
use List::Util qw/min/;

open FH, "<", "input.txt";
my @arr;
while (<FH>) {
  next if /^$/;
  chomp;
  push @arr, $_;
}

say ch(@arr);


sub ch {
  my @inp = @_;
  my @dim = map { [split "", $_] } reverse @inp;
  my %rock_pos;
  for my $c (0..(length $inp[0])-1) {
    for my $r (0..$#inp) {
      if ($dim[$r][$c] eq "O") {
        my $rock = min grep {$_ > $r && $dim[$_][$c] eq "#"} 0..$#inp;
        $rock = scalar @inp if !defined $rock;
        $rock_pos{"$rock,$c"}++;
      }
    }
  }
  my $ans = 0;
  for my $k (keys %rock_pos) {
    my $rock = 1+(split ",", $k)[0];
    $ans += ($rock - 1 + $rock - $rock_pos{$k})*$rock_pos{$k}/2
  }
  return $ans;
}



use Test::More tests=>3;
ok ch(
"#",
"O",
"O") == 3;

ok ch(
"#",
".",
"O",
"O") == 5;

ok ch(
"O....#....",
"O.OO#....#",
".....##...",
"OO.#O....O",
".O.....O#.",
"O.#..O.#.#",
"..O..#O..O",
".......O..",
"#....###..",
"#OO..#....",)
== 136;

