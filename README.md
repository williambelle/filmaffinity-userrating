FilmAffinity-UserRating
=======================

Perl interface to FilmAffinity

Synopsis
--------

Get filmaffinity voted movies from a user

```perl
use FilmAffinity::UserRating;

my $parser = FilmAffinity::UserRating->new( userID => '123456' );
my $ref_movies = $parser->parse();
```
    
Via the command-line program

    filmaffinity-get-rating.pl --userid=123456

Installation
------------

To install this module, run the following commands:

	perl Build.PL
	./Build
	./Build test
	./Build install

Support and documentation
-------------------------

After installing, you can find documentation for this module with the
perldoc command.

    perldoc FilmAffinity::UserRating

You can also look for information at:

* RT, CPAN's request tracker (report bugs here)
  http://rt.cpan.org/NoAuth/Bugs.html?Dist=FilmAffinity-UserRating

* AnnoCPAN, Annotated CPAN documentation
  http://annocpan.org/dist/FilmAffinity-UserRating

* CPAN Ratings
  http://cpanratings.perl.org/d/FilmAffinity-UserRating

* Search CPAN
  http://search.cpan.org/dist/FilmAffinity-UserRating/


Licence and Copyright
---------------------

Copyright (C) 2013 William Belle

This program is free software; you can redistribute it and/or modify it
under the terms of either: the GNU General Public License as published
by the Free Software Foundation; or the Artistic License.

See http://dev.perl.org/licenses/ for more information.


