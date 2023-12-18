use v5.30.0;
use warnings;
use List::Util qw/sum first/;

sub hash {
    my $cur = 0;
    my $str = $_[0];
    for my $l (0..(length $str)-1) {
        $cur = ($cur + ord(substr($str,$l,1)))*17 % 256;
    }
    return $cur;
}

my $s = "rn=1,cm-,qp=3,cm=2,qp-,pc=4,ot=9,ab=5,pc-,pc=6,ot=7";
my %box;

for my $inst (split ",",$s) {
    my $itype = index($inst,"=") > -1 ? "VAL" : "ROV";
    my $ind = index($inst,"=") > -1 ? index($inst,"=") : index($inst,"-");
    my $str = substr($inst,0,$ind);
    if ($itype eq "VAL") {
        $box{hash($str)} = [] if !defined $box{hash($str)};
        if (scalar $box{hash($str)} == 0) {
            push $box{hash($str)}->@*, {
                label => $str,
                val => substr($inst, -1,1)
            };
            next;
        }
        my $b_ind = first {$box{hash($str)}->[$_]->{label} eq $str} (0..$box{hash($str)}->$#*);
        $box{hash($str)}->[$b_ind]->{val} = substr($inst, -1,1) if defined $b_ind;
        push $box{hash($str)}->@*, {
            label => $str,
            val => substr($inst, -1,1)
        } if !defined $b_ind;
    }
    else {
        next if !defined $box{hash($str)};
        my $b_ind = first {$box{hash($str)}->[$_]->{label} eq $str} (0..$box{hash($str)}->$#*);
        if (defined $b_ind) {
            my @arr = $box{hash($str)}->@*;
            splice @arr, $b_ind, 1;
            $box{hash($str)}->@* = @arr;
        }
    }
}

use Data::Printer;
p %box;
my $ans = 0;
for my $k (0..255) {
    for my $i (0..$box{$k}->$#*) {
        $ans += ($k+1)*($i+1)*($box{$k}->[$i]->{val});
    }
}

say $ans;

