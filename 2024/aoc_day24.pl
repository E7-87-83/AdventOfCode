use v5.30;
use warnings;

my %res;
my %v;
my %node;
my %c_node;

while (<>) {
    chomp; 
    if (/^(\w{3}): (\d)$/) {
        $v{$1} = $2;
        $node{$1} = 1; 
        $c_node{$1} = 1; 
    } elsif (/^(\w{3}) (XOR|OR|AND) (\w{3}) -> (\w{3})$/) {
        $res{"$1,$3,$2,$4"} = $4;
        $node{$1} = 1;
        $node{$3} = 1;
        $node{$4} = 1;
    }
}


my %operated;
while (scalar keys %c_node < scalar keys %node) {
    for my $key (keys %res) {
        next if $operated{$key};
        my ($x, $y, $op, $z) = split ",", $key;
        if ($c_node{$x} && $c_node{$y}) {
            $v{$res{$key}} = $v{$x} ^ $v{$y} if $op eq "XOR";
            $v{$res{$key}} = $v{$x} & $v{$y} if $op eq "AND";
            $v{$res{$key}} = $v{$x} | $v{$y} if $op eq "OR";
            $c_node{$res{$key}} = 1;
        }
    }
}

use Data::Printer;
# p %v;

sub bin2dec {
    my $bin = $_[0];
    use bigint;
    my $val = 0;
    my @bs = split "", $bin;
    while (@bs > 0) {
        my $b = shift @bs;
        $val = ($val*2) + $b;
    }
    return $val;
}
# my $bin = join "", map {$v{$_}} sort {$b cmp $a} grep {substr($_,0,1) eq "z"} keys %v;

# say $bin;

my $binx = join "", map {$v{$_}} sort {$b cmp $a} grep {substr($_,0,1) eq "x"} keys %v;
my $biny = join "", map {$v{$_}} sort {$b cmp $a} grep {substr($_,0,1) eq "y"} keys %v;
my $decz = bin2dec($binx)+bin2dec($biny); # 45121458536680
