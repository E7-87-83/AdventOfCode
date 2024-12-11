use v5.30;
use warnings;
use List::Util qw/sum/;
use List::MoreUtils qw/arrayify frequency/;
use Storable qw(dclone);

sub transform {
    my $v = $_[0];
    return 1 if $v == 0;
    if ((length $v) % 2 == 0) {
        my $s0 = substr $v, 0, (length $v)/2;
        my $s1 = substr $v, (length $v)/2;
        $s1 =~ s/^0+(?=[0-9])//;
        return [$s0, $s1];
    }
    return $v*2024;
}

$_ = <STDIN>;
chomp;
my @arr = split " ";

my %result = frequency @arr;


for (1..75) {
    my %pre_result = %{dclone(\%result)};
    %result = ();
    for my $v (keys %pre_result) {
        my $q = $pre_result{$v};
        if ((length $v) % 2 == 0) {
            my $s0 = substr $v, 0, (length $v)/2;
            my $s1 = substr $v, (length $v)/2;
            $s1 =~ s/^0+(?=[0-9])//;
            $result{$s0}+=$q;
            $result{$s1}+=$q;
        } elsif ($v == 0) {
            $result{1}+=$q;
        } else {
            $result{$v*2024}+=$q;
        }
    }
}

say sum values %result;

