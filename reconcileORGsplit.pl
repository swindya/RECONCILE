#!c:/perl64/bin/perl.exe -w

####################################################
######### BACA DATA INTERNAL #######################
####################################################
#$file='./INPUT/HOLDING_DATA_140408SAMPLE.csv';

use DBI;
 $dbh = DBI->connect('dbi:mysql:reconcile','myuser','userku')
   or die "Connection Error: $DBI::errstr\n";
 $sql = "select * from myfilereg";
 $sth = $dbh->prepare($sql);
 $sth->execute
   or die "SQL Error: $DBI::errstr\n";
 while (@row = $sth->fetchrow_array) {
   print "$row[1]\n";
   $fileint = $row[1];
   #$fileeks1 = $row[2];
   #$fileeks2 = $row[3];
   #$fileeks3 = $row[4];
 } 
$filepathi = './uploadreg/' . $fileint;
#$filepathe1 = './uploadreg/' . $fileeks1;
#$filepathe2 = './uploadreg/' . $fileeks2;
#$filepathe3 = './uploadreg/' . $fileeks3;

open(INFO, $filepathi) or die("Could not open  file.");

$linecount = 0; 
$linemulaidata = 0;
$statusline = 0;
#$i = 0;
foreach $line (<INFO>)  {   
	$linecount += 1;
	$baris = $line;
	#Cari baris data (karakter pertama adalah angka
	#if ( (ord(substr($line,0,1)) > 47) && (ord(substr($line,0,1)) < 58) && ($statusline==0)) {
	$charkiri = substr($line,0,1);
	if ( (ord($charkiri) > 47) && (ord($charkiri) < 58)) {
		$linemulaidata = $linecount;
		$statusline = 1;
		@barisdata = split('\|',$baris);
		#print "$barisdata[0]" . "<>" . "$barisdata[1]" . '==';
		$jmldata = scalar(@barisdata);
		#print Dumper \@barisdata . "\n";
		$jmld = @barisdata;
		print "$line \n";
		print "$jmldata" . "++" . "$#barisdata\n";
	}

}
close(INFO);
print "Jumlah Baris: $linecount\n";
print "Data mulai pd baris ke: $linemulaidata\n";
print "<h1>Hello, World!</h1>\n";

$coba = "Saya|tidak|mau|mandi|malam";
@cobaku = split('\|',$coba);
$fuih = @cobaku;
print "\n $fuih\n";
print "$cobaku[0]";


