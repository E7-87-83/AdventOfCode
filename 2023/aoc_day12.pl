use v5.30.0;
use warnings;
use List::Util qw/sum/;
my @arr;
my $ans1 = 0;

open FH,"<","input.txt";

while (<FH>) {
  chomp;
  my $a = index($_, " ");
  my $str = substr($_, 0, $a);
  my @result = split ",", substr($_, $a+1);
  $ans1 += ch($str, [@result]);
}
say $ans1;

sub ch {
  my $ans = 0;
  my $str = $_[0];
  my @result = $_[1]->@*;
  my @astr = split "", $str;
  my $hmark  = grep {$astr[$_] eq "#"} 0..$#astr;
  my @qmarks = grep {$astr[$_] eq "?"} 0..$#astr;
  my $qmark = @qmarks;
  for my $dec (0..2**$qmark-1) {
    my $bin = substr(unpack("B*", pack("N", $dec)), -$qmark);
    die "WARNING "if length($bin) != $qmark;
    my @binarr = split "", $bin;
    next if $hmark+sum(@binarr) != sum @result;
    my @nastr;
    my $i = 0;
    for my $k (0..$#astr) {
      push @nastr, "." if $astr[$k] eq ".";
      push @nastr, "#" if $astr[$k] eq "#";
      if ($astr[$k] eq "?") {
        push @nastr, "#" if $binarr[$i] eq "1";
        push @nastr, "." if $binarr[$i] eq "0";
        $i++;
      }
    }
    my $nstr = join "", @nastr;
    $ans++ if check($nstr, [@result]);
  }
  return $ans;
}

sub check {
  my $str = $_[0];
  my @result = $_[1]->@*;
  my @s;
  while ($str =~ /(\#+)/g) {
    push @s, length $1;
  }
  return 1 if (join ",",@s) eq (join ",",@result);
  return 0;
}


use Test::More tests=>7;
ok check("#.#.###", [1,1,3])==1;
ok ch("???.###", [1,1,3])==1;
ok ch(".??..??...?##.", [1,1,3])==4;
ok ch("?#?#?#?#?#?#?#?", [1,3,1,6])==1;
ok ch("????.#...#...", [4,1,1])==1;
ok ch("????.######..#####.", [1,6,5])==4;
ok ch("?###????????", [3,2,1])==10;
