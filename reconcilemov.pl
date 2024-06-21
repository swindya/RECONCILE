#!c:/perl64/bin/perl.exe -w

##########################################################################
########################## BACA DATA INTERNAL ############################
##########################################################################

#$file='./INPUT/HOLDING_DATA_140408SAMPLE.csv';

#use DBI;
# $dbh = DBI->connect('dbi:mysql:reconcile','myuser','userku')
#  or die "Connection Error: $DBI::errstr\n";
   
# $sql = "select * from myfilemov";
# $sth = $dbh->prepare($sql);
# $sth->execute
#   or die "SQL Error: $DBI::errstr\n";
 #$rows = $sth->rows;
# $ii = 0;

$stafile[1] = 0;
$stafile[2] = 0;
$stafile[3] = 0;
$jmlfile = 1;

#while (@row = $sth->fetchrow_array) {
#	$jmlfile = 2;
#	$fileint = $row[1];
#	$fileeks1 = $row[2];
#	$fileeks2 = $row[3];
#	$stafile[1] = 1;
#	$stafile[2] = 1;

if (-e './daftar1.txt') {
	$ia = 0;
	open FILE, "./daftar1.txt" or die $!;
	while (<FILE>) {
	$namafile = $_;
	@barisnama = split('\|', $namafile);
	if (($ia == 0) && ($barisnama[0] eq 'i')) {
		$fileint = $barisnama[1];
		$stafile[1] = 1;
	}
	if (($ia == 1) && ($barisnama[0] eq 'x1')) {
		$fileeks1 = $barisnama[1];
		$stafile[2] = 1;
	}
	if (($ia == 2) && ($barisnama[0] eq 'x2')) {
		$fileeks2 = $barisnama[1];
		$stafile[3] = 1;
	}
	$ia++;
  }
}
else {
	die;
}
 
 
$filepathi = './uploadmov/' . $fileint;
	
$filepathi =~ s/^\s+|\s+$//g;

#
#

################################## Baca File INTERNAL ##################################

use Spreadsheet::ParseExcel;

my $e = new Spreadsheet::ParseExcel;
my $eBook = $e->Parse($filepathi);

my $sheets = $eBook->{SheetCount};
my ($eSheet, $sheetName);

#foreach my $sheet (0 .. $sheets - 1) {
foreach my $sheet (0) {
    $eSheet = $eBook->{Worksheet}[$sheet];
    $sheetName = $eSheet->{Name};
    #print "Worksheet $sheet: $sheetName\n";
	$maxr = $eSheet->{MaxRow};
	$maxc = $eSheet->{MaxCol};
	$jmlr = $maxr - 1;
	$ijmlbaris = $jmlr;
	#print "Max Row: $maxr   Max Column: $maxc\n";
    next unless (exists ($eSheet->{MaxRow}) and (exists ($eSheet->{MaxCol})));
	$i = 0;
	foreach my $kolom (1) {
		$i = 0;
		for ($row=1; $row <= $maxr; $row++) {
			#$isname[$i] = $eSheet->{Cells}[$row][$kolom]->Value;
			if (!($eSheet->get_cell($row, $kolom))) {
			    $isname[$i]='';
			}
			else {
			    $cell = $eSheet->get_cell($row, $kolom);
                $abc = $cell->value();
			    $isname[$i] = $abc;
			}
			#print "$isname[$i]\n";
			$i++;
		}
	}
	foreach my $kolom (2) {
		$i = 0;
		for ($row=1; $row <= $maxr; $row++) {
			#$iorderid[$i] = $eSheet->{Cells}[$row][$kolom]->Value;
			if (!($eSheet->get_cell($row, $kolom))) {
			    $iorderid[$i]='';
			}
			else {
			    $cell = $eSheet->get_cell($row, $kolom);
                $abc = $cell->value();
			    $iorderid[$i] = $abc;
			}
			#print "$iorderid[$i]\n";
			$i++;
		}
	}
	foreach my $kolom (3) {
		$i = 0;
		for ($row=1; $row <= $maxr; $row++) {
			#$abc = $eSheet->{Cells}[$row][$kolom]->Value;
			#$abc = $ebook->[1]{A1};
			if (!($eSheet->get_cell($row, $kolom))) {
			    $isendref[$i]='';
			}
			else {
			    $cell = $eSheet->get_cell($row, $kolom);
                $abc = $cell->value();
			    $isendref[$i] = $abc;
			}
			#print "$isendref[$i]\n";
			$i++;
			
		}
	}
	foreach my $kolom (4) {
		$i = 0;
		for ($row=1; $row <= $maxr; $row++) {
			#$iordertype[$i] = $eSheet->{Cells}[$row][$kolom]->Value;
			if (!($eSheet->get_cell($row, $kolom))) {
			    $iordertype[$i]='';
			}
			else {
			    $cell = $eSheet->get_cell($row, $kolom);
                $abc = $cell->value();
			    $iordertype[$i] = $abc;
			}
			#print "$iordertype[$i]\n";
			$i++;
		}
	}
	foreach my $kolom (5) {
		$i = 0;
		for ($row=1; $row <= $maxr; $row++) {
			#$iaccdepo[$i] = $eSheet->{Cells}[$row][$kolom]->Value;
			if (!($eSheet->get_cell($row, $kolom))) {
			    $iaccdepo[$i]='';
			}
			else {
			    $cell = $eSheet->get_cell($row, $kolom);
                $abc = $cell->value();
			    $iaccdepo[$i] = $abc;
			}
			#print "$inttgl\n";
			$i++;
		}
	}
	foreach my $kolom (6) {
		$i = 0;
		for ($row=1; $row <= $maxr; $row++) {
			#$iscode[$i] = $eSheet->{Cells}[$row][$kolom]->Value;
			if (!($eSheet->get_cell($row, $kolom))) {
			    $iscode[$i]='';
			}
			else {
			    $cell = $eSheet->get_cell($row, $kolom);
                $abc = $cell->value();
			    $iscode[$i] = $abc;
			}
			#print "$itlkm[$i]\n";
			$i++;
		}
	}
	foreach my $kolom (7) {
		$i = 0;
		for ($row=1; $row <= $maxr; $row++) {
			#$iqty[$i] = $eSheet->{Cells}[$row][$kolom]->Value;
			if (!($eSheet->get_cell($row, $kolom))) {
			    $iqty[$i]='';
			}
			else {
			    $cell = $eSheet->get_cell($row, $kolom);
                $abc = $cell->value();
			    $iqty[$i] = $abc;
			}
			$iqty[$i] =~ s/,//g; ;
			$iqty[$i] = $iqty[$i] * 1;
			#print "$iqty[$i]\n";
			$i++;
		}
	}
	foreach my $kolom (9) {
		$i = 0;
		for ($row=1; $row <= $maxr; $row++) {
			#$isetdate[$i] = $eSheet->{Cells}[$row][$kolom]->Value;
			if (!($eSheet->get_cell($row, $kolom))) {
			    $isetdate[$i]='';
			}
			else {
			    $cell = $eSheet->get_cell($row, $kolom);
                $abc = $cell->value();
			    $isetdate[$i] = $abc;
			}
			$tglku = $isetdate[$i];
			@tglmu = split('/',$tglku);
			if ($tglmu[1] < 10) {
				$tglmukuwi = '0' . $tglmu[1]; 
			}
			$isetdate[$i] = $tglmu[2] . $tglmukuwi . $tglmu[0];
			$mytgl = $isetdate[$i];
			$i++;
		}
	}
	foreach my $kolom (10) {
		$i = 0;
		for ($row=1; $row <= $maxr; $row++) {
			#$inetsac[$i] = $eSheet->{Cells}[$row][$kolom]->Value;
			if (!($eSheet->get_cell($row, $kolom))) {
			    $inetsac[$i]='';
			}
			else {
			    $cell = $eSheet->get_cell($row, $kolom);
                $abc = $cell->value();
				$abc =~ s/^\s+|\s+$//g;
			    $inetsac[$i] = $abc;
			}
			$i++;
		}
	}
	foreach my $kolom (11) {
		$i = 0;
		for ($row=1; $row <= $maxr; $row++) {
			#$inetsa[$i] = $eSheet->{Cells}[$row][$kolom]->Value;
			if (!($eSheet->get_cell($row, $kolom))) {
			    $inetsa[$i]='';
			}
			else {
			    $cell = $eSheet->get_cell($row, $kolom);
                $abc = $cell->value();
				$abc =~ tr/,//d; 
				$inetsa[$i] = $abc;
			}
			#print "$inetsa[$i]\n";
			$i++;
		}
	}
	foreach my $kolom (13) {
		$i = 0;
		for ($row=1; $row <= $maxr; $row++) {
			#$inetsa[$i] = $eSheet->{Cells}[$row][$kolom]->Value;
			if (!($eSheet->get_cell($row, $kolom))) {
			    $inetset[$i]='';
			}
			else {
			    $cell = $eSheet->get_cell($row, $kolom);
                $abc = $cell->value();
				$abc =~ tr/,//d; 
				$inetset[$i] = $abc;
			}
			#print "$inetset[$i]\n";
			$i++;
		}
	}
}
$ijmlbaris = $i;

for ($p = 0; $p <= $ijmlbaris; $p++) {
	if (($inetset[$p] eq 'VAULT') || ($inetset[$p] eq 'VAULT1')) {
		$istatmatch[$p] = 14;
		#print "-- $inetset[$p]\n";
	}
	elsif ($inetset[$p] eq 'BIS4') {
		$istatmatch[$p] = 15;
	}
	else {
		$istatmatch[$p] = 0;
		#print "++ $inetset[$p]\n";
	}
}

################################### Baca File EKSTERNAL 1 (CBEST) ###################################

if ($stafile[2] == 1) {
	$filepathe1 = './uploadmov/' . $fileeks1;
	$filepathe1 =~ s/^\s+|\s+$//g;
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
			$e1scode[$i] = $barisdata[1];
			$e1scode[$i] =~ s/^\s+|\s+$//g;
			$e1sendref[$i] = $barisdata[4];
			$e1sendref[$i] =~ s/^\s+|\s+$//g;
			$e1setdate[$i] = $barisdata[8];
			$e1setdate[$i] =~ s/^\s+|\s+$//g;
			if ($e1scode[$i] eq "IDR") {
				$e1netsac[$i] = "IDR";
				$e1netsa[$i] = $barisdata[6];
				$e1netsa[$i] =~ s/^\s+|\s+$//g;
				$e1qty[$i] = "101010";
			}
			else {
				$e1netsa[$i] = 101010;
				$e1netsac[$i] = $e1scode[$i];
				$e1qty[$i] = $barisdata[6];
				$e1qty[$i] =~ s/^\s+|\s+$//g;
			}
			$e1statmatch[$i] = 0;
			$i++;
		}

	}
	close(INFO);
	$e1jmlbaris = $i;
}
################################### Baca File EKSTERNAL 2 (EUROCLEAR) ####################################

if ($stafile[3] == 1) {
	$filepathe2 = './uploadmov/' . $fileeks2;
	$filepathe2 =~ s/^\s+|\s+$//g;
	open(INFO, $filepathe2) or die("Could not open  file.");
	$linecount = 0; 
	$i = 0;
	foreach $line (<INFO>)  {   
		$linecount += 1;
		$baris = $line;
		$charkiri = substr($line,0,1);
		#Cari 
		$kdat = '69A::STAT//';
		$ksco = '35B:ISIN';
		$ksre= '20C::RELA//';
		$kamn = '36B::PSTA//FAMT/';
		$kmua = '19A::PSTA//';
		
		# Date
		if ((index($baris, $kdat) != -1)) {
			@barisdata = split($kdat,$baris);
			@datasub = @barisdata;
			$jmldata = @datasub;
			$myval = $datasub[1];
			$myval =~ s/^\s+|\s+$//g;
			@barisku = split('|/',$myval);
			$tglkita = $barisku[0];
			$e2date[$i] = $tglkita;
		}
		# Security Code
		if (index($baris, $ksco) != -1) {
			@barisdata = split($ksco,$baris);
			@datasub = @barisdata;
			$jmldata = @datasub;
			$e2scode[$i] = $datasub[1];
			$e2scode[$i] =~ s/^\s+|\s+$//g;
		}
		# Sender Reference
		if (index($baris, $ksre) != -1) {
			@barisdata = split($ksre,$baris);
			@datasub = @barisdata;
			$jmldata = @datasub;
			$e2sendref[$i] = $datasub[1];
			$e2sendref[$i] =~ s/^\s+|\s+$//g;
			$e2statmatch[$i] = 0;
		}
		# Qty
		if ((index($baris, $kamn) != -1)) {
			@barisdata = split($kamn,$baris);
			@datasub = @barisdata;
			$jmldata = @datasub;
			$myval = $datasub[1];
			$myval =~ s/^\s+|\s+$//g;
			$lenme = length($myval);
			$myme = $lenme -1 ;
			$e2qty[$i] = substr($myval,0,$myme);
		}
		# Net Settlement Amount
		if ((index($baris, $kmua) != -1)) {
			@barisdata = split($kmua,$baris);
			@datasub = @barisdata;
			$jmldata = @datasub;
			$mystring = $datasub[1];
			$mystring =~ s/^\s+|\s+$//g;
			if (index($baris, 'NUSD') != -1) {
				$e2netsac[$i] = 'USD';
				$lenme = length($mystring);
				$duit = substr($mystring,4,$lenme);
				#print "DUIT $duit\n";
			}
			elsif (index($baris, 'USD') != -1) {
				$e2netsac[$i] = 'USD';
				$lenme = length($mystring);
				$duit = substr($mystring,3,$lenme);
			}
			@duitmu = split(',', $duit);
			$e2netsa[$i] = $duitmu[0] + ($duitmu[1] * 0.01);
			$e2date[$i] = $tglkita;
			#print "$e2netsa[$i]\n";
			$i++;
		}

	}
	close(INFO);
	$e2jmlbaris = $i;
}

#################################################################################
################################# PROSES MATCHING ###############################
#################################################################################


##################### PROSES MATCH #1 : Internal vs CBEST #######################
if (($stafile[1] == 1) && ($stafile[2] == 1)) {
	$accumnt = 0;
	$iistr = '';
	$jmcbest = 0;
	$aa = 0;
	for (my $i = 0; $i <= $ijmlbaris; $i++) {
		for (my $ii = 0; $ii <= $e1jmlbaris; $ii++) {
			$iistr = '';
			if ($e1statmatch[$ii] == 0) {
				#print "$e1sendref[$ii] *** " . "$isendref[$i]\n";
				if (lc($e1sendref[$ii]) eq lc($isendref[$i])) {
					#print "$e1sendref[$ii]\n";
					if ($e1setdate[$ii] eq $isetdate[$i]) {
						#print "$iaccdepo[$i]\n";
						if (lc($e1acc[$ii]) eq lc($iaccdepo[$i])) {
							#print "$e1acc[$ii]\n";
							if (lc($iordertype[$i]) eq lc('Delivery Versus Payment')) {
								#print "$e1scode[$ii] xxx $iscode[$i]    $e1qty[$ii] xxx  $iqty[$i]\n";
								if (((lc($e1scode[$ii]) eq lc($iscode[$i])) && ($e1qty[$ii] == $iqty[$i])) || ((lc($e1netsac[$ii]) eq lc($inetsac[$i])) && (lc($e1netsa[$ii]) == lc($inetsa[$i])))) {
									$e1statmatch[$ii] = 9;
									$istatmatch[$i] = 9;
									#print "$isendref[$i] xxx $iaccdepo[$i]\n";
									$aa++;
									last;
								}
							}
							else {
								#print "$e1scode[$ii]\n";
								if ((lc($e1scode[$ii]) eq lc($iscode[$i])) && ($e1qty[$ii] == $iqty[$i])) {
									$e1statmatch[$ii] = 9;
									$istatmatch[$i] = 9;
									#print "$aa\n";
									$aa++;
									last;
								}
							}
						}
					}
				}
			}
		}
	}
	$jmleks1 = $aa;
}

##################### PROSES MATCH #2 : Internal vs EUROCLEAR #######################
if (($stafile[1] == 1) && ($stafile[3] == 1)) {
	$accumnt = 0;
	$iistr = '';
	$jmbis4 = 0;
	$aa = 0;
	for (my $i = 0; $i <= $ijmlbaris; $i++) {
		for (my $ii = 0; $ii <= $e2jmlbaris; $ii++) {
			if (($istatmatch[$i] == 0) && ($e2statmatch[$ii] == 0)) {														
				if (lc($e2sendref[$ii]) eq lc($isendref[$i])) {							
					if (lc($e2scode[$ii]) eq lc($iscode[$i])) {
						if (lc($e2netsac[$ii]) eq lc($inetsac[$i])) {
							if (lc($e2netsa[$ii]) eq lc($inetsa[$i])) {
								if($e2qty[$ii] == $iqty[$i]) {
									#if ($e2date[$ii] eq $isetdate[$i]) {
										$istatmatch[$i] = 9;
										$e2statmatch[$ii] = 9;
										$aa++;
										last;
									#}
								}
							}
						}
					}
				}
			}
		}
		
	}
	$jmleks2 = $aa;
}

$aa = 0;
for (my $ii = 0; $ii < $ijmlbaris; $ii++) {
	if ($istatmatch[$ii] == 9) {
		$aa++;
	}
}
$ijmlku = $aa;

$aa = 0;
for (my $ii = 0; $ii < $e1jmlbaris; $ii++) {
	if ($e1statmatch[$ii] == 9) {
		$aa++;
	}
}
$e1jmlku = $aa;

$aa = 0;
for (my $ii = 0; $ii < $e2jmlbaris; $ii++) {
	if ($e2statmatch[$ii] == 9) {
		$aa++;
	}
}
#print "$e2jmlbaris  $aa\n";
$e2jmlku = $aa;



############################################################################################
###################################### WRITING OUTPUT ######################################
############################################################################################

my $find = "/";
my $replace = "_";
$find = quotemeta $find; # escape regex metachars if present
$mytgl =~ s/$find/$replace/g;

##################### CREATE FILE : INTERNAL - All Matches (status=9) ######################

my $existingdir = './OUTPUT/movement';
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
		print FILE $isname[$k] . '|' . $iorderid[$k] . '|' . $isendref[$k] . '|' . $iordertype[$k] . 
			'|' . $iaccdepo[$k] . '|' . $iscode[$k] . '|' . $iqty[$k] . '|' . $isetdate[$k] . '|' .
			$inetsac[$k] . '|' . $inetsa[$k] . "\n";
		#print "$isname[$k]\n";
	}
}
close FILE;


##################### CREATE FILE : INTERNAL - All NOT Matches (status=0 or 1) ######################

$existingdir = './OUTPUT/movement';
mkdir $existingdir unless -d $existingdir; # Check if dir exists. If not create it.
# Use the open() function to create the file.
$filename = $mytgl . '_internal_nomatch.txt';
$file = $existingdir . '/' . $filename;
unless(open FILE, '>'.$file) {
	# Die with error message 
	# if we can't open it.
	die "nUnable to create $filen";
}

$ab = 0;
for (my $k = 0; $k < $ijmlbaris; $k++) {
	if ($istatmatch[$k] == 0) {
#		print FILE $itgl[$k] . '|' . $iaccname[$k] . '|' . $icliname[$k] . '|' . $iinscode[$k] . 
#			'|' . $idepos[$k] . '|' . $iamnt[$k] . '|' . $iacc[$k] . '|' . $ibs4acc[$k] . '|' .
#			$ieuroacc[$k] . "\n";
		print FILE $isname[$k] . '|' . $iorderid[$k] . '|' . $isendref[$k] . '|' . $iordertype[$k] . 
			'|' . $iaccdepo[$k] . '|' . $iscode[$k] . '|' . $iqty[$k] . '|' . $isetdate[$k] . '|' .
			$inetsac[$k] . '|' . $inetsa[$k] . "\n";
		$ab++;
	}
}
close FILE;
$jmlab = $ab;
#####################################################################################################

##################### CREATE FILE : CBEST - All NOT Matches (status=0 or 1) ######################

if ($stafile[2] == 1) { 
	my $existingdir = './OUTPUT/movement';
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
			print FILE $e1sendref[$k] . '|' . $e1acc[$k] . '|' . $e1netsac[$k] . '|' . $e1netsa[$k] . '|' . $e1qty[$k] . '|' . $e1setdate[$k] . "\n";
		}
	}
close FILE;
}
#####################################################################################################

#####################################################################################################

##################### CREATE FILE : EUROCLEAR - All NOT Matches (status=0 or 1) ######################
if ($stafile[3] == 1) { 
	my $existingdir = './OUTPUT/movement';
	mkdir $existingdir unless -d $existingdir; # Check if dir exists. If not create it.
# Use the open() function to create the file.
	my $filename = $mytgl . '_euroclear_nomatch.txt';
	my $file = $existingdir . '/' . $filename;
	unless(open FILE, '>'.$file) {
	# Die with error message 
	# if we can't open it.
		die "nUnable to create $filen";
	}
	for (my $k = 0; $k < $e2jmlbaris; $k++) {
		if ($e2statmatch[$k] < 9) {
			print FILE $e2sendref[$k] . '|' . $e2scode[$k] . '|' . $e2netsac[$k] . '|' . $e2netsa[$k] . '|' . $e2qty[$k] . '|' . $e2date[$k] . "\n";
		}
	}
close FILE;
}
#####################################################################################################
############################################################################################
###################################### WRITING SUMMARY #####################################
############################################################################################

print "<span style=" . '"font-weight: bold; font-family: Arial Narrow;"' . "><h3><big>Reconciliation Summary of Movement:</big></h3></span></pre>" . "\n";
#print "<ul></ul>" . "\n";
print "Jumlah data INTRL   yg NO MATCH : " . $jmlab . "/" . $ijmlbaris . "<br>\n";
if (($stafile[1] == 1) && ($stafile[2] == 1)) {
	print "Jumlah data CBEST   yg NO MATCH : " . ($e1jmlbaris - $e1jmlku) . "/" . $e1jmlbaris . "<br>\n";
}
if (($stafile[1] == 1) && ($stafile[3] == 1)) {
	print "Jumlah data EUROCLR yg NO MATCH : " . ($e2jmlbaris - $e2jmlku) . "/" . $e2jmlbaris . "<br>\n";
}

$coba = '1//2//4';
@cobaku = split('//',$coba);
$fuih = @cobaku;
#print "\n $fuih\n";
#print "$cobaku[$fuih-1]";


