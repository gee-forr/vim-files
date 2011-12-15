#!/usr/bin/perl
use strict;

my $epoch = shift @ARGV;

die "No date specified - Usage: epoch.pl 1234567890\n" unless $epoch;

print scalar localtime $epoch;
