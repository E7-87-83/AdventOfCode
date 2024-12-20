use v5.30;
use warnings;
use List::Util qw/any/;

my @strips = qw/wbur gurr wrbuu bbrrr gbb uugw rggb wruwur uwrwru gbbwb rr ggb wgub wbuwrugr ubugggb gur wbgrwu bbw guur ubrwubu guuwb uub gbu grguwg wrg gguuw urgbg gubu brbrbw gbg rrub gwb uwu b guwrguu rrrrwg rgwggb wrbbw wbb uww uwww wwbw ggwwbbr u wggbrgw rbr bwwb rguwr gbr gugb rbw rrwburgg uurb wbgbgu urr brwbrr ww uggrrb bgg gwggg wwgbu wgg gwrgwu gwur gguu ruugg grruuwrw wuuu grrbbg rgr wuwrr wwgrgu uurbr brb rwgg ugur ubwu ug buguubrg wgrg rwbuw rgbb uwwu bwrrbb ububru wrw brgwrww bug rgbwb rbgw rgbuuu uruwr ugub bwuwwr ugu rbwru rwg bwu rb gwgrur rgbgwg wur wurg ruw uu wgrgw grrb bbrggwb bwbwg bbu rbuurg bruw wbgggwg ugbb gbugu rwr ggurb bgb wbuwwur rg burbggg rubbrgbu grrruub bwuwb rrgurrw rgrbubw wrww uguuubu uwbb burur grr ub rrruw urg ugbr guwubg wruu wbbwb wgr bgwru rbgb wwur bbur rugggr wggugwu bwbgb urrrgrww ubuuurr wggrr wwgw brr wwbug ubww ggr wwb uru gru uruu gwbg brwr gwugrr wbr urrwur bbrgwg gggg bwug gbrbwugg bgr bugbb wgww bruurb uwgbuw uwrr gww rgub guwbwwuw bbgbbr ruu bguwb gug wgbrbw rwgrgru ububrb wwr grw urb wrrr buuug bur rugwu bw bbuwbwb rrwb rwbb gbugur wuu ugg urgu bbugb buu ruwbb bggbg rgb rruww bgbubwuu wwub rguw gb rgg wwwuuu wgu ggbu guurruu rgu urwuuwb rrwu rbbrbg br ugwgu rrbrwuw gbbuw rrgb uwb uwrgg wrgww guru rbrw ugurgbu bgrr wrrrwubg wbgug rubrwu gguwu wgru wugwgr guu rguu guwwrgg rru wbrbbr wurb gwbwr bww uwwwr bbwgbw rwugu gwug rrr ugbgbbr ugb rrbu rruwrbb rbug uwwuu buwgrr ubwbbgw bugugw wwu uubwwb gbrggwg uwr gbrrr bwrbwu uuuwrur guugu gwu gwbbw buw uw rrwg gugbw rgwuwr wgw gubgu uggbgr bwg grb wbguw wrur wugwg wbug grrbrw wuub uggbuu urbgb w gruwr ruug gurw bwbg rbwgwrww ubw bwb bwurgw rwu ubr ubgw wrb bu brw rw uwrwr wbwug ubrruu rwuw ruuu rbwu uguu rug bwr gg wwg ubu gwubw brg gruwrbrr uuu rbwuubgu wug rwuu uuw gbgw wru ugw bwbgwr uwbwub grbr gwuw rbub urw wr ubb rbb rub ggw uurwg wbg uuruu gr rbwbugg rbg wuwg bub rgw bbb guwb uurgb wwbwguwu rgwgggw bwbr wuw grgrbw rrw wbgur uuww www wrwwbb grrrbgu gubgr ugrwb wgbgwu ubur uur gguwub gu bbww grur bwbbg uuurrgb guuru burb bb gbw bgbwbbur rbu gbrr ru wgrgbu guwuwb gugg wgrgrwu uwg rrggg bgw bbg gwr gugw rubu wu gugu uubu wg rrb wrr uuugbw gub ruwrg ubrwww gwggw ugr rrrrr wbu gwwwurb wrwrgrw wrbbrb rwb grrw urrbwbbu wub gwrbw wuuw wrrrbbbr ggg wurw gbrbw ugrbgwgr guw wugrg wbwrgrg uwrrru rrrgur r bru wgb wbru bgu gw bwrgbgww rwwuw gwrbgbu rwurg gbuwrwg ggu rwug wugrb ubwub bbr uug wwwg grrugug wb grurr rrg gbggg ggrgrwr rrggburu rur/;

my @words;


=pod
@strips = qw/r wr b g bwu rb gb br/;
@words = qw/
brwrr
bggr
gbbr
rrbgbr
ubwu
bwurrg
brgr
bbrgwb/;
=cut



while (<>) {
    chomp;
    push @words, $_;
}

sub can {
    my $w = $_[0];
    my @arr = (0) x ((length $w) + 1);
    $arr[0] = 1;
    for my $i (0..(length $w)) {
        for my $j (0..$i-1) {
            if ($arr[$j]) {
                $arr[$i] += $arr[$j] if any {$_ eq substr($w,$j,$i-$j)} grep {length $_ == $i-$j} @strips; 
                # $arr[$i] = 1 if ...     PART I
            }
        }
    }
    return $arr[-1];
}

my $count = 0;
for my $w (@words) {
    $count+= can $w;
}

say $count;
