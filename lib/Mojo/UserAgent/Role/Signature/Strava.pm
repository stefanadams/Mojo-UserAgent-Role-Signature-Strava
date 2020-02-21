package Mojo::UserAgent::Role::Signature::Strava;
use Mojo::Base 'Mojo::UserAgent::Role::Signature::Base';

has api_key => 'API_KEY';

sub sign_tx {
  my $self = shift;
  $self->tx->req->headers->authorization(sprintf 'Bearer %s', $self->api_key);
  return $self->tx;
}

1;
