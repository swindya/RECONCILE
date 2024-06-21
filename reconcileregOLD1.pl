#!c:/perl64/bin/perl.exe -w

##########################################################################
########################## BACA DATA INTERNAL ############################
##########################################################################

#$file='./INPUT/HOLDING_DATA_140408SAMPLE.csv';

#use DBI;
# $dbh = DBI->connect('dbi:mysql:reconcile','myuser','userku')
#   or die "Connection Error: $DBI::errstr\n";
# $sql = "select * from myfilereg";
# $sth = $dbh->prepare($sql);
# $sth->execute
#   or die "SQL Error: $DBI::errstr\n";
# while (@row = $sth->fetchrow_array) {
#   $fileint = $row[1];
#   $fileeks1 = $row[2];
#   $fileeks2 = $row[3];
#   $fileeks3 = $row[4];
# } 
$statusada[0]=1;
$statusada[1]=0;
$statusada[2]=0;
$statusada[3]=0;


if (-f './daftar0.txt') {
	open FILE, "./daftar0.txt" or die $!;
	while (<FILE>) {
		$namafile = $_;
		@barisnama = split('\|', $namafile);
		if ($barisnama[0] eq 'i') {
			$fileint = $barisnama[1];
			$statusada[0]=1;
		}
		elsif ($barisnama[0] eq 'x1') {
			$fileeks1 = $barisnama[1];
			$statusada[1]=1;
		}
		elsif ($barisnama[0] eq 'x2') {
			$fileeks2 = $barisnama[1];
			$statusada[2]=1;
		}
		elsif ($barisnama[0] eq 'x3') {
			$fileeks3 = $barisnama[1];
			$statusada[3]=1;
		}
	}
}
else {
	die;
}
#$fileint='HOLDING_DATA_140408SAMPLE.csv';
#$fileeks1='bal20140408 SAMPLE.txt';
#$fileeks2='BNI SUB-REGISTRY20140410141235_HL_TABSAMPLE.txt';
#$fileeks3='MT535 Sample 1.txt';

$ijmlbaris = 0;
$e1jmlbaris = 0;
$e2jmlbaris = 0;
$e3jmlbaris = 0;

$jmcbest = 0;
$jmbis4 = 0;
$jmeuro = 0;

################################## Baca File INTERNAL ##################################
$filepathi = './uploadreg/' . $fileint;
open(INFO, $filepathi) or die("Could not open  file.");
$linecount = 0; 
$linemulaidata = 0;
$statusline = 0;
$i = 0;
$gg = 0;
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
		$amountku = $barisdata[5];
		$amountku =~ s/^\s+|\s+$//g;
		$adep = $barisdata[7];
		$adep =~ s/^\s+|\s+$//g;
		if (($amountku > 0) && ($adep ne 'VAULT')) {
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
			$iamnt[$i] = $iamnt[$i] * 1;
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
		$gg++;
	}
}
close(INFO);
if ($i > 0) {
	$ijmlbaris = $i-1;
}

################################### Baca File EKSTERNAL 1 (CBEST) ###################################
if ($statusada[1] == 1) {
$filepathe1 = './uploadreg/' . $fileeks1;
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
		$amountku = $barisdata[1];
		$amountku =~ s/^\s+|\s+$//g;
		if ($amountku != 0) {
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

}
close(INFO);
if ($i > 0) {
	$e1jmlbaris = $i-1;
}
}
################################### Baca File EKSTERNAL 2 (BSI4) ####################################
if ($statusada[2] == 1) {
$filepathe2 = './uploadreg/' . $fileeks2;
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
if ($i > 0) {
	$e2jmlbaris = $i-1;
}
}

################################## Baca File EKSTERNAL 3 (EUROCLEAR) ##################################
if ($statusada[3] == 1) {
$filepathe3 = './uploadreg/' . $fileeks3;
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
	#if (index($baris, $karmo1) != -1) {
	#	@barisdata = split('97A',$baris);
	#	@datasub = split('//', $barisdata[1]);
	#	$jmldata = @datasub;
	#	$e3acc[$i] = $datasub[$jmldata-1];
	#	$e3acc[$i] =~ s/^\s+|\s+$//g;
	#	$e3statmatch[$i] = 0;
	#	$i++;
	#}
	if (index($baris, $karmo2) != -1) {
		@barisdata = split($karmo2,$baris);
		@datasub = split('ISIN', $barisdata[1]);
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
		$i++;
	}

}
close(INFO);
if ($i > 0) {
	$e3jmlbaris = $i-1;
}
}
#################################################################################
################################# PROSES MATCHING ###############################
#################################################################################

##################### PROSES MATCH #1 : Internal vs CBEST #######################
if (($statusada[0] == 1) && ($statusada[1] == 1)) {
$accumnt = 0;
$iistr = 'x';
$jmcbest = 0;
$jmlin = 0;
for (my $i = 0; $i <= $e1jmlbaris; $i++) {
	$accmnt = 0;
	$iistr = "x";
	for (my $ii = 0; $ii <= $ijmlbaris; $ii++) {
		if (($istatmatch[$ii] == 0) && ($idepos[$ii] eq 'CBEST')) {
			if (lc($e1acc[$i]) eq lc($iacc[$ii])) {
				if (lc($e1inscode[$i]) eq lc($iinscode[$ii])) {
					$accmnt = $accmnt + $iamnt[$ii];
					if ($e1amnt[$i] == $accmnt) {
						$jmcbest++;
						$e1statmatch[$i] = 9;		# MATCH
						$istatmatch[$ii] = 9;
						@iios = split('\|',$iistr);
						$iijmlos = @iios;
						if ($iijmlos > 0) {
							for ($j = 1; $j < $iijmlos; $j++) {
								$istatmatch[$iios[$j]] = 9;
							}
							$jmlin++;
						}
						else {
							$jmlin++;
						}
						$accmnt = 0;
						$iistr = 'x';
						last;
					}
					else {
						$iistr = $iistr . '|' . $ii;
					}
				}
			}
		}
	}
}
}

##################### PROSES MATCH #2 : Internal vs BIS4 #######################
if (($statusada[0] == 1) && ($statusada[2] == 1)) {
	$accmnt = 0;
	$iistr = 'x';
	$jmbis4 = 0;
	for (my $i = 0; $i <= $e2jmlbaris; $i++) {
		$iistr = 'x';
		$accmnt = 0;
		for (my $ii = 0; $ii <= $ijmlbaris; $ii++) {
			#print "$idepos[$ii]\n";
			if (($istatmatch[$ii] == 0)  && (lc($idepos[$ii]) eq lc('BIS4'))) {
				#print '@' . $e2acc[$i] . "++" . $ibs4acc[$ii] . '@' . "\n";
				if (lc($e2acc[$i]) eq lc($ibs4acc[$ii])) {
					#print $e2inscode[$i] . "--" . $iinscode[$ii] . "\n";
					if (lc($e2inscode[$i]) eq lc($iinscode[$ii])) {
						$accmnt = $accmnt + $iamnt[$ii];
						if ($e2amnt[$i] == $accmnt) {
							$jmbis4++;
							$e2statmatch[$i] = 9;		# MATCH
							$istatmatch[$ii] = 9;
							@iios = split('\|',$iistr);
							$iijmlos = @iios;
							if ($iijmlos > 0) {
								for ($j = 1; $j < $iijmlos; $j++) {
									$istatmatch[$iios[$j]] = 9;
								}
								$jmlin++;
							}
							else {
								$jmlin++;
							}
							$accmnt = 0;
							$iistr = 'x';
							last;
						}
						else {
							$iistr = $iistr . '|' . $ii;
						}
					}
					else {
						$accmnt = 0;
					}
				}
			}
		
		}
	}
}

##################### PROSES MATCH #3 : Internal vs EUROCLEAR #######################
if (($statusada[0] == 1) && ($statusada[3] == 1)) {
	$accmnt = 0;
	$iistr = 'x';
	$jmeuro = 0;
#	if ($e3jmlbaris > 0) {
		for (my $i = 0; $i <= $e3jmlbaris; $i++) {
			$accmnt = 0;
			$iistr = 'x';
			for (my $ii = 0; $ii <= $ijmlbaris; $ii++) {
				#$accmnt = 0;
				if (($istatmatch[$ii] == 0)  && (lc($idepos[$ii]) eq lc('EUROCLEAR'))) {
					if (lc($e3inscode[$i]) eq lc($iinscode[$ii])) {
						$accmnt = $accmnt + $iamnt[$ii];
						if ($e3amnt[$i] == $accmnt) {
							$jmeuro++;
							$e3statmatch[$i] = 9;		# MATCH
							$istatmatch[$ii] = 9;
							@iios = split('\|',$iistr);
							$iijmlos = @iios;
							if ($iijmlos > 0) {
								for ($j = 1; $j < $iijmlos; $j++) {
									$istatmatch[$iios[$j]] = 9;
								}
								$jmlin++;
							}
							else {
								$jmlin++; 
							}
							$accmnt = 0;
							$iistr = 'x';
							last;
						}
						else {
							$iistr = $iistr . '|' . $ii;
						}
					}
				}
			}
		}
	#}
}

$jmall = $jmcbest + $jmbis4 + $jmeuro;

$kko = 0;
for (my $ii = 0; $ii < $ijmlbaris; $ii++) {
	if ($istatmatch[$ii] == 0) {
		$kko++;
	}
}


############################################################################################
###################################### WRITING OUTPUT ######################################
############################################################################################

my $find = "/";
my $replace = "_";
$find = quotemeta $find; # escape regex metachars if present
$mytgl =~ s/$find/$replace/g;

##################### CREATE FILE : INTERNAL - All Matches (status=9) ######################

my $existingdir = './OUTPUT/regular';
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


##################### CREATE FILE : INTERNAL - All NOT Matches (status=0 or 1) ######################

$existingdir = './OUTPUT/regular';
mkdir $existingdir unless -d $existingdir; # Check if dir exists. If not create it.
# Use the open() function to create the file.
$filename = $mytgl . '_internal_nomatch.txt';
$file = $existingdir . '/' . $filename;
unless(open FILE, '>'.$file) {
	# Die with error message 
	# if we can't open it.
	die "nUnable to create $filen";
}
$ccc = 0;
for (my $k = 0; $k < $ijmlbaris; $k++) {
	#if (($istatmatch[$k] < 9) && ($idepos[$k] ne 'VAULT') && ($iamnt[$k] != 0)) {
	if (($istatmatch[$k] == 0)) {
		print FILE $itgl[$k] . '|' . $iaccname[$k] . '|' . $icliname[$k] . '|' . $iinscode[$k] . 
			'|' . $idepos[$k] . '|' . $iamnt[$k] . '|' . $iacc[$k] . '|' . $ibs4acc[$k] . '|' .
			$ieuroacc[$k] . "\n";
		$ccc++;
	}
}
close FILE;
#####################################################################################################

##################### CREATE FILE : CBEST - All NOT Matches (status=0 or 1) ######################

$existingdir = './OUTPUT/regular';
mkdir $existingdir unless -d $existingdir; # Check if dir exists. If not create it.
# Use the open() function to create the file.
$filename = $mytgl . '_cbest_nomatch.txt';
$file = $existingdir . '/' . $filename;
unless(open FILE, '>'.$file) {
	# Die with error message 
	# if we can't open it.
	die "nUnable to create $filen";
}
$umcbest=0;
for ($k = 0; $k < $e1jmlbaris; $k++) {
	if ($e1statmatch[$k] < 9) {
		$umcbest++;
		print FILE $e1acc[$k] . '|' . $e1amnt[$k] . '|' . $e1inscode[$k] . "\n";
	}
}
close FILE;
#####################################################################################################

##################### CREATE FILE : BIS4 - All NOT Matches (status=0 or 1) ######################

$existingdir = './OUTPUT/regular';
mkdir $existingdir unless -d $existingdir; # Check if dir exists. If not create it.
# Use the open() function to create the file.
$filename = $mytgl . '_bis4_nomatch.txt';
$file = $existingdir . '/' . $filename;
unless(open FILE, '>'.$file) {
	# Die with error message 
	# if we can't open it.
	die "nUnable to create $filen";
}
$umbis4 = 0;
for ($k = 0; $k < $e2jmlbaris; $k++) {
	if ($e2statmatch[$k] < 9) {
		$umbis4++;
		print FILE $e2tgl[$k] . '|' . $e2inscode[$k] . '|' . $e2acc[$k] . '|' . 
		$e2nama[$k] . '|' . $e2amnt[$k] . "\n";
	}
}
close FILE;
#####################################################################################################

##################### CREATE FILE : EUROCLEAR - All NOT Matches (status=0 or 1) ######################

$existingdir = './OUTPUT/regular';
mkdir $existingdir unless -d $existingdir; # Check if dir exists. If not create it.
# Use the open() function to create the file.
$filename = $mytgl . '_euroclear_nomatch.txt';
$file = $existingdir . '/' . $filename;
unless(open FILE, '>'.$file) {
	# Die with error message 
	# if we can't open it.
	die "nUnable to create $filen";
}
$umeuro = 0;
for ($k = 0; $k < $e3jmlbaris; $k++) {
	if ($e3statmatch[$k] < 9) {
		$umeuro++;
		print FILE $e3acc[$k] . '|' . $e3inscode[$k] . '|' . $e3amnt[$k] . "\n";
	}
}
close FILE;
#####################################################################################################

############################################################################################
###################################### WRITING SUMMARY #####################################
############################################################################################


print "<span style=" . '"font-weight: bold; font-family: Arial;"' . "><h3><big>Reconciliation Summary:</big></h3></span></pre>" . "\n";
#print "<ul></ul>" . "\n";
print "Jumlah data INTRL &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;   >> NO MATCH : &nbsp;" . $ccc . "/" . $ijmlbaris . "<br>\n";
#print "Jumlah data CBEST &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;   >> NO MATCH : &nbsp;" . ($e1jmlbaris-$jmcbest) . "/" . $e1jmlbaris . "<br>\n";
print "Jumlah data CBEST &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;   >> NO MATCH : &nbsp;" . ($umcbest) . "/" . $e1jmlbaris . "<br>\n";
#print "Jumlah data BIS4 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;    >> NO MATCH : &nbsp;" . ($e2jmlbaris-$jmbis4) . "/" . $e2jmlbaris . "<br>\n";
print "Jumlah data BIS4 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;    >> NO MATCH : &nbsp;" . ($umbis4) . "/" . $e2jmlbaris . "<br>\n";
#print "Jumlah data EUROCLR >> NO MATCH : &nbsp;" . ($e3jmlbaris + 1 -$jmeuro) . "/" . $e3jmlbaris . "<br>\n";
print "Jumlah data EUROCLR >> NO MATCH : &nbsp;" . ($umeuro) . "/" . $e3jmlbaris . "<br>\n";



