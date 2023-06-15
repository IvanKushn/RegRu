#!/usr/bin/perl -w 

use FindBin qw($RealBin);
use lib "$RealBin";
use Cat;

my $it = Cat->new;

$it->who_are_you;
