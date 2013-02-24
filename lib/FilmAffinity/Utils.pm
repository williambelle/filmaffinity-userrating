package FilmAffinity::Utils;

use strict;
use warnings;

=head1 NAME - FilmAffinity::Utils

Utils for FilmAffinity

=cut

require Exporter;

our @ISA    = qw/Exporter/;
our @EXPORT = qw/demoronize/;

=head1 EXPORT

=head2 demoronize

Remove funky Windows 'smart' characters.

Most of this code is borrowed from Catalyst::Plugin::Params::Demoronize

=cut

sub demoronize {
  my $str = shift;

  return $str unless defined $str;
  
  my $demoronizeReplaceMap = {
    '\x{201A}' => ',',          # 82, SINGLE LOW-9 QUOTATION MARK
    '\x{201E}' => ',,',         # 84, DOUBLE LOW-9 QUOTATION MARK
    '\x{2026}' => '...',        # 85, HORIZONTAL ELLIPSIS
    '\x{02C6}' => '^',          # 88, MODIFIER LETTER CIRCUMFLEX ACCENT
    '\x{2018}' => '`',          # 91, LEFT SINGLE QUOTATION MARK
    '\x{2019}' => "'",          # 92, RIGHT SINGLE QUOTATION MARK
    '\x{201C}' => '"',          # 93, LEFT DOUBLE QUOTATION MARK
    '\x{201D}' => '"',          # 94, RIGHT DOUBLE QUOTATION MARK
    '\x{2022}' => '*',          # 95, BULLET
    '\x{2013}' => '-',          # 96, EN DASH
    '\x{2014}' => '-',          # 97, EM DASH
    '\x{2039}' => '<',          # 8B, SINGLE LEFT-POINTING ANGLE QUOTATION MARK
    '\x{203A}' => '>',          # 9B, SINGLE RIGHT-POINTING ANGLE QUOTATION MARK
  };
  
  foreach my $replace ( keys( %{$demoronizeReplaceMap} ) ) {
      my $replacement = $demoronizeReplaceMap->{$replace};
      $str =~ s/$replace/$replacement/g;
  }
  
  return $str;
}

=head1 AUTHOR

William Belle, C<< <william.belle at gmail.com> >>

=head1 BUGS

Please report any bugs or feature requests to C<bug-filmaffinity-userrating at rt.cpan.org>, or through
the web interface at L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=FilmAffinity-UserRating>.  I will be notified, and then you'll
automatically be notified of progress on your bug as I make changes.

=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc FilmAffinity::Utils

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

1; # End of FilmAffinity::Utils