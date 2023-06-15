#!/usr/bin/perl -w
######################
# Simple Phone Book ##
######################

use DBI;

my $dbh = DBI->connect("DBI:Informix:test_base\@test_serv",'informix','informix') or die "Невозможно присоединиться к серверу !!!";
$dbh->do('
create temp table phone_book (
  id     serial,
  number char(20),
  fio    char(40)
)');

$dbh->do("insert into phone_book (number,fio) values('+79181234567','Ivanov I.I.')");
$dbh->do("insert into phone_book (number,fio) values('+79186547893','Ivanov I.I.')");
$dbh->do("insert into phone_book (number,fio) values('+79187894561','Petrov P.P.')");
$dbh->do("insert into phone_book (number,fio) values('+79182583697','Sidorov S.S.')");

while (1) {
  print "\nPhone book:\n";
  print "  1 - print phone book\n";
  print "  2 - new    number\n";
  print "  3 - delete number\n";
  print "  4 - edit   number\n";
  print "  5 - exit\n";
  print "Enter function number: ";
  my $func = <>; 
  chomp $func;

  if ($func =~ /^[1-5]$/) {
    if      ($func == 1) { print_book()
    } elsif ($func == 2) { insert_row()
    } elsif ($func == 3) { delete_row()
    } elsif ($func == 4) { edit_row()
    } elsif ($func == 5) { last }
  } else {
    print "\nBad function number. Try again...\n";
  }
}
$dbh->disconnect;

sub print_book {
  my $mas = $dbh->selectall_arrayref("select * from phone_book order by id");
  print "\nAll Entries:\n";
  print "@$_[0]\t@$_[1]\t@$_[2]\n" for (@$mas);
}

sub insert_row {
  print "\nNew Entry\nEnter a name: ";
  my $name = <>;
  chomp $name;
  print "Enter a phone number: ";
  my $number = <>;
  chomp $number;

  my $ins = $dbh->prepare('insert into phone_book (number,fio) values (?,?)');
  $ins->execute($number,$name);
}

sub delete_row {
  print "\nDelete\nEnter the entry number: ";
  my $id = <>;
  chomp $id;

  if ($id =~ /^[0-9]*$/ ) {
    my $count = $dbh->selectrow_array("select count(*) from phone_book where id='$id'");
    if ($count) {
      $dbh->do("delete from phone_book where id=$id");
      print "\nEntry N$id deleted - OK\n";
    } else {
      print "\nEntry number not found...\n";
    }
  } else {
    print "\nBad entry number...\n";
  }
}

sub edit_row {
  print "\nEdit\nEnter the entry number: ";
  my $id = <>;
  chomp $id;

  if ($id =~ /^[0-9]*$/ ) {
    my $count = $dbh->selectrow_array("select count(*) from phone_book where id='$id'");
    if ($count) {

      print "Name (blank - do nothing): ";
      my $name = <>;
      chomp $name;

      print "Phone number (blank - do nothing): ";
      my $number = <>;
      chomp $number;

      if ($number) {
        my $ins = $dbh->prepare("update phone_book set number=? where id='$id'");
        $ins->execute($number);
      }
      if ($name) {
        my $ins = $dbh->prepare("update phone_book set fio=? where id='$id'");
        $ins->execute($name);
      }
      print "\nEntry N$id updated - OK\n";
    } else {
      print "\nEntry number not found...\n";
    }
  } else {
    print "\nBad entry number...\n";
  }
}
