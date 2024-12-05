use v5.30;
use warnings;
use Data::Printer;
use List::MoreUtils qw/firstidx/;
my $isSectionOne = 1;
my @ord;
my @seq;
my %fow;
my $sum;

while (<>) {
    chomp;
    $isSectionOne = 0 if !$_;
    if ($isSectionOne) {
        push @ord, [split /\|/, $_];
    }
    if (!$_) {
=pod
        my @head;
        my %followers;
        for my $m (@ord) {
            $fow{$m->[0]} = [];
        }
        for my $m (@ord) {
            push $fow{$m->[0]}->@*, $m->[1];
            $followers{$m->[1]} = 1;
        }
        for my $k (keys %fow) {
            push @head, $k if !defined($followers{$k});
        }
        for my $k (keys %fow) {
            push @head, $k;
        }
        my @tree;
        my @final_tree;
        my %appear;
        for my $h (@head) {
            for my $f ($fow{$h}->@*) {
                push @tree, [$h, $f];
                $appear{"$h,$f"} = 1;
            }
            while (scalar @tree > 0) {
                for my $i (0..$#tree) {
                    my $t = $tree[$i];
                    my $k = $t->[-1];
                    for my $f ($fow{$k}->@*) {
                        my $idx = firstidx {$_ == $f} $t->@*;
                        if ($idx == -1) {
                            push $t->@*, $f;
                        } else {
                            # splice($t->@*,$idx,1);
                            push $t->@*, $f;
                            push @final_tree, splice(@tree, $i, 1);
                        }
                        $appear{"$k,$f"} = 1;
                        #            say join " ", $t->@*;
                    }
                }
            }
        }
        p @final_tree;
=cut
    }
    if ($_ && !$isSectionOne) {
        my $mid = check($_);
        if ($mid == -1) {
            my $adj = adjust($_);
            $sum += $adj;
        }
    }
}

say $sum;

sub check {
    my @arr = split ",", $_[0];
    my %p;
    for my $i (0..$#arr) {
        $p{$arr[$i]} = $i;
    }
    for my $m (@ord) {
        return -1 if defined($p{$m->[0]}) && defined($p{$m->[1]}) && ($p{$m->[0]} > $p{$m->[1]});
    }
    return $arr[$#arr/2];
}

sub adjust {
    my %p;
    for my $m (@ord) {
        $p{$m->[0].",".$m->[1]} = 1;
    }
    my @original_arr = split ",", $_[0];
    my @arr = @original_arr;
    while (check(join ",",@arr)==-1) {
        for my $i (0..$#arr) {
            for my $m (@ord) {
                if ($m->[0] == $arr[$i]) {
                    for my $j (0..$i-1) {
                        if ($m->[1] == $arr[$j]) {
                            my $k = $i;
                            for my $t ($i+1..$#arr) {
                                $k = $t if defined $p{$m->[0].",".$arr[$t]};
                            }
                            my @tmp_head = grep {$_ != $m->[1]} map {$arr[$_]} (0..$k);
                            my @tmp_tail = map {$arr[$_]} ($k+1..$#arr);
                            @arr = (@tmp_head, $m->[1], @tmp_tail);
                        }
                    }
                }
            }
        }
    }
    return $arr[$#arr/2];
}
