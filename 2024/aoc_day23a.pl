# algorithm follows https://github.com/shah314/clique2

use v5.30;
use warnings;
use List::Util qw/any none shuffle/;

my %adj;
my %conn;
my %node;

while (<>) {
    chomp;
    /^(\w{2})-(\w{2})$/;
    $conn{"$1-$2"} = 1;
    $conn{"$2-$1"} = 1;
    $node{$1} = 1;
    $node{$2} = 1;
    $adj{$1} = [] if !defined $adj{$1};
    $adj{$2} = [] if !defined $adj{$2};
    push $adj{$1}->@*, $2;
    push $adj{$2}->@*, $1;
}

my @arr;

for my $k (sort {$a cmp $b} keys %node) {
    for my $j (grep {$_ ge $k} $adj{$k}->@*) {
        for my $l (grep {$_ ge $j} $adj{$j}->@*) {
            push @arr, "$k-$j-$l" if $conn{"$k-$l"};
        }
    }
}

my $boss_max = 0;
my @boss_clique;

for (1..1000) {

my $s = int(rand(1+$#arr));
my @gbest_clique_node = split "-", $arr[$s];
my %filtering;
while (scalar keys %filtering < (scalar $adj{$gbest_clique_node[0]}->@* - $#gbest_clique_node)) {
    CLOOP: for my $candidate ($adj{$gbest_clique_node[0]}->@*) {
        for my $j (1..$#gbest_clique_node) {
            if (none {$candidate eq $_} $adj{$gbest_clique_node[$j]}->@*) {
                $filtering{$candidate} = 1;
                next CLOOP;
            }
        }
        $filtering{$candidate} = 1;
        push @gbest_clique_node, $candidate;
    }
}
my $marked_max = scalar @gbest_clique_node;
say join "-", @gbest_clique_node;

my $ITER = 40;
my $count = 0;
while ($count < $ITER) {
    my %filter0ing;
    my @gbest0_clique_node = shuffle map {$_} @gbest_clique_node;

    if (@gbest0_clique_node > 4) {
        pop @gbest0_clique_node;
        pop @gbest0_clique_node;
    }

    my $i = 0;
    my $max_deg = scalar $adj{$gbest0_clique_node[$i]}->@*;
    for my $ci (1..$#gbest0_clique_node) {
        my $deg = scalar $adj{$gbest0_clique_node[$ci]}->@*;
        if ($deg > $max_deg) {
            $i = $ci;
            $max_deg = $deg;
        }
    }
    while (keys %filter0ing < $max_deg - scalar @gbest0_clique_node + 1) {
        CLOOP: for my $candidate ($adj{$gbest0_clique_node[$i]}->@*) {
            for my $j (0..$i-1, $i+1..$#gbest0_clique_node) {
                if (none {$candidate eq $_} $adj{$gbest0_clique_node[$j]}->@*) {
                    $filter0ing{$candidate} = 1;
                    next CLOOP;
                }
            }
            $filter0ing{$candidate} = 1;
            push @gbest0_clique_node, $candidate;
        }
    }
    if (scalar @gbest0_clique_node > $marked_max) {
        @gbest_clique_node = @gbest0_clique_node;
        $marked_max = scalar @gbest0_clique_node;
    }
    $count++;
}
say $marked_max;
say join "-", @gbest_clique_node;
    if ($marked_max > $boss_max) {
        @boss_clique = map {$_} @gbest_clique_node;
        $boss_max = $marked_max;
    }
}


say $boss_max;
say join ",", sort {$a cmp $b} @boss_clique;
