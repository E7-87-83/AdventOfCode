use v5.30.0;
use warnings;

open FH, "<", "day11.txt";

sub inbtw {
  my $p = $_[0];
  my $x = $_[1];
  my $y = $_[2];
  return ($x < $p && $p < $y) || ($x > $p && $p > $y);
}

my @galaxy;
my @empty_rows;
my @empty_cols;
my @map;
while (<FH>) {
  chomp;
  push @map, $_;
}

for my $row_id (0..$#map) {
  my $row = $map[$row_id];
  my $st = index($row, "#");
  push @empty_rows, $row_id if ($st == -1);
  while ($st != -1) {
    push @galaxy, [$row_id, $st];
    $st = index($row, "#", $st+1);
  }
}

my %find_empty_cols;

for my $g (@galaxy) {
  $find_empty_cols{$g->[1]} = 1;
}
for my $col_id (0..length($map[0]) - 1) {
  push @empty_cols, $col_id if !$find_empty_cols{$col_id};
}


say scalar @galaxy;

my $tdist = 0;
for my $p0 (0..$#galaxy-1) {
  for my $p1 ($p0+1..$#galaxy) {
    my $g0 = $galaxy[$p0];
    my $g1 = $galaxy[$p1];
    my $dist = abs($g0->[0]-$g1->[0]) + abs($g0->[1]-$g1->[1]);
    my $d = 0;
    for my $c (@empty_cols) {
      $d++ if inbtw($c, $g0->[1], $g1->[1]);
    }
    for my $r (@empty_rows) {
      $d++ if inbtw($r, $g0->[0], $g1->[0]);
    }
    $tdist += $dist+$d*99;
    # say $p0, " ", $p1, " ", $dist
  }
}

say $tdist;
