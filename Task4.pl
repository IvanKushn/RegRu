#!/usr/bin/perl -w

use DBI;

my $name = 'Иван Иванов';

my $dbh = DBI->connect("DBI:Informix:test_base\@test_serv",'informix','informix') or die "Невозможно присоединиться к серверу !!!";

my $mas = $dbh->selectall_arrayref("select dname from domains d, users u where d.user_id=u.user_id and name='$name' order by dname");

print "\nДомены $name:\n";
print "  @$_[0]\n" for (@$mas);

$dbh->disconnect;
