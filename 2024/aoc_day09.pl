use v5.30;
use warnings;
use Data::Printer;
my @arr;
$_ = <>;
#$_ = $ARGV[0];
chomp;
my @format = split "";

=pod non-BF way
for my $i (0..$#format) {
    if ($i % 2 == 0) {
        push @arr, [$i/2, $format[$i]];
    } else {
        push @arr, [".", $format[$i] ];
    }
}
=cut

my $nonemptyspaces;

for my $i (0..$#format) {
    if ($i % 2 == 0) {
        push @arr, ($i/2) x $format[$i];
        $nonemptyspaces += $format[$i];
    } else {
        push @arr, (".") x $format[$i];
    }
}

my $left = 0;
my $right = $#arr;

do {
    do {
        $left++;
    } while ($left <= $#arr && $arr[$left] ne ".");
    $arr[$left] = $arr[$right];
    # $arr[$right] = ".";
    do {
        pop @arr;
        $right--;
    } while ($arr[$right] eq ".");
} while ($left < $right-1);

#say join "", @arr;
#say "0099811188827773336446555566";
say $#arr;
say $nonemptyspaces;

my $sum;
for my $i (0..$#arr) {
    $sum += $arr[$i]*$i;
}
say $sum;
