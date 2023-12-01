use v5.30.0;
use warnings;

my @report = qw/
zlmlk1
vqjvxtc79mvdnktdsxcqc1sevenone
vsskdclbtmjmvrseven6
8jkfncbeight7seven8
six8dbfrsxp
2zpcbjdxcjfone68six
fivetczxxvjrrqfive1sevennvj6one3
/;




use List::Util qw/first sum/; 
my %verb = (
  1 => "one",
  2 => "two",
  3 => "three",
  4 => "four",
  5 => "five",
  6 => "six", 
  7 => "seven",
  8 => "eight",
  9 => "nine",
);
sub get_first_digit {
  my $str = $_[0];
  my $m = 0;
  my $match;
  while (substr($str, $m) !~ /^\d/ && !$match) {
    $match = first { substr($str, $m) =~ /^$verb{$_}/ } (1..9);
    $m++;
  }
  return $match if $match;
  return substr($str, $m, 1) if substr($str, $m) =~ /^\d/;
}
sub get_last_digit {
  my $str = $_[0];
  my $m = (length $str) - 1;
  my $match;
  while (substr($str, $m) !~ /^\d/ && !$match) {
    $match = first { substr($str, $m) =~ /^$verb{$_}/ } (1..9);
    $m--;
  }
  return $match if $match;
  return substr($str, $m, 1) if substr($str, $m) =~ /^\d/;
}
my @new_report = map {get_first_digit($_).get_last_digit($_)} @report;

say sum(@new_report);
