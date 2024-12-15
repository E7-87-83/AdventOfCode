use v5.30;
use warnings;

my @map;
my @inst;


while (<>) {
    chomp;
    if (/^\#/) {
        s/#/##/g;
        s/O/\[\]/g;
        s/\./\.\./g;
        s/@/@\./g;
        push @map, [split ""];
    } elsif (/^$/) {
    } else {
        push @inst, split "";
    }
}

my $m = $#map+1;
my $n = $map[0]->$#*+1;

my %dir = (
    '^' => [-1,0], 
    'v' => [1,0],
    '>' => [0,1],
    '<' => [0,-1],
);

my $robot_loc;
LOOP: for my $i (0..$m-1) {
    for my $j (0..$n-1) { 
        if ($map[$i][$j] eq '@') {
            $robot_loc = [$i, $j];
            last LOOP;
        }
    }
}

for my $w (@inst) {
    say $w;
    my $ny = $robot_loc->[0]+$dir{$w}->[0];
    my $nx = $robot_loc->[1]+$dir{$w}->[1];
    if ($map[$ny][$nx] eq '.') {
        $map[$robot_loc->[0]][$robot_loc->[1]] = '.';
        $robot_loc->[0] = $ny;
        $robot_loc->[1] = $nx;
    } elsif ($map[$ny][$nx] eq '#') {
    } elsif ($w =~ /\<|\>/ && $map[$ny][$nx] =~ /\]|\[/) {
        my $ty = $ny;
        my $tx = $nx;
        my @loc;
        push @loc, $tx;
        while ($map[$ty][$tx] =~ /\]|\[/) {
            $tx += $dir{$w}->[1];
            push @loc, $tx;
        }
        if ($map[$ty][$tx] eq '#') {
        } elsif ($map[$ty][$tx] eq '.') {
            push @loc, $tx;
            $map[$robot_loc->[0]][$robot_loc->[1]] = '.';
            $robot_loc->[0] = $ny;
            $robot_loc->[1] = $nx;
            for my $j (reverse 1..$#loc) {
                $map[$ty][$loc[$j]] = $map[$ty][$loc[$j-1]];
            }
            $map[$ny][$nx] = '.';
        }
    } elsif ($w =~ /\^|v/ && $map[$ny][$nx] =~ /\]|\[/) {
        my $d = $dir{$w}->[0];
        my %boxes;
        my @loc;
        $boxes{$ny} = $map[$ny][$nx] eq ']' ? [[$nx-1, $nx]] : [[$nx, $nx+1]];
        my $ty = $ny;
        my $move_flag = 1;
        do {
            my %temp_boxes = ();
            for my $box_coord ($boxes{$ty}->@*) {
                my $i0 = $box_coord->[0];
                my $i1 = $box_coord->[1];
                if ($map[$ty+$d][$i0] eq '[') {
                    $boxes{$ty+$d} = [] if !defined $boxes{$ty+$d};
                    push $boxes{$ty+$d}->@*, [$i0, $i1] if !defined $temp_boxes{"$i0,$i1"};
                    $temp_boxes{"$i0,$i1"} = 1;
                } else {
                    if ($map[$ty+$d][$i1] eq '[') {
                        $boxes{$ty+$d} = [] if !defined $boxes{$ty+$d};
                        push $boxes{$ty+$d}->@*, [$i1, $i1+1] if !defined $temp_boxes{join",",$i1,$i1+1};
                        $temp_boxes{join",",$i1,$i1+1} = 1;
                    }
                    if ($map[$ty+$d][$i0] eq ']') {
                        $boxes{$ty+$d} = [] if !defined $boxes{$ty+$d};
                        push $boxes{$ty+$d}->@*, [$i0-1, $i0] if !defined $temp_boxes{join",",$i0-1,$i0};
                        $temp_boxes{join",",$i0-1,$i0} = 1;
                    }
                }
                if ($map[$ty+$d][$i0] eq '#' || $map[$ty+$d][$i1] eq '#') {
                    undef $boxes{$ty+$d};
                    $move_flag = 0;
                    last;
                }
            }
            push @loc, $ty;
            $ty += $d;
        } while (defined $boxes{$ty});
        for my $box_coord ($boxes{$ty}->@*) {
            my $i0 = $box_coord->[0];
            my $i1 = $box_coord->[1];
            unless ($map[$ty+$d][$i0] eq '.' && $map[$ty+$d][$i1] eq '.') {
                $move_flag = 0;
                last;
            }
        }
        my $temp_sum;
        for my $j (reverse 0..$#loc) {
            say ($boxes{$loc[$j]}->$#* + 1);
            $temp_sum += $boxes{$loc[$j]}->$#* + 1;
        }
        say $temp_sum;
        if ($move_flag) {
            for my $j (reverse 0..$#loc) {
                for my $box_coord ($boxes{$loc[$j]}->@*) {
                    my $i0 = $box_coord->[0];
                    my $i1 = $box_coord->[1];
                    die if $map[$loc[$j]+$d][$i0] ne "." || $map[$loc[$j]+$d][$i1] ne ".";
                    $map[$loc[$j]+$d][$i0] = '[';
                    $map[$loc[$j]+$d][$i1] = ']';
                    $map[$loc[$j]][$i0] = '.';
                    $map[$loc[$j]][$i1] = '.';
                }
            }
            say "moveable";
            $map[$ny][$nx] = '.';
            $robot_loc->[0] = $ny;
            $robot_loc->[1] = $nx;
        }
    }
    # print_screen();
}

my $sum;
for my $i (0..$m-1) {
    for my $j (0..$n-1) {
        $sum += 100*$i+$j if $map[$i][$j] eq '[';
    }
}

say $sum;



sub print_screen {
    for my $i (0..$m-1) {
        say join "", map {$robot_loc->[0]==$i && $robot_loc->[1]==$_ ? "@" : $map[$i][$_]} 0..$map[$i]->$#*;
    }
    say "";
}
