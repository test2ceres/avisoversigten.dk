#!/usr/bin/perl
##############################################################################
#add-avis.pl                                                                                                                                                                                        #
##############################################################################
#made by Birger Breum wget.lib@breum.dk                                                                                                                                #
##############################################################################
#version 0.01                                                                                                                                                                                     #
##############################################################################
print "Content-type: text/html\n\n";
print "<html>\n\n";
require "/hotel/software/WWW/cgi_bin/cgi-lib/cgi-lib.pl";
$agent=$ENV{HTTP_USER_AGENT};
&ReadParse(*input);

if ($agent  =~ /google/i)
{
$robot="Yes";
}
#Jyllands-Posten_468x60.gif

for ($i=0;$i<30;$i++) {
#push (@urls,'googlebanner.txt');
push (@urls,'salesstringbanner.txt');
}
for ($i=0;$i<3;$i++) {
#push (@urls,'btbanner.txt');  
}


$tal = rand(@urls);

$bannerfile = "/hotel/avisoversigten/aviskomponenter/$urls[$tal]";

if ($robot)
{
$bannerfile = "/hotel/avisoversigten/aviskomponenter/feedgoogle.txt";
}

$bundfile='/hotel/avisoversigten/html/bund.shtml';
$topfile2='/hotel/avisoversigten/html/top2.shtml';
$topfile3='/hotel/avisoversigten/html/top3.shtml';
$topfile1='/hotel/avisoversigten/html/top1.shtml';
$seekfile='/hotel/avisoversigten/aviskomponenter/seek.htm';

$bigbrotherfile = "/hotel/avisoversigten/bigbrother/bigbrotheravis.txt";
$bigbrother="$input{'linktype'}$input{'seekword'}";
&bigbrother;
$newindexfile='/hotel/avisoversigten/indexfiler/avisindexfile.txt';

$delimiter = "%%==%%";  
$inputseekword = $input{'seekword'};
$overskrift="=>&nbsp;$inputseekword";

if ($inputseekword eq "")
	{
	$inputseekword="dererikkeindtastetnogetseekword";
	}
$inputlinktype = $input{'linktype'};
if ($inputlinktype eq "")
	{
	$inputlinktype="dererikkeindtastetnogenlinktype";
	}
#print "<h1>$inputlinktype</h1>";
if ($inputlinktype eq "alle")
	{
	$overskrift="Alle&nbsp;aviser";
	}
if ($inputlinktype eq "relaterede")
	{
	$overskrift="Avisrelaterede&nbsp;sites";
	}
if ($inputlinktype eq "lands")
	{
	$overskrift="Landsdækkende&nbsp;aviser";
	}
if ($inputlinktype eq "udland")
	{
	$overskrift="Danske&nbsp;aviser&nbsp;i&nbsp;udlandet";
        $overskrift2="Danske&nbsp;i&nbsp;udlandet";
	}

if ($inputlinktype eq "lokale")
	{
	$overskrift="Lokalaviser";
	}
if ($overskrift eq "=>&nbsp;")
	{
	$overskrift="Avisoversigtens&nbsp;søgeside";
	}










if ($inputlinktype eq "regionale")
	{
	$overskrift="Regionale&nbsp;Aviser";
	}
if ($inputlinktype eq " ")
	{
	$overskrift="Aviser&nbsp;og&nbsp;relaterede&nbsp;links";
	$overskrift2="Aviser+relaterede";
	}
unless($overskrift2){$overskrift2=$overskrift;}
&printtop;
#unless($overskrift2){$overskrift2=$overskrift;}
	&printheadline;

open (INDEXFILE, "$newindexfile");
@lines = <INDEXFILE>;
close (INDEXFILE);
&readall;
if ($input{'listetype'} eq "toplisten")
	{
	print "<h2>Toplistesorteret</h2>";
	&printpopulistisk;
	}
else
	{
	&printalfabetisk;
	}

if ($overskrift eq "Avisoversigtens&nbsp;søgeside")

	{
	$overskrift="Søgesiden";
	&printseekpage;
	}



&printbund;




sub printalfabetisk
{
@sortedtitel = sort(@sorttitel);
foreach $sortline (@sortedtitel)
	{
	($Title,$nr)=split(/$delimiter/,$sortline);
	&testinclude;
	if ($include[$nr] ne "no")
		{
		&printnum;
		}
	}
}

sub printpopulistisk
{
@sortedpopular = sort(@sortpopular);
foreach $sortline (@sortedpopular)
	{
	($nrvisitsekstra,$nr)=split(/$delimiter/,$sortline);
	&testinclude;
	if ($include[$nr] ne "no")
		{
		&printnum;
		}
	}
}

sub testinclude
	{
	$include[$nr]="no";
	&testtype;
	&testseek;
	}

sub testtype
	{	
	if ($linktype[$nr] =~ /$inputlinktype/i) 
		{
		$include[$nr].="linktype";
		}
	}

sub testseek
	{		
	if ($line[$nr] =~ /$inputseekword/i) 
		{
		$include[$nr].="seekword";
		}
	}




sub readall
{
$nr=-1;
foreach $line (@lines)
{

$nr++;
($num[$nr],$nrvisits[$nr],$url[$nr],$Title[$nr],$Description[$nr],$seekwords[$nr],$linktype[$nr],$date[$nr],$pass[$nr])=split(/$delimiter/,$line);



$sorttitel[$nr]="$Title[$nr]$delimiter$nr$delimiter$delimiter";
$nrvisitsekstra[$nr]=99999999999-$nrvisits[$nr];

$sortpopular[$nr]="$nrvisitsekstra[$nr]$delimiter$nr";
$line[$nr]=$line;
}
}

sub printnum
	{
#<a href="/cgibin/avis/nydata.pl?linknr=$num[$nr]&password=$pass[$nr]" target="_top">Ret oplysninger om $Title[$nr]</a>
print <<SLUTUDSKRIFT;
<p><a href="/cgi-bin/nr.pl?nr=$num[$nr]" target="_top">$Title[$nr]</a> 
<br>

<table border="0" cellpadding="0" cellspacing="0">
    <tr>
        <td width="30"><img src="/images/avis.gif"></td>
        <td width="470">$Description[$nr]</td>
    </tr>
</table>
</p>
SLUTUDSKRIFT
	}
sub printheadline
{
print <<SLUTUDSKRIFT;
<h1>$overskrift</h1>
<br>
SLUTUDSKRIFT
}

sub printbund
{
open (bundfile, "$bundfile");
@lines = <bundfile>;
close (bundfile);
print @lines;
}



sub printbanner

{

open (bannerfile, "$bannerfile");

@lines = <bannerfile>;

close (bannerfile);

print "<center>";



print @lines;
#print $bannerfile;

print "</center>";
if ($fastbannerfile)
{
open (bannerfile, "$fastbannerfile");
@lines = <bannerfile>;
close (bannerfile);

print "<center>";
print @lines;
print "</center>";
}
}


sub printtop
{

open (topfile1, "$topfile1");
@lines = <topfile1>;
close (topfile1);
print @lines;

print $overskrift;


open (topfile2, "$topfile2");
@lines = <topfile2>;
close (topfile2);
print @lines;

print $overskrift2;
open (topfile3, "$topfile3");
@lines = <topfile3>;
close (topfile3);
print @lines;
&printbanner;

}

sub printseekpage
{

open (seekfile, "$seekfile");
@lines = <seekfile>;
close (seekfile);
print @lines;
}

sub bigbrother
{
open (BIGBROTHERFILE, ">>$bigbrotherfile");
print BIGBROTHERFILE "\n";
print BIGBROTHERFILE "--------------------------------------------------------------------\n";
print BIGBROTHERFILE $ENV{'REMOTE_ADDR'};
print BIGBROTHERFILE "-";
print BIGBROTHERFILE $ENV{'REMOTE_HOST'};
print BIGBROTHERFILE "-";
print BIGBROTHERFILE $ENV{'REMOTE_USER'};
print BIGBROTHERFILE "-";
print BIGBROTHERFILE $ENV{'HTTP_REFERER'};
print BIGBROTHERFILE "-";
print BIGBROTHERFILE $ENV{'HTTP_USER_AGENT'};
print BIGBROTHERFILE "\n";
print BIGBROTHERFILE $ENV{'QUERY_STRING'};
print BIGBROTHERFILE "\n";
print BIGBROTHERFILE $long_date;
print BIGBROTHERFILE "\n";
print BIGBROTHERFILE $bigbrother;
print BIGBROTHERFILE "<br>\n";

close BIGBROTHERFILE;
}


