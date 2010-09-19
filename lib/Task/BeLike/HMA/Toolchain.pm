package Task::BeLike::HMA::Toolchain;

use strict;
use warnings;

use 5.006001;

our $VERSION = '0.02_01';

$VERSION = eval $VERSION;

1;

__END__

=head1 NAME

Task::BeLike::HMA::Toolchain - HMA's Perl toolchain update

=head1 VERSION

This is version 0.02_01 of Task::BeLike::HMA::Toolchain as of Sep 19, 2010.

=head1 SYNOPSIS

  perl Makefile.PL
  make

  # re-run Makefile.PL to see if all modules got installed
  perl Makefile.PL

  # if CPAN.pm has been updated by this Task
  cpan

  # ...and remember to commit changes to config
  o conf commit

  # make test and install if you want (not required)
  make test
  make install

=head1 DESCRIPTION

Task::BeLike::HMA::Toolchain is HMA's personal L<Task> to update the Perl
toolchain modules to recent versions.

See C<Makefile.PL> for details.

=head1 SEE ALSO

L<Task|http://search.cpan.org/perldoc?Task>

=head1 AUTHOR

Henning Manske <hma@cpan.org>

=head1 COPYRIGHT AND LICENSE

Copyright (c) 2010 Henning Manske. All rights reserved.

This module is free software. You can redistribute it and/or modify it
under the terms of either: the GNU General Public License as published
by the Free Software Foundation; or the Artistic License.

See L<http://dev.perl.org/licenses/>.

This module is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

=cut
