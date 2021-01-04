# (anonymous user #1211606) 21*
use strict;
use warnings;

sub killparentheses {

    my $CHECK = $_[0];
    my $line = $_[1];
    my $max = $CHECK;
    my $changed;
    do {
        $changed = 0;
        my $bchar, my $echar;
        my @char = split // , $line;
        my $stack = 0;
        loopx:
        for my $i (0..$#char) {
            if ( $char[$i] eq '(' ) {
                $stack += 1;
                $bchar = $i;
                if ($stack >= $max) {$changed++; }
            } elsif ($char[$i] eq ')') {
                $stack -= 1;
                $echar = $i;
                if ($stack+1 == $CHECK) {last loopx;}
            }
        }
        if ($changed>0) {
          $line =  substr($line,0, $bchar)
            . myeval(substr($line, $bchar+1, $echar-$bchar-1))
            . substr($line,$echar+1)  ; }
    } while ($changed > 0);

    return $line;
}


sub myeval {
    my $line = $_[0];
    $line =~ s/^\s+|\s+$//g;
    my @term_or_op = split / / , $line;
    my @new_term;
    my @begin_addition;
    my @end_addition;
    my @addsignlctn;
    my @others;
    for (0..$#term_or_op) {
        if ($term_or_op[$_] eq '+') {
            push @addsignlctn , $_;
        } else {
            push @others , $_;
        }
    }
    if (@addsignlctn) {
        @begin_addition = ($addsignlctn[0]);
        @end_addition = ($addsignlctn[0]);
        for my $i (1..$#addsignlctn) {
            if ($addsignlctn[$i]-2 == $addsignlctn[$i-1]) { 
                pop @end_addition;
                push @end_addition, $addsignlctn[$i];
            } else {
                push @begin_addition, $addsignlctn[$i];
                push @end_addition, $addsignlctn[$i];
            }
        }

        die "unequal terms" if $#begin_addition != $#end_addition;
    
        my $count = 0; my $next = 0;
        while ($count <= $#term_or_op) {
            if (   $next <= $#begin_addition
                   && $count == $begin_addition[$next]-1
               ) {
                my $j = $next;
                my $sum = $term_or_op[$begin_addition[$j]-1];
                for (my $l = $begin_addition[$j]; 
                        $l <= $end_addition[$j]; 
                        $l += 2) {
                     $sum += $term_or_op[$l+1]; }
                push @new_term, $sum;
                $next++ unless $next == $#begin_addition;
                $count += 2*( ($end_addition[$j]-$begin_addition[$j])/2 +1);
            } else {
                push @new_term, $term_or_op[$count];
            }
            $count += 2;
        }
        my $product = 1;
        for (@new_term) {$product *= $_;}
        return $product;
    } else { #if there exists no addition signs
          @others = grep {$term_or_op[$_] ne '*'} @others;
          my $product = 1;
          for (@others) {$product *= $term_or_op[$_];}
          return $product;
    }
}



my @myinput;
my $ln = 0;
my $bracket;


while (defined($bracket = <STDIN>)) { 
    chomp($bracket);
    $myinput[$ln] = $bracket;
    $ln++;
}

for (0..$ln-1) {
    $myinput[$_] = killparentheses(2, $myinput[$_]);
    #       print $myinput[$_], "\n";
}

print "\n";

for (0..$ln-1) {
    $myinput[$_] =  killparentheses(1, $myinput[$_]);
#       print $myinput[$_], "\n";
}

#print "\n";

my $sum = 0;
for (0..$ln-1) {
    $sum += myeval($myinput[$_]);
}

print $sum, "\n";
