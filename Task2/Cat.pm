package Cat;

use parent Animal;

sub new {
  my $class = shift;
  my $self = Animal->new;

  $self->{new_name} = 'a Cat';

  bless($self,$class);
  return $self;
}

sub new_name {
  my $self = shift;
  $self->{new_name} = shift if @_;
  return $self->{new_name};
}

sub who_are_you {
  my $self = shift;
  my $name = $self->new_name;
  print "It's $name\n";

  print "And it's also\n";

  $self->SUPER::who_are_you;

  return $self;
}
1;