use v5.30;
use warnings;

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

my $sum;
# for ("029", 980, 179, 456, 379) {
for (140, 143, 349, 582, 964) {
    $sum += $_*catch($_) 
}
say $sum;

sub catch {
    my $str = $_[0]."A";
    my @ar = ("A", split "", $str);
    my $lv1 = "";
    for my $i (0..$#ar-1) {
        my @temp_arr = grep {defined} numeric_from_to($ar[$i],$ar[$i+1])->@*;
        my $temp = @temp_arr == 1 ? $temp_arr[0] : substr($temp_arr[0],0,1) eq "<" ? $temp_arr[0] : substr($temp_arr[1],0,1) eq "v" ? $temp_arr[1] : $temp_arr[0];
        $lv1 .= $temp;
    }

    my @br = ("A", split "", $lv1);
    my $lv2 = "";
    for my $i (0..$#br-1) {
        my @temp_brr = grep {defined} direct_from_to($br[$i],$br[$i+1])->@*;
        my $temp = @temp_brr == 1 ? $temp_brr[0] : substr($temp_brr[0],0,1) eq "<" ? $temp_brr[0] : substr($temp_brr[1],0,1) eq "v" ? $temp_brr[1] : $temp_brr[0];
        $lv2 .= $temp;
    }

    my @cr = ("A", split "", $lv2);
    my $lv3 = "";
    for my $i (0..$#cr-1) {
        my @temp_crr = grep {defined} direct_from_to($cr[$i],$cr[$i+1])->@*;
        my $temp = @temp_crr == 1 ? $temp_crr[0] : substr($temp_crr[0],0,1) eq "<" ? $temp_crr[0] : substr($temp_crr[1],0,1) eq "v" ? $temp_crr[1] : $temp_crr[0];
        $lv3 .= $temp;
    }

    say $str;
    say $lv1;
    say $lv2;
    say $lv3;
    say length $lv1;
    say length $lv2;
    say length $lv3;
    say "";
    return length $lv3;
}
