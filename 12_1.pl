use strict;
use warnings;
use 5.030;
no strict 'refs';

my @in = map { [/^(\w)(\d+)$/] }  <>;
my @turn=qw(N E S W);
my $dir = 1;
my $r=0;
my $c=0;

for (@in) {
    my ($op, $val) = @$_;
    &$op($val);
}
say abs(0-$r) + abs(0-$c);

sub N { $r -= shift }
sub S { $r += shift }
sub E { $c += shift }
sub W { $c -= shift }
sub F {
    my $val = shift;
    $turn[$dir]->($val);
}
sub L {
    my $val = shift;
    my $times = $val / 90;
    $dir = ($dir - $times) % 4;
}
sub R {
    my $val = shift;
    my $times = $val / 90;
    $dir = ($dir + $times) % 4;
}
