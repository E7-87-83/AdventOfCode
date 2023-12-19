use v5.30.0;
use warnings;
# use Data::Printer;
use List::Util qw/sum min max/;

=pod
my @workflows = (
'px{a<2006:qkq,m>2090:A,rfg}',
'pv{a>1716:R,A}',
'lnx{m>1548:A,A}',
'rfg{s<537:gd,x>2440:R,A}',
'qs{s>3448:A,lnx}',
'qkq{x<1416:A,crn}',
'crn{x>2662:A,R}',
'in{s<1351:px,qqz}',
'qqz{s>2770:qs,m<1801:hdj,R}',
'gd{a>3333:R,R}',
'hdj{m>838:A,pv}',
);
=cut

open FH1,"<","day19_input1.txt";

my @workflows;

while (<FH1>) {
    chomp;
    push @workflows, $_;
}


my @goods;

my %wf;
for my $workflow (@workflows) {
  if ($workflow =~ /^(\w+)\{(\S+)\}$/) {
    my $t = $1;
    $wf{$t} = [];
    my @insts = split ",", $2;
    for my $inst (@insts) {
      if ($inst =~ /^(\S+):(\S+)$/) {
        push $wf{$t}->@*, {rule => $1, nxt => $2};
      } else {
        push $wf{$t}->@*, {rule => "", nxt => $inst};
      }
    }
  } else {
    die "Unexpected\n";
  }
}


sub check {
    my $p = $_[0];
    my $cur_wf = $_[1];
    if (!($cur_wf eq "A" || $cur_wf eq "R")) {
        my @children = process($wf{$cur_wf}, $p)->@*;
        for my $child (@children) {
            next if scalar $child->{p}->@* == 0;
            check($child->{p}, $child->{cur_wf});
        }
    }
    elsif ($cur_wf eq "A") {
        push @goods, $p if scalar $p->@* != 0;
    }
}


sub process {
    my @children;
    my @laws = $_[0]->@*;
    my $p = $_[1];
    my $cur;
    my $i = 0;
    my $cur_p = $p;
    do {
        my $rule = $laws[$i]->{rule};
        if ($rule eq "") {
            push @children,
                { p => $cur_p, cur_wf => $laws[$i]->{nxt} };
        } else {
            my $pp;
            if ($rule =~ /(\w)\<(\d+)/) {
                $pp = 0 if $1 eq "x";
                $pp = 1 if $1 eq "m";
                $pp = 2 if $1 eq "a";
                $pp = 3 if $1 eq "s";
                my $kp = overlapped($cur_p, $pp,1,$2-1);
                push @children, {
                    p => $kp,
                    cur_wf => $laws[$i]->{nxt}
                };
                $cur_p = overlapped($cur_p, $pp,$2, 4000);
            } elsif ($rule =~ /(\w)\>(\d+)/) {
                $pp = 0 if $1 eq "x";
                $pp = 1 if $1 eq "m";
                $pp = 2 if $1 eq "a";
                $pp = 3 if $1 eq "s";
                my $kp = overlapped($cur_p, $pp,$2+1,4000);
                push @children, {
                    p => $kp,
                    cur_wf => $laws[$i]->{nxt}
                };
                $cur_p = overlapped($cur_p, $pp,1,$2);
            } else {
                die "Unexpected\n";
            }
        }
        p $cur_p;
        $i++;
    } until ($i > $#laws);
    return [@children];
}

sub overlapped {
    my $p = $_[0];
    my $cur_p->@* = $p->@*;
    my $i = $_[1];
    my $lower_bd = $_[2];
    my $upper_bd = $_[3];
    $cur_p->[2*$i] = max($cur_p->[2*$i], $lower_bd);
    $cur_p->[2*$i+1] = min($cur_p->[2*$i+1], $upper_bd);
    return [] if $cur_p->[2*$i] > $cur_p->[2*$i+1];
    return $cur_p;
}

check([1,4000,1,4000,1,4000,1,4000],"in");

# p @goods;


my $ans = 0;
for my $gd (@goods) {
    my ($a, $b, $c, $d, $e, $f, $g, $h)= $gd->@*;
    $ans += ($b-$a+1)*($d-$c+1)*($f-$e+1)*($h-$g+1);
}

say $ans;
