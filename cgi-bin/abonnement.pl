#!/usr/bin/perl

print "Content-type: text/html\n\n";
print "<html>\n\n";

$input= $ENV{'QUERY_STRING'};
$input=~ s/\+/ /g;
$input=~ s/\n/<br>/g;
$linieskift='%0D%0A';
$input=~ s/$linieskift/<br>/g;
$input =~ s/%([A-Fa-f0-9]{2})/pack("c",hex($1))/ge;

open (FILE, ">>/hotel/open/avisabonnementer.txt");

print FILE "$input\n";
close (FILE);
print '<meta http-equiv="REFRESH"; content="0; URL=http://www.avisoversigten.dk/modtaget.shtml">';
