# (anonymous user #1211606) 21*

sub killparentheses {

    my $CHECK = $_[0];
    my $line = $_[1];
    my $max = $CHECK;

    do {
        $changed = 0;
        my $bchar, $echar;
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
    $cur = int $term_or_op[0];
    for (my $i = 1; $i <= $#term_or_op - 1; $i += 2) {
        if ($term_or_op[$i] eq '*') {
            $cur = $cur * $term_or_op[$i+1];
        } elsif ($term_or_op[$i] eq '+') {
            $cur = $cur + $term_or_op[$i+1];
        }
    }
    return $cur;
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
}

for (0..$ln-1) {
    $myinput[$_] =  killparentheses(1, $myinput[$_]);
}

my $sum = 0;
for (0..$ln-1) {
    $sum += myeval($myinput[$_]);
}

print $sum, "\n";
