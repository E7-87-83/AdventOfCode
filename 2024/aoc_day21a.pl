use v5.30;
use warnings;
use Storable qw/dclone/;
my @num_key = ([7,8,9],[4,5,6],[1,2,3],[undef,0,"A"]);
my %num_ref;
for my $i (0..3) {
    for my $j (0..2) {
        $num_ref{$num_key[$i][$j]} = [$i,$j] if defined $num_key[$i][$j];
    }
}


my @direct_key = ([undef,'^','A'],['<','v','>']);
my %direct_ref;
for my $i (0..1) {
    for my $j (0..2) {
        $direct_ref{$direct_key[$i][$j]} = [$i,$j] if defined $direct_key[$i][$j];
    }
}

sub numeric_from_to {
    my $p = $_[0];
    my $q = $_[1];
    my $rp = $num_ref{$p};
    my $rq = $num_ref{$q};
    my $lr_then_ud;
    my $ud_then_lr;
    my $d1 = $rp->[1]-$rq->[1] > 0 ? '<' : '>';
    my $d2 = $rp->[0]-$rq->[0] > 0 ? '^' : 'v';
    $lr_then_ud = ($d1 x abs($rp->[1]-$rq->[1])) . ($d2 x abs($rp->[0]-$rq->[0])) . "A";
    $ud_then_lr = ($d2 x abs($rp->[0]-$rq->[0])) . ($d1 x abs($rp->[1]-$rq->[1])) . "A";
    if ($rp->[0] == 3 && $rq->[1] == 0) {
        $lr_then_ud = undef;
    }
    if ($rq->[0] == 3 && $rp->[1] == 0) {
        $ud_then_lr = undef;
    }
    return [$lr_then_ud, $ud_then_lr];
}

sub direct_from_to {
    my $p = $_[0];
    my $q = $_[1];
    my $rp = $direct_ref{$p};
    my $rq = $direct_ref{$q};
    my $lr_then_ud;
    my $ud_then_lr;
    my $d1 = $rp->[1]-$rq->[1] > 0 ? '<' : '>';
    my $d2 = $rp->[0]-$rq->[0] > 0 ? '^' : 'v';
    $lr_then_ud = ($d1 x abs($rp->[1]-$rq->[1])) . ($d2 x abs($rp->[0]-$rq->[0])) . "A" ;
    $ud_then_lr = ($d2 x abs($rp->[0]-$rq->[0])) . ($d1 x abs($rp->[1]-$rq->[1])) . "A" ;
    if ($rq->[0] == 0 && $rp->[1] == 0) {
        $ud_then_lr = undef;
    }
    if ($rp->[0] == 0 && $rq->[1] == 0) {
        $lr_then_ud = undef;
    }
    return [$lr_then_ud, $ud_then_lr];
}

my %dir;
for my $x ('^','>','<','v','A') {
    for my $y ('^','>','<','v','A') {
        my @temp_brr = grep {defined} direct_from_to($x,$y)->@*;
        my $temp = @temp_brr == 1 ? $temp_brr[0] : substr($temp_brr[0],0,1) eq "<" ? $temp_brr[0] : substr($temp_brr[1],0,1) eq "v" ? $temp_brr[1] : $temp_brr[1];
        $dir{"$x$y"} = $temp;
        # $dir{"$x$y"} = substr($temp,0,(length $temp) - 1);
    }
}

my $sum;
# for ("029", 980, 179, 456, 379) {
for (140, 143, 349, 582, 964) {
    use bigint;
    my $p = $_*catch($_);
    say $p;
    $sum += $p;
}
say $sum;


sub catch {
    my $str = $_[0]."A";
    my @ar = ("A", split "", $str);
    my $lv1 = "";
    for my $i (0..$#ar-1) {
        my @temp_arr = grep {defined} numeric_from_to($ar[$i],$ar[$i+1])->@*;
        my $temp = @temp_arr == 1 ? $temp_arr[0] : substr($temp_arr[0],0,1) eq "<" ? $temp_arr[0] : substr($temp_arr[1],0,1) eq "v" ? $temp_arr[1] : $temp_arr[1];
        $lv1 .= $temp;
    }

    my $pre_lv = $lv1;

    say 1, " ", length $pre_lv;
    my %robot_d;
    $robot_d{'A'.substr($pre_lv,0,1)}++;
    for my $i (0..(length $pre_lv) - 2) {
        $robot_d{substr($pre_lv,$i,2)}++;
    }

    for (1..25) {
        my $leng;
        my %old_robot_d = (dclone \%robot_d)->%*;
        %robot_d = ();
        for my $k (keys %old_robot_d) {
            $robot_d{"A".substr($dir{$k},0,1)} += $old_robot_d{$k};
            for my $i (0..(length $dir{$k})-2) {
                $robot_d{substr($dir{$k},$i,2)} += $old_robot_d{$k};
            }
        }
        for my $k (keys %robot_d) {
            $leng += $robot_d{$k};
        }
        say $_," ",$leng;
    }
    
    my $lng;
    for my $k (keys %robot_d) {
        $lng += $robot_d{$k};
    }
    return $lng;
}

