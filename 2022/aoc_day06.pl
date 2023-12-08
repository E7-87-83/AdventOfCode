use v5.30.0;
use warnings;

my @ss = qw/
mjqjpqmgbljsphdztnvjfqwrcgsmlb
bvwbjplbgvbhsrlpgdmjqwftvncz
nppdvjthqldpwncqszvftbrmjlhg
nznrnfrfntjfmvfwmzdfjlvtqnbhcprsg
zcfzfwzzqfrljwzlrfnpqdbhtmscgvjw
/;


for my $s (@ss) {
    if ($s =~ /(\w)(?!\1)(\w)(?!\1|\2)(\w)(?!\1|\2|\3)(\w)(?!\1|\2|\3|\4)(\w)(?!\1|\2|\3|\4|\5)(\w)(?!\1|\2|\3|\4|\5|\6)(\w)(?!\1|\2|\3|\4|\5|\6|\7)(\w)(?!\1|\2|\3|\4|\5|\6|\7|\8)(\w)(?!\1|\2|\3|\4|\5|\6|\7|\8|\9)(\w)(?!\1|\2|\3|\4|\5|\6|\7|\8|\9|\g10)(\w)(?!\1|\2|\3|\4|\5|\6|\7|\8|\9|\g10|\g11)(\w)(?!\1|\2|\3|\4|\5|\6|\7|\8|\9|\g10|\g11|\g12)(\w)(?!\1|\2|\3|\4|\5|\6|\7|\8|\9|\g10|\g11|\g12|\g13)(\w)/
) {
    say index($s,$1.$2.$3.$4.$5.$6.$7.$8.$9.$10.$11.$12.$13.$14)+14;
    }
}
