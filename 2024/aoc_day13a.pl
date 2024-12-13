use v5.30;
use warnings;
use Data::Printer;
use Math::Prime::Util qw/gcd/;
use bigint;

sub extended_gcd {
    use integer;
    my $s = 0; my $old_s = 1;
    my $r = $_[1]; my $old_r = $_[0];
    while ($r != 0) {
        my $q = $old_r/$r;
        ($old_r, $r) = ($r, $old_r - $q*$r);
        ($old_s, $s) = ($s, $old_s - $q*$s);
        say "$old_r $r $old_s $s";
    }
    my $bezout_t = ($old_r - $old_s * $_[0]) / $_[1];
    return [$old_s, $bezout_t];
}


my $ind;
my @cond;
my @t_arr;
while (<>) {
    chomp;
    if (/Button A: X\+(\d+), Y\+(\d+)/) {
        @t_arr = ();
        push @t_arr, $1, $2;
    }
    if (/Button B: X\+(\d+), Y\+(\d+)/) {
        push @t_arr, $1, $2;
    }
    if (/Prize: X=(\d+), Y=(\d+)/) {
        push @t_arr, 10000000000000+$1, 10000000000000+$2;
        # push @t_arr, $1, $2;
        push @cond, [@t_arr];
    }
}

my $sum;

for my $row (@cond) {
    use integer;
    my @arr = $row->@*;
    my $g0 = gcd($arr[0], $arr[2]);
    my $g1 = gcd($arr[1], $arr[3]);
    next
        if $arr[4] % $g0 != 0
                || 
           $arr[5] % $g1 != 0; 
    my @i0 = extended_gcd($arr[0], $arr[2])->@*;
    # my @i1 = extended_gcd($arr[1], $arr[3])->@*;
    @i0 = map {-1*$_} @i0 if $i0[0]*$arr[0]+$arr[2]*$i0[1] <= 0;
    say join " ", @i0;
    @i0 = map {$_*($arr[4]/$g0)} @i0;
    say join " ", @i0;
    say "OK ", $arr[0]*$i0[0] + $arr[2]*$i0[1];
    # @i1 = map {$_*($arr[5]/$g1)} @i1;
    if ($i0[0] < 0) {
        my $cnst = 1-$i0[0]/($arr[2]/$g0);
        $i0[0] += $cnst * ($arr[2]/$g0);
        $i0[1] -= $cnst * ($arr[0]/$g0);
    }
    say join " ", @i0;
    if ($i0[1] < 0) {
        my $cnst = 1-$i0[1]/($arr[0]/$g0);
        $i0[0] -= $cnst * ($arr[2]/$g0);
        $i0[1] += $cnst * ($arr[0]/$g0);
    }
    say join " ", @i0;
    my $subtract = $arr[4]*$arr[3] - $arr[5]*$arr[2];
    my $subt = $arr[0]*$arr[3] - $arr[2]*$arr[1];
    say $subtract;
    say $subt;
    my $a = $subtract / $subt; 
    next if $subtract % $subt != 0;
    next if ($a-$i0[0]) % ($arr[2]/$g0) != 0;
    my $b = $i0[1] - (($a - $i0[0])/($arr[2]/$g0))*($arr[0]/$g0) ;
    say $a, " ",$b; 
=pod
    say $x, " ", $y;
     $arr[1]*$x + $arr[3]*$y > $arr[5];
    
    while ($x >= 0 && $y >= 0) {
        if ($arr[1]*$x + $arr[3]*$y < $arr[5] && $arr[1] > $arr[3]) {
            last;
        }
        if ($arr[1]*$x + $arr[3]*$y > $arr[5] && $arr[1] < $arr[3]) {
            last;
        }
        if ($arr[1]*$x + $arr[3]*$y == $arr[5]) {
            my $t_cost = 3*$x + $y;
            $cost = $t_cost < $cost ? $t_cost : $cost;
        }
        $x -= $arr[2]/$g0;
        $y += $arr[0]/$g0;
        say "A ", $x, " ", $y;
    }
    ($x, $y) = ($i0[0], $i0[1]);
    while ($x >= 0 && $y >= 0) {
        if ($arr[1]*$x + $arr[3]*$y < $arr[5] && $arr[1] < $arr[3]) {
            last;
        }
        if ($arr[1]*$x + $arr[3]*$y > $arr[5] && $arr[1] > $arr[3]) {
            last;
        }
        if ($arr[1]*$x + $arr[3]*$y == $arr[5]) {
            my $t_cost = 3*$x + $y;
            $cost = $t_cost < $cost ? $t_cost : $cost;
            last;
        }
        $x += $arr[2]/$g0;
        $y -= $arr[0]/$g0;
        say "B ", $x, " ", $y;
    }
=cut
    my $cost = $a*3+$b;
    say $cost;
    $sum += $cost;
}
say $sum;
=pod
    while ($i1[0] < 0) {
        $i1[0] += $arr[3]/$g0;
        $i1[1] -= $arr[1]/$g0;
    }
    while ($i1[1] < 0) {
        $i1[0] -= $arr[3]/$g0;
        $i1[1] += $arr[1]/$g0;
    }
=cut

    #       if ($arr[0]*$i+$arr[2]*$j == $arr[4] && 
    #            $arr[1]*$i+$arr[3]*$j == $arr[5]) {
    #            my $t_cost = 3*$i + $j;
    #            $cost = $t_cost < $cost ? $t_cost : $cost;

say $sum;
