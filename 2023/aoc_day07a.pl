use v5.30.0;
use warnings;

my @s = ("A", "K", "Q", "T", 9, 8, 7, 6, 5, 4, 3, 2, "J");

my %strength;
for (0..12) {
  $strength{$s[$_]} = $_;
}

my %input = qw/
32T3K 765
T55J5 684
KK677 28
KTJJT 220
QQQJA 483
/;


sub type_identify {
  my $x = $_[0];
  my $y = join "", sort {$strength{$a} <=> $strength{$b}} split "", $x;
  my $type;
  if ($x =~ /(\w)\1{4}/) {
    $type = 1;
  } elsif ($y =~ /(\w)\1{3}/) {
    $type = 2;
  } elsif ($y =~ /(\w)\1{2}(\w)\2/ || $y =~ /(\w)\1(\w)\2\2/) {
    $type = 3;
  } elsif ($y =~ /(\w)\1\1/) {
    $type = 4;
  } elsif ($y =~ /(\w)\1(\w)(\w)\3/ 
              || $y =~ /(\w)\1(\w)\2(\w)/ 
              || $y =~ /(\w)(\w)\2(\w)\3/) {
    $type = 5;
  } elsif ($y =~ /(\w)\1/) {
    $type = 6;
  } else {
    $type = 7;
  }

  if ($type == 2 && $y =~ /J/) {
    $type = 1;
  }
  elsif ($type == 3 && $y =~ /J/) {
    $type = 1;
  }
  elsif ($type == 4 && $y =~ /J/) {
    $type = 2;
  }
  elsif ($type == 5 && $y =~ /JJ/) {
    $type = 2;
  }
  elsif ($type == 5 && $y =~ /J/) {
    $type = 3;
  }
  elsif ($type == 6 && $y =~ /JJ/) {
    $type = 4;
  } 
  elsif ($type == 6 && $y =~ /J/) {
    $type = 4;
  }
  elsif ($type == 7 && $y =~ /J/) {
    $type = 6;
  }
  return $type;
}


my @brr = reverse sort {(type_identify($a) <=> type_identify($b)) || 
                  $strength{substr($a,0,1)} <=> $strength{substr($b,0,1)} ||
                  $strength{substr($a,1,1)} <=> $strength{substr($b,1,1)} ||
                  $strength{substr($a,2,1)} <=> $strength{substr($b,2,1)} ||
                  $strength{substr($a,3,1)} <=> $strength{substr($b,3,1)} ||
                  $strength{substr($a,4,1)} <=> $strength{substr($b,4,1)} 
                  } (keys %input);

say join " ", @brr;


my $ans = 0;
for my $i (0..$#brr) {
  say $i+1, " ", $brr[$i], type_identify($brr[$i]);
  $ans += ($i+1)*$input{$brr[$i]};
}
say $ans;
