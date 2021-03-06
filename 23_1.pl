use 5.020;
use strict;
use warnings;


my %by_val;
my @cups = map { my $c= {cup=>$_,next=>undef,prev=>undef};$by_val{$c->{cup}} = $c; $c } split(//,$ARGV[0]);
my $size= @cups;
my $max = $size - 1;

for (my $i=0;$i<@cups;$i++) {
    $cups[$i]->{prev} = $cups[$i-1];
    $cups[$i]->{next} = $cups[($i+1)% $size];
}

my $current = $cups[0];
for my $m (1..100) {
    say "\nround $m";

    my $remove_start = $current->{next};
    my $remove_end = $remove_start->{next}{next};
    $current->{next} = $remove_end->{next};
    $current->{next}{prev} = $current;
    my %skip=(
        $remove_start->{cup}=>1,
        $remove_start->{next}{cup}=>1,
        $remove_start->{next}{next}{cup}=>1,
    );

    my $val = ($current->{cup} - 1) || $size;
    my $destination;
    while (!$destination) {
        $destination = $by_val{$val} unless $skip{$val};
        $val = (($val-1) % $size) || $size;
    }
    my $destination_after = $destination->{next};

    $destination->{next} = $remove_start;
    $remove_start->{prev} = $destination;
    $destination_after->{prev} = $remove_end;
    $remove_end->{next} = $destination_after;

    $current = $current->{next};
}

say result($by_val{1});

sub result {
    my $dh = shift;
    my $res;
    for (1..8) {
        $dh = $dh->{next};
        $res.=$dh->{cup};
    }
    return $res;
}

sub dumpcups {
    my $dh = shift;
    for (1..9) {
        print $dh->{cup}. ', ';
        $dh = $dh->{next};
    }
    print"\n";
}
