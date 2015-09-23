#!/usr/bin/perl

########################################################################
## Copyright (c) 2009 Sigma Consulting Services Limited
## v1.00 2009/06/21 16:54:23 Ian McMichael
##
## This program is free software: you can redistribute it and/or modify
## it under the terms of the GNU General Public License as published by
## the Free Software Foundation, either version 2 of the License, or
## any later version.
##
## This program is distributed in the hope that it will be useful,
## but WITHOUT ANY WARRANTY; without even the implied warranty of
## MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
## GNU General Public License for more details.
##
## You should have received a copy of the GNU General Public License
## along with this program.  If not, see <http://www.gnu.org/licenses/>.
########################################################################

use Logwatch ':dates';

my $Debug = $ENV{'LOGWATCH_DEBUG'} || 0;

$SearchDate = TimeFilter('%d-%b %H:%M');

if ( $Debug > 5 ) {
   print STDERR "DEBUG: Inside ApplyBaculaDate...\n";
   print STDERR "DEBUG: Looking For: " . $SearchDate . "\n";
}

my $OutputLine = 0;

while (defined($ThisLine = <STDIN>)) {
   if ($ThisLine =~ m/^$SearchDate /o) {
      $OutputLine = 1;
   } elsif ($ThisLine !~ m/^\s+/o) {
      $OutputLine = 0;
   }

   if ($OutputLine) {
      print $ThisLine;
   }
}

# vi: shiftwidth=3 syntax=perl tabstop=3 et
