#!/usr/bin/perl
open (INDEXFILE, "/hotel/open/avisabonnementer.txt");
	@lines =  <INDEXFILE>;
close (INDEXFILE);






$mail_program = "/usr/sbin/sendmail -t";

$touser="testing\@rejs-med.dk";
$fromuser="\"Birger Avisoversigten.dk\"<bmb\@avisoversigten.dk>";

$subject="Rabat på Jyllandsposten";

foreach $line (@lines)
{
#print $line;
@part=split(/\&T1\=/,$line);
#print $part[1];
#print "\n";
if ($line =~ /jyllands/i)
	{
	&sendmail;
	}

else
{
#print $mail{"$part[1]"};
$mail{"$part[1]"}="yes";
#print $mail{"$part[1]"};
#print "DONTUSE\n";
}
$mail{"$part[1]"}="yes";
}



#&sendmail;


sub sendmail
{
$replacewithdate= $part[3];
$touser=$part[1];
chomp ($touser);

#print $touser;
#$touser='birger@breum.dk';


#exit;
#return;
open (MAIL, "|$mail_program") ;
print MAIL <<__END_OF_MAIL__;
To: $touser
From: $fromuser
Subject: $subject



Kære bruger af avisoversigten.dk

Du har for nogen tid siden tilkendegivet overfor avisoversigten.dk at du er interesseret i billige tilbud fra Jyllandsposten. Hvis du gerne vil fjernes fra listen skal du blot sende mig en mail, så ordner jeg det.

Jyllandsposten har for tiden et tilbud: Morgenavisen Jyllands-Posten leveret hver fredag, lørdag og søndag
      i 5 uger til kr. 68.
Se mere på:

http://www.avisoversigten.dk/jyllandsposten

mvh
Birger Breum 
Avisoversigten.dk


__END_OF_MAIL__

close (MAIL);

}
