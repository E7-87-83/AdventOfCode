use v5.30.0;
use warnings;
use List::Util qw/all/;

open FH,"<", "input.txt";

my $ans = 0;
my @arr;
while (<FH>) {
  chomp;
  push @arr, $_ if !/^$/;
  if (/^$/) {
    my $t_ans = sch(@arr);
    $ans += substr($t_ans,1) if ($t_ans =~ /^c/);
    $ans += 100*substr($t_ans,1) if ($t_ans =~ /^r/);
    @arr = ();
  }
}
say "ANSWER: $ans";

sub reflect {
  my @arr = @_;
  my $num_col = length($arr[0]);
  my $num_row = scalar @arr;
  my @twodim_arr = map {[split "", $_]} @arr;
  my @new_arr;
  for my $i (0..$num_col-1) {
    push @new_arr, join "", map {$twodim_arr[$_][$i]} 0..$num_row-1;
  }
  my $temp_ans = find_row(@new_arr);
  substr($temp_ans,0,1,"c");
  return $temp_ans;
}


sub ch {
  my $ans = find_row(@_);
  return reflect(@_) if !$ans;
  return $ans;
}

sub find_row {
  my $ans;
  my @arr = @_;
  my $num_col = length($arr[0]);
  my $num_row = scalar @arr;
  say $num_col, " ", $num_row;
  for my $r (0..int($num_row/2)-1) {
    $ans = "r@{[$r+1]}" if all {$arr[$r+$_+1] eq $arr[$r-$_]} (0..$r);
    #say "here", $ans, " ",$r+1 if defined $ans;
    return $ans if defined $ans;
  }
  for my $r (int($num_row/2)..$num_row-2) {
    $ans = "r@{[$r+1]}" if all {$arr[$r+$_+1] eq $arr[$r-$_]} (0..$num_row-$r-2);
    #say $ans, " ",$num_row-$r-1  if defined $ans;
    return $ans if defined $ans;
  }
  return 0;
}

sub sch {
  my $ans = s_find_row(@_);
  return s_reflect(@_) if !$ans;
  return $ans;
}

sub s_reflect {
  my @arr = @_;
  my $num_col = length($arr[0]);
  my $num_row = scalar @arr;
  my @twodim_arr = map {[split "", $_]} @arr;
  my @new_arr;
  for my $i (0..$num_col-1) {
    push @new_arr, join "", map {$twodim_arr[$_][$i]} 0..$num_row-1;
  }
  my $temp_ans = s_find_row(@new_arr);
  substr($temp_ans,0,1,"c");
  return $temp_ans;
}

sub s_find_row {
  my $ans;
  my @arr = @_;
  my $num_col = length($arr[0]);
  my $num_row = scalar @arr;
  say $num_col, " ", $num_row;
  RR: for my $r (0..int($num_row/2)-1) {
    my $ind=0;
    my @rind = ();
    for my $i (0..$r) {
      if ($arr[$r+$i+1] eq $arr[$r-$i]) {
        $ind++
      } else {
        push @rind, $i;
      }
      next RR if scalar @rind > 1;
    }
    if (scalar @rind == 1 && cmp_diff($arr[$r+$rind[0]+1], $arr[$r-$rind[0]]) == 1) {
      $ans = "r@{[$r+1]}";
    }
    return $ans if defined $ans;
  }
  SR: for my $r (int($num_row/2)..$num_row-2) {
    my $ind=0;
    my @rind = ();
    for my $i (0..$num_row-$r-2) {
      if ($arr[$r+$i+1] eq $arr[$r-$i]) {
        $ind++
      } else {
        push @rind, $i;
      }
      next SR if scalar @rind > 1;
    }
    if (scalar @rind == 1 && cmp_diff($arr[$r+$rind[0]+1], $arr[$r-$rind[0]]) == 1) {
      $ans = "r@{[$r+1]}";
    }
    return $ans if defined $ans;
  }
  return 0;
}

sub cmp_diff {
  my $str = $_[0];
  my $nstr = $_[1];
  my @arr = split "", $str;
  my @narr = split "", $nstr;
  my $len = grep {$arr[$_] eq $narr[$_]} (0..$#arr);
  return (scalar @arr - $len);
}







use Test::More tests=>6;
ok ch(reverse qw{x.x.x.x..
x.x.x.xx.
x.x.x.xx.
x.x.x.x..
...x.....
x..x.xx..
....x...x
xxxx....x
xxxxx....
.xxx.x.xx
xxxx...xx
.x.x...x.
x....x.x.}) eq "r11";

ok ch(qw/x.x.x.x..
x.x.x.xx.
x.x.x.xx.
x.x.x.x..
...x.....
x..x.xx..
....x...x
xxxx....x
xxxxx....
.xxx.x.xx
xxxx...xx
.x.x...x.
x....x.x./) eq "r2";

ok ch(qw/x.xx..xx.
..x.xx.x.
xx......x
xx......x
..x.xx.x.
..xx..xx.
x.x.xx.x./) eq "c5";

ok ch(qw/x...xx..x
x....x..x
..xx..xxx
xxxxx.xx.
xxxxx.xx.
..xx..xxx
x....x..x/) eq "r4";

ok sch(qw/x.xx..xx.
..x.xx.x.
xx......x
xx......x
..x.xx.x.
..xx..xx.
x.x.xx.x./) eq "r3";

ok sch(qw/x...xx..x
x....x..x
..xx..xxx
xxxxx.xx.
xxxxx.xx.
..xx..xxx
x....x..x/) eq "r1";

