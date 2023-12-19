use v5.30.0;
use warnings;
use Data::Printer;
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

my @parts = (
'{x=787,m=2655,a=1222,s=2876}',
'{x=1679,m=44,a=2067,s=496}',
'{x=2036,m=264,a=79,s=2244}',
'{x=2461,m=1339,a=466,s=291}',
'{x=2127,m=1623,a=2188,s=1013}',
);
=cut

open FH1,"<","day19_1.txt";
open FH2,"<","day19_2.txt";

my @workflows;
my @parts;

while (<FH1>) {
  chomp;
  push @workflows, $_;
}
while (<FH2>) {
  chomp;
  push @parts, $_;
}

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

my @pt;

for my $part (@parts) {
  if ($part =~ /x=(\d+),m=(\d+),a=(\d+),s=(\d+)/) {
    push @pt, [$1, $2, $3, $4];
  }
}

sub check {
  my $p = $_[0];
  my $cur_wf = "in";
  while (!($cur_wf eq "A" || $cur_wf eq "R")) {
    $cur_wf = process($wf{$cur_wf}, $p);
  }
  return $cur_wf eq "A" ? 1 : 0;
}

sub process {
  my @laws = $_[0]->@*;
  my $p = $_[1];
  my $cur;
  my $i = 0;
  do {
    my $rule = $laws[$i]->{rule};
    if ($rule eq "") {
      $cur = $laws[$i]->{nxt};
    } else {
      my $pp;
      if ($rule =~ /(\w)\<(\d+)/) {
        $pp = 0 if $1 eq "x";
        $pp = 1 if $1 eq "m";
        $pp = 2 if $1 eq "a";
        $pp = 3 if $1 eq "s";
        $cur = $laws[$i]->{nxt} if $p->[$pp] < $2;
      } elsif ($rule =~ /(\w)\>(\d+)/) {
        $pp = 0 if $1 eq "x";
        $pp = 1 if $1 eq "m";
        $pp = 2 if $1 eq "a";
        $pp = 3 if $1 eq "s";
        $cur = $laws[$i]->{nxt} if $p->[$pp] > $2;
      } else {
        die "Unexpected\n";
      }
    }
    $i++;
  } until ($cur);
  return $cur;
}

my $ans = 0;
for my $p (@pt) {
  if (check($p)) {
    $ans += sum($p->@*);
  }
}

say $ans;

use Test::More tests=>5;
ok check($pt[0]);
ok !check($pt[1]);
ok check($pt[2]);
ok !check($pt[3]);
ok check($pt[4]);
