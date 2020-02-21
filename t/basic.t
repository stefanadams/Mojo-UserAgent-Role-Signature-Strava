use Mojo::Base -strict;

use Test::More;

use Mojo::File 'curfile';
use Mojo::UserAgent;

use lib curfile->dirname->sibling('lib')->to_string;

my $ua = Mojo::UserAgent->new;
my $tx = $ua->build_tx(GET => '/abc');
is $tx->req->headers->header('X-Mojo-Signature'), undef, 'unsigned request';
is $tx->req->url, '/abc', 'right unsigned url';
$ua = $ua->with_roles('+Signature');
$ua->add_signature(strava => {api_key => 'abc'});
is $ua->signature, 'strava', 'right signature attribute';
$tx = $ua->build_tx(GET => '/abc');
is $tx->req->headers->header('X-Mojo-Signature'), 'Strava', 'signed strava request';
is $tx->req->headers->authorization, 'Bearer abc', 'right strava authorization';
is $tx->req->url, '/abc', 'right strava url';
$ua->signature(undef);
$tx = $ua->build_tx(GET => '/abc');
is $tx->req->headers->header('X-Mojo-Signature'), undef, 'unsigned request';
is $tx->req->url, '/abc', 'right unsigned url';

done_testing;
