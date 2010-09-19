#
#  Task::BeLike::HMA::Toolchain - Makefile.PL
#
#  Copyright (c) 2010 Henning Manske. All rights reserved.
#
#  This program is free software. You can redistribute it and/or modify it
#  under the terms of either: the GNU General Public License as published
#  by the Free Software Foundation; or the Artistic License.
#
#  See http://dev.perl.org/licenses/
#
#  This module is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
#

use strict;
use warnings;

use inc::Module::Install 1.00;



#
#  preliminary special setup for this Task
#

# hack required to let Module::AutoInstall detect Term::ReadLine::Perl

eval { require Term::ReadLine };

# setup message if update of CPAN.pm config is required

unless ($ENV{PERL5_CPAN_IS_RUNNING}) {
  require CPAN;
  delete $ENV{PERL5_CPAN_IS_RUNNING};
  delete $ENV{PERL5_CPANPLUS_IS_RUNNING};
}

my $cpan = eval { CPAN->VERSION } || 0;

my $WANT_CPAN = '1.9301'; # version in Perl 5.8.9 core

if ($cpan < $WANT_CPAN) {
  no warnings 'once';
  *MY::postamble = sub {
    print "\n*** Please run 'cpan' after 'make' to update CPAN.pm config.\n\n";
    return "all ::\n"
      . "\t\$(NOECHO) \$(ECHO)\n"
      . "\t\$(NOECHO) \$(ECHO) \"*** Please run 'cpan' to update CPAN.pm config.\"\n"
      . "\t\$(NOECHO) \$(ECHO)\n";
  }
}

# force Module::AutoInstall to use CPAN.pm

$ENV{PERL_AUTOINSTALL_PREFER_CPAN} = 1;



#
#  module metadata
#

my $NAME = 'Task::BeLike::HMA::Toolchain';

(my $dist = $NAME) =~ s|::|-|g;
(my $path = $NAME) =~ s|::|/|g;

name       $dist;
license    'perl';
all_from   "lib/$path.pm";

bugtracker "http://github.com/hma/$dist/issues";
repository "http://github.com/hma/$dist";

#
#  notes
#
#  * LWP 5.836 base/message.t test 125 fails if Encode < 2.03
#  * YAML::XS 0.33 t/regexp fails 5 tests of 18 if Perl < 5.8.5
#  * Term::ReadLine::Perl fails under CPANPLUS 0.88
#  * clean run only on Perls >= 5.8.3
#

#
#  udate Perl toolchain modules to recent versions
#

requires 'version'              => '0.77';                    # 5.10.1 core
requires 'Net::FTP'             => '2.75';                    # 5.8.5  core
requires 'Encode'               => '2.03';
requires 'Test'                 => '1.25';                    # 5.8.5  core
requires 'Pod::Man'             => '2.22';                    # 5.10.1 core
requires 'Compress::Zlib'       => '2.024';                   # 5.12.0 core
requires 'Digest::MD5'          => '2.39';                    # 5.10.1 core
requires 'LWP'                  => '5.836';
requires 'ExtUtils::MakeMaker'  => '6.56';                    # 5.12.0 core
requires 'Digest::SHA'          => '5.47';                    # 5.10.1 core
requires 'File::Spec'           => '3.29';                    # 5.8.9  core
requires 'File::Path'           => '2.08';                    # 5.11.1 core
requires 'File::Which';
requires 'File::Temp'           => '0.22';                    # 5.10.1 core
requires 'File::HomeDir'        => '0.93';
requires 'Storable'             => '2.19';                    # 5.8.9  core
requires 'YAML::Syck'           => '1.14';
requires 'YAML'                 => '0.71' if $] >= 5.008_001;
requires 'YAML::XS'             => '0.33' if $] >= 5.008_005;
requires 'Test::More'           => '0.62';                    # 5.8.8  core
requires 'Test::Harness'        => '3.17';                    # 5.10.1 core
requires 'ExtUtils::CBuilder'   => '0.27';                    # 5.12.0 core
requires 'ExtUtils::Install'    => '1.54';                    # 5.10.1 core
requires 'ExtUtils::Manifest'   => '1.58';                    # 5.13.3 core
requires 'ExtUtils::ParseXS'    => '2.21';                    # 5.12.0 core
requires 'IO::File'             => '1.13';                    # 5.8.8  core
requires 'YAML::Tiny'           => '1.41';
requires 'Archive::Tar'         => '1.52';                    # 5.10.1 core
requires 'Module::Build'        => '0.36';                    # 5.11.3 core
requires 'Text::Glob';
requires 'CPAN'                 => $WANT_CPAN;
requires 'Term::ReadKey';
requires 'Term::ReadLine::Perl';

build_requires 'Test::More';

clean_files "$dist-* Debian_CPANTS.txt";
makemaker_args dist => { COMPRESS => 'gzip -9f' };

auto_install;

WriteAll;
