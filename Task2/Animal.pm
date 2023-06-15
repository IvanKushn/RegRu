package Animal;

sub new {
  my $class = shift;
  my $self = {};

  $self->{name} = 'an Animal';

  bless($self,$class);
  return $self;
}

sub name {
  my $self = shift;
  $self->{name} = shift if @_;
  return $self->{name};
}

sub who_are_you {
  my $self = shift;
  my $my_name = $self->name;
  print "$my_name\n";
  return $self;
}

1;
