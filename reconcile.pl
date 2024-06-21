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
   $fileint = $row[1];
   $fileeks1 = $row[2];
   $fileeks2 = $row[3];
   $fileeks3 = $row[4];
 } 
$filepathi = './uploadreg/' . $fileint;
$filepathe1 = './uploadreg/' . $fileeks1;
$filepathe2 = './uploadreg/' . $fileeks2;
$filepathe3 = './uploadreg/' . $fileeks3;

#################### Baca File INTERNAL ###################

open(INFO, $filepathi) or die("Could not open  file.");
$linecount = 0; 
$linemulaidata = 0;
$statusline = 0;
$i = 0;
foreach $line (<INFO>)  {   
	$linecount += 1;
	$baris = $line;
	#print "$line\n";
	#Cari baris data (karakter pertama adalah angka
	#if ( (ord(substr($line,0,1)) > 47) && (ord(substr($line,0,1)) < 58) && ($statusline==0)) {
	$charkiri = substr($line,0,1);
	if ( (ord($charkiri) > 47) && (ord($charkiri) < 58)) {
		$linemulaidata = $linecount;
		$statusline = 1;
		@barisdata = split('\|',$baris);
		$jmldata = scalar(@barisdata);
		$jmld = @barisdata;
		$itgl[$i] = $barisdata[0];
		$mytgl = $itgl[$i];
		$itgl[$i] =~ s/^\s+|\s+$//g;
		$iaccname[$i] = $barisdata[1];
		$iaccname[$i] =~ s/^\s+|\s+$//g;
		$icliname[$i] = $barisdata[2];
		$icliname[$i] =~ s/^\s+|\s+$//g;
		$iinscode[$i] = $barisdata[4];
		$iinscode[$i] =~ s/^\s+|\s+$//g;
		$iamnt[$i] = $barisdata[5];
		$iamnt[$i] =~ s/^\s+|\s+$//g;
		$idepos[$i] = $barisdata[7];
		$idepos[$i] =~ s/^\s+|\s+$//g;
		$ibpid[$i] = $barisdata[8];
		$ibpid[$i] =~ s/^\s+|\s+$//g;
		$iacc[$i] = $barisdata[9];
		$iacc[$i] =~ s/^\s+|\s+$//g;
		$ibs4acc[$i] = $barisdata[10];
		$ibs4acc[$i] =~ s/^\s+|\s+$//g;
		$ieuroacc[$i] = $barisdata[11];
		$ieuroacc[$i] =~ s/^\s+|\s+$//g;
		$istatmatch[$i] = 0;
		$i++;
	}
}
close(INFO);
$ijmlbaris = $i;

#################### Baca File EKSTERNAL 1 (CBEST) ###################

open(INFO, $filepathe1) or die("Could not open  file.");
$linecount = 0; 
$i = 0;
foreach $line (<INFO>)  {   
	$linecount += 1;
	$baris = $line;
	#print "$line\n";
	#Cari baris data (karakter pertama adalah angka
	#if ( (ord(substr($line,0,1)) > 47) && (ord(substr($line,0,1)) < 58) && ($statusline==0)) {
	$charkiri = substr($line,0,3);
	if ($charkiri eq 'BNI') {
		$statusline = 1;
		@barisdata = split('\|',$baris);
		$jmldata = scalar(@barisdata);
		$jmld = @barisdata;
		$e1acc[$i] = $barisdata[0];
		$e1acc[$i] =~ s/^\s+|\s+$//g;
		$e1amnt[$i] = $barisdata[1];
		$e1amnt[$i] =~ s/^\s+|\s+$//g;
		$e1inscode[$i] = $barisdata[2];
		$e1inscode[$i] =~ s/^\s+|\s+$//g;
		$e1statmatch[$i] = 0;
		$i++;
	}

}
close(INFO);
$e1jmlbaris = $i;

#################### Baca File EKSTERNAL 2 (BS4) ###################

open(INFO, $filepathe2) or die("Could not open  file.");
$linecount = 0; 
$i = 0;
foreach $line (<INFO>)  {   
	$linecount += 1;
	$baris = $line;
	#Cari baris data (karakter pertama adalah angka
	$charkiri = substr($line,0,1);
	#if ( (ord(substr($line,0,1)) > 47) && (ord(substr($line,0,1)) < 58) && ($statusline==0)) {
	if ( (ord($charkiri) > 47) && (ord($charkiri) < 58)) {
		$statusline = 1;
		@barisdata = split(/\t/,$baris);
		$jmldata = scalar(@barisdata);
		$jmld = @barisdata;
		$e2tgl[$i] = $barisdata[0];
		$e2tgl[$i] =~ s/^\s+|\s+$//g;
		$e2inscode[$i] = $barisdata[2];
		$e2inscode[$i] =~ s/^\s+|\s+$//g;
		$e2acc[$i] = $barisdata[3];
		$e2acc[$i] =~ s/^\s+|\s+$//g;
		$e2nama[$i] = $barisdata[4];
		$e2nama[$i] =~ s/^\s+|\s+$//g;
		$e2amnt[$i] = $barisdata[$jmld-1];
		$e2amnt[$i] =~ s/^\s+|\s+$//g;
		$e2statmatch[$i] = 0;
		$i++;
	}

}
close(INFO);
$e2jmlbaris = $i;

#################### Baca File EKSTERNAL 3 (EUROCLEAR) ###################

open(INFO, $filepathe3) or die("Could not open  file.");
$linecount = 0; 
$i = 0;
foreach $line (<INFO>)  {   
	$linecount += 1;
	$baris = $line;
	$charkiri = substr($line,0,1);
	#Cari 
	$karmo1 = '97A';
	$karmo2 = '35B';
	$karmo3 = '93B';
	$karmo3a = 'AVAI';
	if (index($baris, $karmo1) != -1) {
		@barisdata = split('97A',$baris);
		@datasub = split('//', $barisdata[1]);
		$jmldata = @datasub;
		$e3acc[$i] = $datasub[$jmldata-1];
		$e3acc[$i] =~ s/^\s+|\s+$//g;
		$e3statmatch[$i] = 0;
		$i++;
	}
	if (index($baris, $karmo2) != -1) {
		@barisdata = split('35B',$baris);
		@datasub = split('//', $barisdata[1]);
		$jmldata = @datasub;
		$e3inscode[$i] = $datasub[$jmldata-1];
		$e3inscode[$i] =~ s/^\s+|\s+$//g;
	}	
	if ((index($baris, $karmo3) != -1) && (index($baris, $karmo3a) != -1)) {
		@barisdata = split('FAMT/',$baris);
		@datasub = split(',', $barisdata[1]);
		$jmldata = @datasub;
		$e3amnt[$i] = $datasub[0];
		$e3amnt[$i] =~ s/^\s+|\s+$//g;
	}

}
close(INFO);
$e3jmlbaris = $i;


##################### PROSES MATCH #1 : Internal vs CBEST #######################
$accumnt = 0;
$iistr = '';
for (my $i = 0; $i <= $e1jmlbaris; $i++) {
	for (my $ii = 0; $ii <= $ijmlbaris; $ii++) {
		#print "$iacc[$i] \n";
		$iistr = '';
		if (($istamatch[$ii] == 0) && ($idepos[$ii] eq 'CBEST')) {
			if ($e1acc[$i] eq $iacc[$ii] ) {
				if ($e1inscode[$i] eq $iinscode[$ii]) {
					$accmnt = $iamnt[$ii];
					if ($e1amnt[$i] == $accmnt) {
						$e1statmatch[$i] = 9;		# MATCH
						$istatmatch[$ii] = 9;
						@iios = split('\|',$iistr);
						$iijmlos = @iios;
						if ($iijmlos > 1) {
							for ($j = 1; $j < $iijmlos; $j++) {
								$istatmatch[$iios[$j]] = 9;
							}
						}
						print $idepos[$ii] . '**' . $e1acc[$i] . '**' . $e1inscode[$i] . '**' . $icliname[$ii] . '**' . "$accmnt\n";
						last;
					}
					else	{
						$iistr = $iistr . '|' . $ii;
						$e1statmatch[$i] = 1;		# Partial match
						$istatmatch[$ii] = 1;		# Partial Match
						$accmnt = $accmnt + $iamnt[$ii];
					}
				}
			}
		}
	}
}


##################### PROSES MATCH #2 : Internal vs BS4 #######################
$accumnt = 0;
$iistr = '';
for (my $i = 0; $i <= $e2jmlbaris; $i++) {
	for (my $ii = 0; $ii <= $ijmlbaris; $ii++) {
			$iistr = '';
			#print "$idepos[$ii]\n";
			if (($istamatch[$ii] == 0)  && ($idepos[$ii] eq 'BIS4')) {
				#print '@' . $e2acc[$i] . "++" . $ibs4acc[$ii] . '@' . "\n";
				if ($e2acc[$i] eq $ibs4acc[$ii]) {
					#print $e2inscode[$i] . "--" . $iinscode[$ii] . "\n";
					if ($e2inscode[$i] eq $iinscode[$ii]) {
						$accmnt = $iamnt[$ii];
						if ($e2amnt[$i] == $accmnt) {
							#print $e2inscode[$i] .  "\n";
							$e2statmatch[$i] = 9;		# MATCH
							$istatmatch[$ii] = 9;
							@iios = split('\|',$iistr);
							$iijmlos = @iios;
							if ($iijmlos > 1) {
								for ($j = 1; $j < $iijmlos; $j++) {
									$istatmatch[$iios[$j]] = 9;
								}
							}
							print $e2acc[$i] . '<>' . $e2inscode[$i] . '<>' . $iaccname[$i] . '<>' . "$accmnt\n";
							last;
						}
						else {
							$iistr = $iistr . '|' . $ii;
							$e2statmatch[$i] = 1;		# Partial match
							$istatmatch[$ii] = 1;		# Partial Match
							$accmnt = $accmnt + $iamnt[$ii];
						}
					}
				}
			}
		
	}
}

##################### PROSES MATCH #3 : Internal vs EUROCLEAR #######################
$accumnt = 0;
$iistr = '';
for (my $i = 0; $i <= $e3jmlbaris; $i++) {
	for (my $ii = 0; $ii <= $ijmlbaris; $ii++) {
			$iistr = '';
			#print "$idepos[$ii]\n";
			if (($istamatch[$ii] == 0)  && ($idepos[$ii] eq 'EUROCLEAR')) {
				if ($e3acc[$i] eq $ieuroacc[$ii]) {
					print $e3inscode[$i] . "--" . $iinscode[$ii] . "\n";
					if ($e3inscode[$i] eq $iinscode[$ii]) {
						$accmnt = $iamnt[$ii];
						if ($e3amnt[$i] == $accmnt) {
							#print $e2inscode[$i] .  "\n";
							$e3statmatch[$i] = 9;		# MATCH
							$istatmatch[$ii] = 9;
							@iios = split('\|',$iistr);
							$iijmlos = @iios;
							if ($iijmlos > 1) {
								for ($j = 1; $j < $iijmlos; $j++) {
									$istatmatch[$iios[$j]] = 9;
								}
							}
							print $e3acc[$i] . '<>' . $e3inscode[$i] . '<>' . $iaccname[$i] . '<>' . "$accmnt\n";
							last;
						}
						else {
							$iistr = $iistr . '|' . $ii;
							$e3statmatch[$i] = 1;		# Partial match
							$istatmatch[$ii] = 1;		# Partial Match
							$accmnt = $accmnt + $iamnt[$ii];
						}
					}
				}
			}
		
	}
}


for (my $ii = 0; $ii < $ijmlbaris; $ii++) {
	if ($istatmatch[$ii] == 0) {
		print $idepos[$ii] . '++++' . $icliname[$ii] . "\n";
	}
}


my $find = "/";
my $replace = "_";
$find = quotemeta $find; # escape regex metachars if present
$mytgl =~ s/$find/$replace/g;

##################### CREATE FILE : INTERNAL - All Matches (status=9) ######################

my $existingdir = './OUTPUT';
mkdir $existingdir unless -d $existingdir; # Check if dir exists. If not create it.
# Use the open() function to create the file.
my $filename = $mytgl . '_internal_allmatch.txt';
my $file = $existingdir . '/' . $filename;
unless(open FILE, '>'.$file) {
	# Die with error message 
	# if we can't open it.
	die "nUnable to create $filen";
}
for (my $k = 0; $k < $ijmlbaris; $k++) {
	if ($istatmatch[$k] == 9) {
		print FILE $itgl[$k] . '|' . $iaccname[$k] . '|' . $icliname[$k] . '|' . $iinscode[$k] . 
			'|' . $idepos[$k] . '|' . $iamnt[$k] . '|' . $iacc[$k] . '|' . $ibs4acc[$k] . '|' .
			$ieuroacc[$k] . "\n";
	}
}
close FILE;
#####################################################################################################

##################### CREATE FILE : INTERNAL - All NOT Matches (status=0 or 1) ######################

my $existingdir = './OUTPUT';
mkdir $existingdir unless -d $existingdir; # Check if dir exists. If not create it.
# Use the open() function to create the file.
my $filename = $mytgl . '_internal_nomatch.txt';
my $file = $existingdir . '/' . $filename;
unless(open FILE, '>'.$file) {
	# Die with error message 
	# if we can't open it.
	die "nUnable to create $filen";
}
for (my $k = 0; $k < $ijmlbaris; $k++) {
	if ($istatmatch[$k] < 9) {
		print FILE $itgl[$k] . '|' . $iaccname[$k] . '|' . $icliname[$k] . '|' . $iinscode[$k] . 
			'|' . $idepos[$k] . '|' . $iamnt[$k] . '|' . $iacc[$k] . '|' . $ibs4acc[$k] . '|' .
			$ieuroacc[$k] . "\n";
	}
}
close FILE;
#####################################################################################################

##################### CREATE FILE : CBEST - All NOT Matches (status=0 or 1) ######################

my $existingdir = './OUTPUT';
mkdir $existingdir unless -d $existingdir; # Check if dir exists. If not create it.
# Use the open() function to create the file.
my $filename = $mytgl . '_cbest_nomatch.txt';
my $file = $existingdir . '/' . $filename;
unless(open FILE, '>'.$file) {
	# Die with error message 
	# if we can't open it.
	die "nUnable to create $filen";
}
for (my $k = 0; $k < $e1jmlbaris; $k++) {
	if ($e1statmatch[$k] < 9) {
		print FILE $e1acc[$k] . '|' . $e1amnt[$k] . '|' . $e1inscode[$k] . "\n";
	}
}
close FILE;
#####################################################################################################

##################### CREATE FILE : BSI4 - All NOT Matches (status=0 or 1) ######################

my $existingdir = './OUTPUT';
mkdir $existingdir unless -d $existingdir; # Check if dir exists. If not create it.
# Use the open() function to create the file.
my $filename = $mytgl . '_bs4_nomatch.txt';
my $file = $existingdir . '/' . $filename;
unless(open FILE, '>'.$file) {
	# Die with error message 
	# if we can't open it.
	die "nUnable to create $filen";
}
for (my $k = 0; $k < $e2jmlbaris; $k++) {
	if ($e2statmatch[$k] < 9) {
		print FILE $e2tgl[$k] . '|' . $e2inscode[$k] . '|' . $e2acc[$k] . '|' . 
		$e2nama[$k] . '|' . $e2amnt[$k] . "\n";
	}
}
close FILE;
#####################################################################################################

##################### CREATE FILE : EUROCLEAR - All NOT Matches (status=0 or 1) ######################

my $existingdir = './OUTPUT';
mkdir $existingdir unless -d $existingdir; # Check if dir exists. If not create it.
# Use the open() function to create the file.
my $filename = $mytgl . '_euroclear_nomatch.txt';
my $file = $existingdir . '/' . $filename;
unless(open FILE, '>'.$file) {
	# Die with error message 
	# if we can't open it.
	die "nUnable to create $filen";
}
for (my $k = 0; $k < $e3jmlbaris; $k++) {
	if ($e3statmatch[$k] < 9) {
		print FILE $e3acc[$k] . '|' . $e3inscode[$k] . '|' . $e2amnt[$k] . "\n";
	}
}
close FILE;
#####################################################################################################



print "Jumlah Baris: $linecount\n";
print "Data mulai pd baris ke: $linemulaidata\n";
print "<h1>Hello, World!</h1>\n";

$coba = '1//2//4';
@cobaku = split('//',$coba);
$fuih = @cobaku;
print "\n $fuih\n";
print "$cobaku[$fuih-1]";


