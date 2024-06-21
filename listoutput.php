<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<div style="text-align: center;"><br>
<span style="font-weight: bold; font-family: Arial;"><h2><big>Output List:</big></h2></span>
</div>
<br><br>
<?php
session_start();

$uname=$_SESSION["username"];
$pwd=$_SESSION["passwd"];

mysql_connect("localhost",'myuser','userku');
mysql_connect("localhost",$uname,$pwd);

if (!@ mysql_select_db("mysql"))  {
print "<big>Anda tidak bisa koneksi ke database! Periksa username/password anda.</big>"; 
print "<br><br><br>\n";
print '<br><br><input name="Button" type="Button" onClick="javascript:history.back();return false" value="KEMBALI">&nbsp;&nbsp;&nbsp;' . "\n";

die();
}
#mysql_connect("localhost",$uname,$pwd);
# query the users table for name and surname 
$query = "SELECT * FROM user WHERE User='" . $uname . "' AND Password=PASSWORD('" . $pwd . "');";

# perform the query 
$result = mysql_query($query);
$num = mysql_numrows($result);
# fetch the data from the database 

$now = time(); // Checking the time now when home page starts.

if ($now > $_SESSION['expire']) {
    session_destroy();
    $_SESSION['statuslogin'] = 8;
?>
<meta http-equiv="refresh" content="0; url=login.php" />
<?php
}

if ($num > 0) {
	$_SESSION['statuslogin'] = 0;
?>
  <meta content="text/html; charset=ISO-8859-1" http-equiv="content-type">
<?php
}
else  {
	$_SESSION['statuslogin'] = 8;
?>
<meta http-equiv="refresh" content="0; url=login.php" />
<?php
}
?>

<head>
  <meta content="text/html; charset=ISO-8859-1"
 http-equiv="content-type">
  <title>Rekonsiliasi Aktivitas Custody</title>
</head>
<body>
<form action="movenonmove.php" method="post" enctype="multipart/form-data" name="form0" id="form0">
<table
 style="width: 700px; text-align: left; margin-left: auto; margin-right: auto;"
 border="0" cellpadding="0" cellspacing="0">
  <tbody>
	<tr>
      <td style="width: 330px; height: 40px;">
		&nbsp;<span style="font-weight: bold; font-family: Arial;"><input type="submit" name="mainmenu" value=" << Menu Utama"></span></td>
      <td style="width: 40px; height: 40px;"></td>
      <td style="width: 330px; height: 40px;">
		&nbsp;<span style="font-weight: bold; font-family: Arial;"></span></td></td>
    </tr>
  </tbody>
</table>
</form>

<ul><?php //echo $thelist; ?></ul>

<?php

/** 
 * Change the path to your folder. 
 * 
 * This must be the full path from the root of your 
 * web space. If you're not sure what it is, ask your host. 
 * 
 * Name this file index.php and place in the directory. 
 */ 
 
 	$regul[0] = "-"; 
	$regul[1] = "-";
	$regul[2] = "-"; 
	$regul[3] = "-"; 
	$regul[4] = "-"; 
	$regul[5] = "-"; 

	$movem[0] = "-"; 
	$movem[1] = "-";
	$movem[2] = "-"; 
	$movem[3] = "-"; 
	$movem[4] = "-"; 
	$movem[5] = "-"; 

    // Define the full path to REGULAR files 
    $path1 = "C:/wamp/www/reconcile/OUTPUT/regular"; 

    // Open the folder 
    $dir_handle = @opendir($path1) or die("Unable to open $path"); 

    // Loop through the files
	$i = 0;
    while ($file1 = readdir($dir_handle)) { 
			$file1 = trim($file1," ");
			if (($file1 != "." || $file1 != "..") && (strlen($file1) > 5)) {
				$regul[$i] = "<a href=downloadreg.php?download_file=" . $file1 . ">" . $file1 . "</a><br/>"; 
				$i++;
			}
    }
	closedir($dir_handle); 
	$jmli = $i;
	
    // Define the full path to MOVEMENT files 
    $path2 = "C:/wamp/www/reconcile/OUTPUT/movement"; 

    // Open the folder 
    $dir_handle = @opendir($path2) or die("Unable to open $path"); 

    // Loop through the files
	$ii = 0;
    while ($file2 = readdir($dir_handle)) { 
			if ($file2 != "." && $file2 != "..") {
				$movem[$ii] = "<a href=downloadmov.php?download_file=" . $file2 . ">" . $file2 . "</a><br/>"; 
				$ii++;
			}
    }
	closedir($dir_handle); 	
	$jmlii = $ii;
	
	if ($jmli >= $jmlii) {
		$jmax = $jmli;
	}
	else {
		$jmax = $jmlii;
	}

	
?> 

<table
 style="width: 680px; height: 60px; text-align: left; margin-left: auto; margin-right: auto;"
 border="1" cellpadding="4" cellspacing="0">
  <tbody>
    <tr>
      <td style="width: 340px; text-align: center;">Regular</td>
      <td style="width: 340px; text-align: center;">Movement</td>
    </tr>
<?php
	for ($k=0; $k <= $jmax; $k++) {
?>
    <tr>
      <td><?php print "$regul[$k]"; ?></td>
      <td><?php print "$movem[$k]"; ?></td>
    </tr>
<?php
	}
?>
  </tbody>
</table>


</body>
</html>