use v5.30;
use warnings;
use integer;

my $reg_a;
my $reg_b;
my $reg_c;
my @code;

=pod Part I
while (<>) {
    chomp;
    $reg_a = $1 if /^Register A: (\d+)$/;
    $reg_b = $1 if /^Register B: (\d+)$/;
    $reg_c = $1 if /^Register C: (\d+)$/;
    if (/^Program: ([0-9|,]+)$/) {
        @code = split ",", $1;
    }
}
=cut
  my $k = 35184372088832;
# my $k = 100681100500000;
# my $k = 36783450500000;
# my $k = 204251759500000;
# my $k = 203190000000000;
# while ($k < 282000000000000) {
while ($k < 200681100500000) {
    find_reg_a($k);
    $k += 6017191;
}
# 395136991232 # end of three output
sub find_reg_a {
    my $i = 0;
    my $init_reg_a = $_[0];
    $reg_a = $init_reg_a;
    $reg_c = 0;
    $reg_b = 0;
    # @code = (0,3,5,4,3,0);
    #                1,5,0,6,6,6,3,4,5,4,7,2,5,135056211711
    #        5,7,4,2,1,0,5,7,7,4,5,0,2,7,1,5,36792550500000
    #        5,6,1,2,0,5,2,4,7,0,6,5,2,5,5,7,77300650500000
    #        5,0,1,3,4,5,1,6,5,0,6,7,0,3,2,5,70065419500000
    #        5,5,7,5,4,6,3,6,5,3,7,5,4,3,3,7
    @code = (2,4,1,1,7,5,0,3,1,4,4,4,5,5,3,0);
    my @output;
    while ($i <= $#code-1) {
        my $opcode = $code[$i];
        if ($opcode == 0) {
            $reg_a = $reg_a / (1<< combo($code[$i+1]));
            $i += 2;
        }
        if ($opcode == 1) {
            $reg_b = $reg_b ^ $code[$i+1];
            $i += 2;
        }
        if ($opcode == 2) {
            $reg_b = combo($code[$i+1]) % 8;
            $i += 2;
        }
        if ($opcode == 3 && $reg_a != 0) {
            $i = $code[$i+1];
        } elsif ($opcode == 3) {
            $i += 2;
        }
        if ($opcode == 4) {
            $reg_b = $reg_b ^ $reg_c;
            $i += 2;
        }
        if ($opcode == 5) {
            my $out = combo($code[$i+1]) % 8;
            push @output, split "", $out;
            $i += 2;
        }
        if ($opcode == 6) {
            $reg_b = $reg_a / (1<< combo($code[$i+1]));
            $i += 2;        
        }
        if ($opcode == 7) {
            $reg_c = $reg_a / (1<< combo($code[$i+1]));
            $i += 2;        
        }
    }

    if ((join ",",@output) eq (join",",@code)) {
        say $init_reg_a;
        exit;
    }
    if ($output[-1] == $code[-1] &&
    $output[-2] == $code[-2] &&
    $output[-3] == $code[-3] 
    ) {say $init_reg_a;exit;}
    say join ",",@output,$init_reg_a;
}


sub combo {
    if ($_[0] <= 3) {return $_[0];}
    return $reg_a if $_[0] == 4;
    return $reg_b if $_[0] == 5;
    return $reg_c if $_[0] == 6;
    warn "7 appears in literal operand\n" if $_[0] == 7;
}
