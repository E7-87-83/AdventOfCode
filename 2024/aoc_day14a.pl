use v5.30;
use warnings;
use Time::HiRes qw(usleep nanosleep);

my @map;
my @init_pos;
my @vel;

my $m;
my $n;
my $step;

# variable to change
$m = 7;
$n = 11;
$m = 103;
$n = 101;
$step = 1;

for (1..$m) {
    push @map, [(".") x $n];
}

while (<>) {
    /p=([\-]?\d+),([\-]?\d+) v=([\-]?\d+),([\-]?\d+)/;
    push @init_pos, [$2, $1];
    push @vel, [$4, $3];
}

#use Data::Printer;
#p @init_pos;
#p @vel;

my @final_pos;
my %locat;
for my $i (0..$#init_pos) {
    my $y = $init_pos[$i]->[0];
    my $x = $init_pos[$i]->[1];
    $final_pos[$i] = [
        ($y+  0 *$vel[$i]->[0]) % $m,
        ($x+  0 *$vel[$i]->[1]) % $n
    ];
    $init_pos[$i]->[0] = $final_pos[$i]->[0];
    $init_pos[$i]->[1] = $final_pos[$i]->[1];
    $locat{$i} = [$final_pos[$i]->[0],$final_pos[$i]->[1]];
}

my $cnt = 0;
while($cnt<10_000) {
    $cnt++;
    for my $i (0..$#init_pos) {
        my $y = $init_pos[$i]->[0];
        my $x = $init_pos[$i]->[1];
        $final_pos[$i] = [
            ($y+$step*$vel[$i]->[0]) % $m,
            ($x+$step*$vel[$i]->[1]) % $n
        ];
        $init_pos[$i]->[0] = $final_pos[$i]->[0];
        $init_pos[$i]->[1] = $final_pos[$i]->[1];
        $locat{$i} = [$final_pos[$i]->[0],$final_pos[$i]->[1]];
    }



    my ($first, $second, $third, $fourth);

    for my $i (0..$#init_pos) {
        if ($locat{$i}->[0] != ($m-1)/2 && $locat{$i}->[1] != ($n-1)/2) {
            if ($locat{$i}->[0] < ($m-1)/2 && $locat{$i}->[1] > ($n-1)/2) {
                $first++;
            } elsif ($locat{$i}->[0] > ($m-1)/2 && $locat{$i}->[1] > ($n-1)/2) {
                $second++;
            } elsif ($locat{$i}->[0] > ($m-1)/2 && $locat{$i}->[1] < ($n-1)/2) {
                $third++;
            } else {
                $fourth++;
            }
        }
    }

    if ($cnt % 1 == 0) {
        for my $i (0..$m-1) {
            for my $j (0..$n-1) {
                $map[$i][$j] = '.';
            }
        }

         for my $i (0..$#init_pos) {
            $map[$locat{$i}->[0]][$locat{$i}->[1]] = 'x';
         }
         for my $i (0..$m-1) {
            say $map[$i]->@*;
         }
         say $cnt;
         usleep(140_000);
         say "" for (1..10);
    }
}
