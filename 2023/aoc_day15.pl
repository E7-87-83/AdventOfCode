use v5.30.0;
use warnings;
use List::Util qw/sum/;

sub hash {
    my $cur = 0;
    my $str = $_[0];
    for my $l (0..(length $str)-1) {
        $cur = ($cur + ord(substr($str,$l,1)))*17 % 256;
    }
    return $cur;
}

my $s = "rn=1,cm-,qp=3,cm=2,qp-,pc=4,ot=9,ab=5,pc-,pc=6,ot=7";
say sum map {hash $_} split ",",$s;
