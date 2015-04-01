#!/usr/bin/env perl

use strict;
use warnings;
use utf8::all;
use autodie;
use 5.010;

use Mac::PropertyList qw(parse_plist_fh);
use Term::ANSIColor;
use Data::Dumper;

my $TOTAL_SLOTS = 10;

sub main {
    open( my $battery_info_fh, '-|', '/usr/sbin/ioreg', '-arc', 'AppleSmartBattery' );
    my $battery_info    = parse_plist_fh($battery_info_fh)->[0];
    my $battery_percent = $battery_info->{CurrentCapacity}->value / $battery_info->{MaxCapacity}->value;
#    open( my $battery_info_fh, '-|', '/usr/bin/pmset', '-g', 'batt' );
#    my $battery_percent;
#    while ( my $line = <$battery_info_fh> ) {
#        if ( $line =~ /InternalBattery/ ) {
#            my ( $percent ) = $line =~ /(\d+)%;/;
#            $battery_percent = $percent / 100;
#        }
#    }
    my $filled          = int( $battery_percent * $TOTAL_SLOTS );
    my $empty           = $TOTAL_SLOTS - $filled;
    my $filled_slots    = '▸' x $filled;
    my $empty_slots     = '▹' x $empty;
    my $slots           = sprintf '%s%s', $filled_slots, $empty_slots;
    my $color_text =
          $battery_percent > 0.6 ? 'green'
        : $battery_percent > 0.4 ? 'yellow'
        :                          'red';
    say colored( $slots, $color_text );
}

main @ARGV;
