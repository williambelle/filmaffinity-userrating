package FilmAffinity::Movie;

use strict;
use warnings;

use Text::Trim;
use LWP::RobotUA;
use HTML::TreeBuilder;
use HTML::TreeBuilder::XPath;

use Moose;
use MooseX::Privacy;

use FilmAffinity::Utils;

=head1 NAME - FilmAffinity::Movie

TODO

=head1 VERSION

Version 0.01

=cut

our $VERSION = 0.01;

our %FIELD = (
#  'OFFICIAL WEB'    => 'website',  
  'ORIGINAL TITLE'  => 'title', 
  'YEAR'            => 'year',
#  'CAST'            => 'cast',
#  'RUNNING TIME'    => 'duration',
#  'SYNOPSIS/PLOT'   => 'synopsis',
#  'GENRE'           => 'genre',
#  'STUDIO/PRODUCER' => 'studio',
#  'COMPOSER'        => 'composer',
#  'DIRECTOR'        => 'director',
#  'SCREENWRITER'    => 'screenwriter',
#  'CINEMATOGRAPHER' => 'cinematographer',
);

=head1 ACCESSORS

=head2 $movie->id

get id

=head2 $movie->title

get title

=cut

has id       => ( is  => 'ro',  isa  => 'Int', required => 1, );
has title    => ( is  => 'rw',  isa  => 'Str', );
has year     => ( is  => 'rw',  isa  => 'Int', );

#has website  => ( is  => 'rw',  isa  => 'Str', );
#has duration => ( is  => 'rw',  isa  => 'Int', );
#has cast     => ( is  => 'rw',  );
#has genre    => ( is  => 'rw',  );
#has studio   => ( is  => 'rw',  );
#has synopsis => ( is  => 'rw',  isa  => 'Str', );
#has topic           => ( is  => 'rw',  );
#has producer        => ( is  => 'rw',  );
#has director        => ( is  => 'rw',  );
#has composer        => ( is  => 'rw', );
#has screenwriter    => ( is  => 'rw', );
#has cinematographer => ( is  => 'rw', );

has tree => ( 
  is      => 'rw',
  isa     => 'HTML::TreeBuilder',
  traits  => [qw/Private/],
); 

has ua => ( 
  is      => 'rw',
  isa     => 'LWP::RobotUA',
  traits  => [qw/Private/],
); 

my $MOVIE_URL = 'http://www.filmaffinity.com/en/film';

sub BUILD {
  my ($self, $args) = @_;
 
  $self->tree( HTML::TreeBuilder->new() );
  $self->ua( buildRobot( $args->{delay} || 5 ) );
} 

   
=head2 $movie->getContent()

=cut

sub getContent {
  my ($self) = @_;
  
  my $url = $self->p_buildUrlMovie($self->id);

  my $response = $self->ua->get($url);
  if ($response->is_success){
    return $response->decoded_content();
  }
}

=head2 $movie->parsePage($content)

=cut  
  
sub parsePage {
  my ($self, $content) = @_;
  
  $self->tree->parse($content);

  foreach my $field (keys %FIELD){
    $self->p_findField($field);
  }  

  $self->tree->delete();
}

=head2 $movie->parse()

=cut 

sub parse {
  my $self = shift;
  
  my $content = $self->getContent();
  $self->parsePage($content);
}
 
private_method p_findField => sub {
  my ( $self, $field ) = @_;
  
  my @nodes = $self->tree->findnodes( '//td/b' );
  foreach my $node (@nodes){
    if ( trim( $node->as_text() ) eq $field ){
      
      my $searched_node = $node->parent()->right();
      
      my $td = $searched_node->look_down( 
        _tag  => 'td', 
        align => undef,
        sub { $_[0]->as_HTML() !~ m/table/ }
      );
      
      my $accessor = $FIELD{$field};
      $self->$accessor( trim( demoronize( $td->as_text() ) ) );
      last;
    }
  }
};

private_method p_buildUrlMovie => sub {
  my ($self, $id) = @_;
    
  return $MOVIE_URL.$id.'.html';
};

=head1 AUTHOR

William Belle, C<< <william.belle at gmail.com> >>

=head1 BUGS

Please report any bugs or feature requests to C<bug-filmaffinity-userrating at rt.cpan.org>, or through
the web interface at L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=FilmAffinity-UserRating>.  I will be notified, and then you'll
automatically be notified of progress on your bug as I make changes.

=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc FilmAffinity::Movie

You can also look for information at:

=over 4

=item * RT: CPAN's request tracker (report bugs here)

L<http://rt.cpan.org/NoAuth/Bugs.html?Dist=FilmAffinity-UserRating>

=item * AnnoCPAN: Annotated CPAN documentation

L<http://annocpan.org/dist/FilmAffinity-UserRating>

=item * CPAN Ratings

L<http://cpanratings.perl.org/d/FilmAffinity-UserRating>

=item * Search CPAN

L<http://search.cpan.org/dist/FilmAffinity-UserRating/>

=back

=head1 SEE ALSO

L<http://www.filmaffinity.com>

=head1 LICENSE AND COPYRIGHT

Copyright 2013 William Belle.

This program is free software; you can redistribute it and/or modify it
under the terms of either: the GNU General Public License as published
by the Free Software Foundation; or the Artistic License.

See http://dev.perl.org/licenses/ for more information.

=cut

1; # End of FilmAffinity::Movie