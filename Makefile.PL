#
#  Task::BeLike::HMA::Toolchain - Makefile.PL
#
#  Copyright (c) 2010-2011 Henning Manske. All rights reserved.
#
#  This program is free software. You can redistribute it and/or modify it
#  under the terms of either: the GNU General Public License as published
#  by the Free Software Foundation; or the Artistic License.
#
#  See http://dev.perl.org/licenses/
#
#  This program is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
#

use 5.006001;

use strict;
use warnings;

use inc::Module::Install 1.01;



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
my $eumm = eval { require ExtUtils::MakeMaker; ExtUtils::MakeMaker->VERSION } || 0;
my $mb   = eval { require Module::Build; Module::Build->VERSION } || 0;

my $WANT_CPAN = '1.9301'; # version in Perl 5.8.9 core
my $WANT_EUMM = '6.56';   # 5.12.0
my $WANT_MB   = '0.3603'; # 5.12.0

my $new_cpan = eval $cpan < $WANT_CPAN;
my $new_eumm = eval $eumm < $WANT_EUMM;
my $new_mb   = $] != 5.008 && eval $mb < $WANT_MB;

if ($new_cpan) {
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

bugtracker "https://github.com/hma/$dist/issues";
repository "https://github.com/hma/$dist";

#
#  notes
#
#  * LWP 5.836 base/message.t test 125 fails if Encode < 2.03
#  * YAML::XS 0.33, 0.35 t/regexp fails 5 tests of 18 if Perl < 5.8.5
#  * YAML::XS 0.34 fails with 'undefined symbol: SvPV_const' if Perl < 5.8.8
#    (RT #62054)
#  * Term::ReadLine::Perl fails under CPANPLUS 0.88
#  * DBI 1.616 t/51dbm_file.t fails on Perl 5.8.1
#  * URI 1.56 t/iri.t fails on Perl 5.8.1
#  * Storable 2.20, 2.25 t/dclone.t fail on Perl 5.8.0, pass on 5.6.2, 5.8.1
#  * YAML::Syck 1.14, 1.17 t/3-objects.t fail on Perl 5.8.0, pass on 5.6.2, 5.8.1
#  * YAML::Syck 1.17 requires Test::More 0.88
#  * LWP 6.0+ requires Perl 5.8.8+
#  * clean run only on Perls >= 5.8.9
#

#
#  udate Perl toolchain modules to recent versions
#

requires 'Test::Harness'           => '3.17';                    # 5.10.1
requires 'Test::More'              => '0.94';                    # 5.12.0
requires 'Test'                    => '1.25';                    # 5.8.5
requires 'Scalar::Util'            => '1.18';                    # 5.8.8
requires 'File::Spec'              => '3.29';                    # 5.8.9
requires 'File::Path'              => '2.08';                    # 5.11.1
requires 'File::Temp'              => '0.22';                    # 5.10.1
requires 'version'                 => '0.88';                    # 5.14.0
requires 'Module::CoreList'        => '2.54';                    # 5.15.1
requires 'ExtUtils::Install'       => '1.54';                    # 5.10.1
requires 'ExtUtils::Manifest'      => '1.57';                    # 5.12.0
requires 'ExtUtils::CBuilder'      => '0.27';                    # 5.12.0
requires 'ExtUtils::ParseXS'       => '2.21';                    # 5.12.0

if ($new_cpan || $new_mb || $new_eumm) {
  requires 'Version::Requirements' => '0.101020';                # 5.14.0
  requires 'JSON::PP'              => '2.27200';                 # 5.15.0
  requires 'Parse::CPAN::Meta'     => '1.4401';                  # 5.14.0
  requires 'CPAN::Meta'            => '2.110930';                # 5.15.0
}
requires 'ExtUtils::MakeMaker'     => $WANT_EUMM;

if ($] != 5.008) {
  requires 'Pod::Simple'           => '3.07';                    # 5.10.1
  requires 'Pod::Man'              => '2.22';                    # 5.10.1
  requires 'Pod::Usage'            => '1.36';                    # 5.10.1
}

requires 'Net::FTP'                => '2.75';                    # 5.8.5
requires 'Encode'                  => '2.03' if $] >= 5.007_003;
requires 'Compress::Zlib'          => '2.024';                   # 5.12.0
requires 'Digest::MD5'             => '2.39';                    # 5.10.1
requires 'Digest::SHA'             => '5.47';                    # 5.10.1
requires 'HTML::Parser'            => '3.62';
requires 'URI'                     => '1.40';
requires 'LWP'                     => '5.836';
requires 'File::Which'             => '1.07';
requires 'File::HomeDir'           => '0.93';

if ($] >= 5.008_005) {
  requires 'YAML::XS'              => '0.35';
}
elsif ($] != 5.008) {
  requires 'YAML::Syck'            => '1.14';
}
requires 'YAML'                    => '0.71' if $] >= 5.008_001;

requires 'IO::File'                => '1.13' if $] >= 5.008;     # 5.8.8
requires 'Storable'                => '2.19' if $] != 5.008;     # 5.8.9
requires 'Archive::Tar'            => '1.52';                    # 5.10.1
requires 'Archive::Zip'            => '1.30';

if ($new_mb) {
  requires 'Perl::OSType'          => '1.000';                   # fix for Module::Build 0.36_19+
  requires 'Module::Metadata'      => '1.000002';                # fix for Module::Build 0.36_20+
}
requires 'Module::Build'           => $WANT_MB if $] != 5.008;
requires 'Text::Glob';
requires 'CPAN'                    => $WANT_CPAN;

if ($] >= 5.008_001 && index( $^X, 'perlbrew' ) == -1) {
  requires 'DBI'                   => '1.615';
  requires 'DBD::SQLite'           => '1.30_06';
  requires 'CPAN::SQLite'          => '0.199';
}

requires 'Term::ReadKey';
requires 'Term::ReadLine::Perl';

build_requires 'Test::More';

clean_files "$dist-* Debian_CPANTS.txt";
makemaker_args dist => { COMPRESS => 'gzip -9f' };

auto_install;

WriteAll;
