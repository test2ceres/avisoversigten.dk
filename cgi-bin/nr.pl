#!/usr/bin/perl
##############################################################################
#add-avis.pl                                                                                                                                                                                        #
##############################################################################
#made by Birger Breum wget.lib@breum.dk                                                                                                                                #
##############################################################################
#version 0.01                                                                                                                                                                                     #
##############################################################################
#print "Content-type: text/html\n\n";
#print "<html>\n\n";
require "/hotel/software/WWW/cgi_bin/cgi-lib/cgi-lib.pl";
&ReadParse(*input); 


$newindexfile='/hotel/avisoversigten/indexfiler/avisindexfile.txt';
$newerindexfile='/hotel/avisoversigten/indexfiler/avisindexfile.txt';
$delimiter = "%%==%%";  


$gotonr=$input{'nr'}; 

&readall;

&saveall;
&sendtourl;

sub sendtourl
{
print "Content-type: text/html\n";
print "Location: $righturl\n\n";
print "<center><h1>De bliver nu sendt til $righturl</h1>";
}

sub readall
{
open (INDEXFILE, "$newindexfile");
@lines = <INDEXFILE>;
close (INDEXFILE);
$nr=-1;
foreach $line (@lines)
{

$nr++;
($num[$nr],$nrvisits[$nr],$url[$nr],$Title[$nr],$Description[$nr],$seekwords[$nr],$linktype[$nr],$date[$nr],$pass[$nr],$email[$nr])=split(/$delimiter/,$line);
if ($num[$nr] eq $gotonr)
	{
	$righturl=$url[$nr];
	$nrvisits[$nr]++;
	}


}
}

sub saveall
{
open (NEWERINDEXFILE, ">$newerindexfile");
$nr=-1;
foreach $line (@lines)
{
$nr++;
#$nrvisits[$nr]=1;
#linien ovenfor er til nusltilling
if ($url[$nr])
{
print NEWERINDEXFILE "$num[$nr]$delimiter$nrvisits[$nr]$delimiter$url[$nr]$delimiter$Title[$nr]$delimiter$Description[$nr]$delimiter$seekwords[$nr]$delimiter$linktype[$nr]$delimiter$date[$nr]$delimiter$pass[$nr]$delimiter$email[$nr]$delimiter$delimiter$delimiter\n";
}
}
close (NEWERINDEXFILE);
}


