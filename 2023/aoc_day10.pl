use v5.30.0;
use warnings;
use experimental "switch";
my %tr;

my @bd;

@bd = 
('..F7.',
 '.FJ|.',
 'SJ.L7',
 '|F--J',
 'LJ...');

@bd =
('.....',
 '.S-7.',
 '.|.|.',
 '.|.|.',
 '.L-J.',
 '.....');

@bd =
('....',
 '.S7.',
 '.||.',
 '.||.',
 '.LJ.',
 '....');

@bd =
('......',
 '.F--7.',
 '.L--S.',
 '......');

@bd =
('......',
 '.S--7.',
 '.L--J.',
 '......');

@bd = (
    'S7',
    '.|',
    '.E'
);
=pod
@bd = (
    'FS',
    '|.',
    'E.'
);
@bd = (
    '.S',
    '.|',
    'EJ'
);
@bd =
('.....',
 '.S-7.',
 '.|.|.',
 '.L-J.',
 '.....');
@bd = ('S-E');
@bd = ('S--E');
@bd = ('S--7',
       '...E');
@bd = (
    'F-S',
    '|..',
    'L-E'
);
@bd = (
    'S..',
    '|..',
    '|..',
    'L-E'
);

@bd = (
    'F-7',
    'S-J',
    '...'
);
=cut

@bd = ();
open FH, "<", "day10.txt";
while (<FH>) {
    chomp;
    push @bd, $_;
}



@bd = map {[split "", $_]} @bd;

my ($j, $i);
my ($Sj, $Si);
my $nxt;
FIND: for my $y (0..$#bd) {
    for my $x (0..$bd[0]->$#*) {
        if ($bd[$y][$x] eq "S") {
            $Sj = $y;
            $Si = $x; 
            last FIND;
        }
    }
}

($j, $i) = ($Sj, $Si);
my $r = 2;
$tr{"$j,$i"} = 1;
$nxt = step();
$tr{"$j,$i"} = 1;
move($nxt);
$tr{"$j,$i"} = 2;
say "$r cur $j $i: ",$bd[$j][$i];
my $loop = 0;
while (defined($bd[$j][$i]) && "S" ne $bd[$j][$i] && "E" ne $bd[$j][$i] && $loop < 1000000 && defined($nxt)) {
    $tr{"$Sj,$Si"} = 0 if $loop == 2;

    say "$r cur $j $i: ",$bd[$j][$i];
    $nxt = step();
    say "nxt: $nxt";
    # move($nxt);
    $r++;
    $tr{"$j,$i"} = $r;

    $loop++;

    say "";

}
say $r;
say "warning" if !defined $bd[$j][$i] || $loop >= 20 || !defined $nxt;
say $j, " ", $i;

sub move {
    say "($j $i)";
    $tr{"$j,$i"} = $r;
    my $nxt = $_[0];
    if ($nxt) {
    if ($nxt eq "E") {
        $i = $i+1;
    } elsif ($nxt eq "W") {
        $i = $i-1;
    } elsif ($nxt eq "S") {
        $j = $j+1;
    } elsif ($nxt eq "N") {
        $j = $j-1;
    } else {
        say "ERRRRRROR";
        return;
    }
    } else {
        say "NULL ERRRRRROR";
    }
    say "($j $i)";
}
sub step {
    my $nxt_dir = undef;
    my $cur = $bd[$j][$i];
    say "step $j $i $cur";
    given($cur) {
        when (/J/)  {
            if ($tr{"@{[$j-1]},@{[$i]}"} && 
                !$tr{"@{[$j]},@{[$i-1]}"}) {
                $i = $i-1;
                $nxt_dir = "W";
            }
            elsif ($tr{"@{[$j]},@{[$i-1]}"} && 
                !$tr{"@{[$j-1]},@{[$i]}"}) {
                $j = $j-1;
                $nxt_dir = "N";
            } 
            else {
                say "ERRORJ";
            }
        }
        when (/7/)  {
            if ($tr{"@{[$j+1]},@{[$i]}"} && 
                !$tr{"@{[$j]},@{[$i-1]}"}) {
                $i = $i-1;
                $nxt_dir = "W";
            }
            elsif ($tr{"@{[$j]},@{[$i-1]}"} && 
                !$tr{"@{[$j+1]},@{[$i]}"}) {
                $j = $j+1;
                $nxt_dir = "S";
            }
            else {
                say "ERROR7";
            }
        }
        when (/F/)  {
            if ($tr{"@{[$j+1]},@{[$i]}"} && 
                !$tr{"@{[$j]},@{[$i+1]}"}) {
                $i = $i+1;
                $nxt_dir = "E";
            }
            elsif ($tr{"@{[$j]},@{[$i+1]}"} && 
                !$tr{"@{[$j+1]},@{[$i]}"}) {
                $j = $j+1;
                $nxt_dir = "S";
            }
            else {
                say "ERRORF";
            }
        }
        when (/L/)  {
            if ($tr{"@{[$j-1]},@{[$i]}"} && 
                !$tr{"@{[$j]},@{[$i+1]}"}) {
                $i = $i+1;
                $nxt_dir = "E";
                # good
            }
            elsif ($tr{"@{[$j]},@{[$i+1]}"} && 
                !$tr{"@{[$j-1]},@{[$i]}"}) {
                $j = $j-1;
                $nxt_dir = "N";
            }
            else {
                say "ERRORL";
            }
        }
        when (/\|/)  {
            if (!$tr{"@{[$j-1]},@{[$i]}"}) {
                $j = $j-1;
                $nxt_dir = "N";
            }
            elsif (!$tr{"@{[$j+1]},@{[$i]}"}) {
                $j = $j+1;
                $nxt_dir = "S";
            }
            else {
                say "ERROR";
            }
        }
        when (/-/)  {
            if ($tr{"@{[$j]},@{[$i+1]}"}
                && !$tr{"@{[$j]},@{[$i-1]}"}) {
                $i = $i-1;
                $nxt_dir = "W";
            }
            elsif ($tr{"@{[$j]},@{[$i-1]}"}
                && !$tr{"@{[$j]},@{[$i+1]}"}) {
                $i = $i+1;
                $nxt_dir = "E";
            }
            else {
                say "ERROR";
            }
        }
        when (/S/) {
            if ($bd[$j][$i+1] eq "J" && !$tr{"@{[$j]},@{[$i+1]}"}) {
                $i++;
                $nxt_dir = "N";
            } elsif ($bd[$j+1][$i] eq "J" && !$tr{"@{[$j+1]},@{[$i]}"}) {
                $j++;
                $nxt_dir = "W";
            } elsif ($bd[$j][$i+1] eq "7" && !$tr{"@{[$j]},@{[$i+1]}"}) {
                $i++;
                $nxt_dir = "S";
            } elsif ($bd[$j-1][$i] eq "7" && !$tr{"@{[$j-1]},@{[$i]}"}) {
                $j--;
                $nxt_dir = "W";
            } elsif ($bd[$j][$i-1] eq "F" && !$tr{"@{[$j]},@{[$i-1]}"}) {
                $i--;
                $nxt_dir = "S";
            } elsif ($bd[$j-1][$i] eq "F" && !$tr{"@{[$j-1]},@{[$i]}"}) {
                $j--;
                $nxt_dir = "E";
            } elsif ($bd[$j+1][$i] eq "|" && !$tr{"@{[$j+1]},@{[$i]}"}) {
                $j++;
                $nxt_dir = "S";
            } elsif ($bd[$j-1][$i] eq "|" && !$tr{"@{[$j-1]},@{[$i]}"}) {
                $j--;
                $nxt_dir = "N";
            } elsif ($bd[$j][$i+1] eq "-" && !$tr{"$j,@{[$i+1]}"}) {
                $i++;
                $nxt_dir = "E";
            } elsif ($bd[$j][$i-1] eq "-" && !$tr{"$j,@{[$i-1]}"}) {
                $i--;
                $nxt_dir = "W";
            } elsif ($bd[$j][$i-1] eq "L" && !$tr{"@{[$j]},@{[$i-1]}"}) {
                $i--;
                $nxt_dir = "N";
            } elsif ($bd[$j+1][$i] eq "L" && !$tr{"@{[$j+1]},@{[$i]}"}) {
                $j--;
                $nxt_dir = "E";
            }
        }
    }
    return $nxt_dir;
}
