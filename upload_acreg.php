<html>

<?php

ini_set('max_execution_time', 6000); //300 seconds = 5 minutes

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
/*
if (isset($_SESSION['expire'])) {
	if ($now > $_SESSION['expire']) {
		session_destroy();
		$_SESSION['statuslogin'] = 8;
?>
<meta http-equiv="refresh" content="0; url=login.php" />
<?php
	}
}
*/
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
  <meta
 content="text/html; charset=ISO-8859-1"
 http-equiv="content-type">
  <title></title>
<link rel="stylesheet" href="css/style.css">
</head>

<body>

<div style="text-align: center;">
<br>
<span style="font-weight: bold; font-family: Arial Narrow;"><h2><big>Proses Rekonsiliasi</big></h2></span>
<br><br>
</div>
<form action="movenonmove.php" method="post" enctype="multipart/form-data" name="form0" id="form0">
<span style="font-weight: bold; font-family: Arial;"><input type="submit" name="mainmenu" value=" << Menu Utama"></span></td>
</form>

<span style="font-weight: bold; font-family: Arial Narrow;"><h3><big>Status Uploading Files</big></h3></span></pre>



<?php
array_map('unlink', glob("./uploadreg/*"));
array_map('unlink', glob("./OUTPUT/regular/*"));

$waktumulai = time();
// Check apakah file yg berisi list file sudah ada atau belum

$filename = 'daftar0.txt';

if (file_exists($filename)) {
    //echo "File daftar0 exists. It will be replaced\n";
	//unlink($filename);
	//die();
} 
else {
    echo "Processing";
}

// Bikin file daftar.txt

$handle = fopen($filename, 'w') or die('Cannot open file:  '.$filename);
?>


<br>
<?php

if (($_FILES["fileku"]["size"][0] < 10000000) && ($_FILES["fileku"]["size"][1] < 10000000) && ($_FILES["fileku"]["size"][2] < 10000000))
  {
  if ($_FILES["fileku"]["error"][0] > 0)
    {
		echo "Return Code: " . $_FILES["fileku"]["error"][0] . "<br />";
    }
  else
    {
		echo "Upload FileInt: " . $_FILES["fileku"]["name"][0] . "&nbsp;&nbsp;&nbsp;&nbsp;";
		echo "Type: " . $_FILES["fileku"]["type"][0] . "&nbsp;&nbsp;&nbsp;&nbsp;";
		echo "Size: " . ($_FILES["fileku"]["size"][0] / 1024) . " Kb<br />";
		//echo "Temp file: " . $_FILES["fileku"]["tmp_name"][0] . "<br />";

		if (file_exists("./uploadreg/" . $_FILES["fileku"]["name"][0]))
		{
			echo $_FILES["fileku"]["name"][0] . " already exists. <br>";
		}
		else
		{
			move_uploaded_file($_FILES["fileku"]["tmp_name"][0],
			"./uploadreg/" . $_FILES["fileku"]["name"][0]);
			//echo "Stored in: " . "./uploadreg/" . $_FILES["fileku"]["name"][0];
		}
		$fileint = $_FILES["fileku"]["name"][0];
		$data = 'i|' . $fileint . "\n";
		fwrite($handle, $data);
    }
  if ($_FILES["fileku"]["error"][1] > 0)
    {
		echo "Return Code: " . $_FILES["fileku"]["error"][1] . "<br />";
    }
  else
    {
		echo "Upload FileExt1: " . $_FILES["fileku"]["name"][1] . "&nbsp;&nbsp;&nbsp;&nbsp;";
		echo "Type: " . $_FILES["fileku"]["type"][1] . "&nbsp;&nbsp;&nbsp;&nbsp;";
		echo "Size: " . ($_FILES["fileku"]["size"][1] / 1024) . " Kb<br />";
		//echo "Temp file: " . $_FILES["fileku"]["tmp_name"][1] . "<br />";

		if (file_exists("./uploadreg/" . $_FILES["fileku"]["name"][1]))
		{
			echo $_FILES["fileku"]["name"][1] . " already exists. <br>";
		}
		else
		{
			move_uploaded_file($_FILES["fileku"]["tmp_name"][1],
			"./uploadreg/" . $_FILES["fileku"]["name"][1]);
			//echo "Stored in: " . "./uploadreg/" . $_FILES["fileku"]["name"][1];
		}
		$fileeks1 = $_FILES["fileku"]["name"][1];
		$data = 'x1|' . $fileeks1 . "\n";
		fwrite($handle, $data);		
    }	
  if ($_FILES["fileku"]["error"][2] > 0)
    {
		echo "Return Code: " . $_FILES["fileku"]["error"][2] . "<br />";
    }
  else
    {
		echo "Upload FileExt2: " . $_FILES["fileku"]["name"][2] . "&nbsp;&nbsp;&nbsp;&nbsp;";
		echo "Type: " . $_FILES["fileku"]["type"][2] . "&nbsp;&nbsp;&nbsp;&nbsp;";
		echo "Size: " . ($_FILES["fileku"]["size"][2] / 1024) . " Kb<br />";
		//echo "Temp file: " . $_FILES["fileku"]["tmp_name"][2] . "<br />";

		if (file_exists("./uploadreg/" . $_FILES["fileku"]["name"][2]))
		{
			echo $_FILES["fileku"]["name"][2] . " already exists. <br>";
		}
		else
		{
			move_uploaded_file($_FILES["fileku"]["tmp_name"][2],
			"./uploadreg/" . $_FILES["fileku"]["name"][2]);
			//echo "Stored in: " . "./uploadreg/" . $_FILES["fileku"]["name"][2];
		}
		$fileeks2 = $_FILES["fileku"]["name"][2];
		$data = 'x2|' . $fileeks2 . "\n";
		fwrite($handle, $data);		
		
    }	
  if ($_FILES["fileku"]["error"][3] > 0)
    {
		echo "Return Code: " . $_FILES["fileku"]["error"][3] . "<br />";
    }
  else
    {
		echo "Upload FileExt3: " . $_FILES["fileku"]["name"][3] . "&nbsp;&nbsp;&nbsp;&nbsp;";
		echo "Type: " . $_FILES["fileku"]["type"][3] . "&nbsp;&nbsp;&nbsp;&nbsp;";
		echo "Size: " . ($_FILES["fileku"]["size"][3] / 1024) . " Kb<br />";
		//echo "Temp file: " . $_FILES["fileku"]["tmp_name"][3] . "<br />";

		if (file_exists("./uploadreg/" . $_FILES["fileku"]["name"][3]))
		{
			echo $_FILES["fileku"]["name"][3] . " already exists. <br>";
		}
		else
		{
			move_uploaded_file($_FILES["fileku"]["tmp_name"][3],
			"./uploadreg/" . $_FILES["fileku"]["name"][3]);
			//echo "Stored in: " . "./uploadreg/" . $_FILES["fileku"]["name"][3];
		}
		$fileeks3 = $_FILES["fileku"]["name"][3];
		$data = 'x3|' . $fileeks3 . "\n";
		fwrite($handle, $data);		
		
    }
	fclose($handle);
  }
else
  {
  echo "Invalid file";
  echo "Error: " . $_FILES["file"]["error"][0] . "<br>";
  }

mysql_connect("localhost",$uname,$pwd);
if (!@ mysql_select_db("reconcile"))  {
print "<big>Anda tidak bisa koneksi ke database! Periksa username/password anda.</big>"; 
print "<br><br><br>\n";
print '<br><br><input name="Button" type="Button" onClick="javascript:history.back();return false" value="KEMBALI">&nbsp;&nbsp;&nbsp;' . "\n";

die();
}
 
  $sql = "DELETE FROM myfilemove;";
  #$sql = "truncate myfilemove;";
  $result = mysql_query($sql); 
  #$num = mysql_numrows($result);
 
# query the users table for name and surname 
	#$query = "INSERT INTO myfilereg (internal1, ekstern1, ekstern2, ekstern3) VALUES('" . $fileint . "','" . $fileeks1;
	#$query = $query . "','" . $fileeks2 . "','" . $fileeks3 . "');"; 

# perform the query 
	#$result = mysql_query($query);  
  
?>



<?php
//$result = shell_exec('perl "C:\\wamp\\www\\reconcile\\helloworld.pl"');
//$result = shell_exec('perl "C:\wamp\www\reconcile\helloworld.pl"');
$result = shell_exec('perl.exe "C:\wamp\www\reconcile\reconcilereg.pl"');
//$result = system('perl -e "C:/wamp/www/reconcile/helloworld.pl"');
//$result = exec('perl -e "C:\\wamp\\www\\reconcile\\helloworld.pl"');
echo "<pre>$result</pre>";

$waktuselesai = time();

$interval = date("H:i:s", $waktuselesai-$waktumulai);

echo  '<br> Waktu Proses Rekonsiliasi : '. $interval . '<br>';

// Hapus file daftar.txt
if (file_exists($filename)) {
	//unlink($filename);
} 

print "<br>";
print "<span style=" . '"font-weight: bold; font-family: Arial;"' . "><h3><big>Daftar Output (files):</big></h3></span>" . "\n";


//exec ("php matchreg.php");

/** 
 * Change the path to your folder. 
 * 
 * This must be the full path from the root of your 
 * web space. If you're not sure what it is, ask your host. 
 * 
 * Name this file index.php and place in the directory. 
 */ 

    // Define the full path to your folder from root 
    $path = "C:/wamp/www/reconcile/OUTPUT/regular/"; 
	//$path = "./OUTPUT/"; 

    // Open the folder 
    $dir_handle = @opendir($path) or die("Unable to open $path"); 

    // Loop through the files 
    while ($file = readdir($dir_handle)) { 
			//print "<a href=download.php?download_file='" . $path . $file . "'>" . $file . "</a><br/>"; 
			if ($file != "." && $file != "..")
				print "<a href=downloadreg.php?download_file=" . $file . " target=_blank>" . $file . "</a><br/>"; 
    }
	closedir($dir_handle); 

?> 
</body>
</html>