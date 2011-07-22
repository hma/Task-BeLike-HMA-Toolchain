Task::BeLike::HMA::Toolchain
============================

Task::BeLike::HMA::Toolchain is HMA's personal Task to update the Perl
toolchain modules to recent versions.

See "Makefile.PL" for details.


# SYNOPSIS / INSTALLATION

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


# COPYRIGHT AND LICENSE

Copyright (c) 2010-2011 Henning Manske. All rights reserved.

This module is free software. You can redistribute it and/or modify it
under the terms of either: the GNU General Public License as published
by the Free Software Foundation; or the Artistic License.

See http://dev.perl.org/licenses/

This module is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
