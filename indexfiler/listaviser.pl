$delimiter="%%==%%";
open (AVISFILE, "avisindexfile.txt");
@avislines=<AVISFILE>;
close (AVISFILE);

open (LINKSFILE, ">linksfile.txt");

foreach $avisline (@avislines)
{
($nr,$visits,$url,$title,$description,$kat,$away,$away)=split(/$delimiter/, $avisline);
$titlelink=$title;
$titlelink=~ s/ /+/ig;
print LINKSFILE "<a href=\"http://www.avisoversigten.dk/avis/$titlelink\">$title<\/a><br>\n";
}

close (LINKSFILE);

