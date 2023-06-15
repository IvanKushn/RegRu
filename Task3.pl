#!/usr/bin/perl -w

my $datetime = '2016-04-11 20:59:03';
print "\ndatetime = $datetime\n\n";

#my ($date,$time) = $datetime =~ /^(\d{4}-\d\d-\d\d) (\d\d:\d\d:\d\d)$/;
my ($date,$time) = $datetime =~ /([\d*-]*) ([\d*:]*)/;

print "date = $date\ntime = $time\n\n";
