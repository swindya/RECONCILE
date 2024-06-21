<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html; charset=ISO-8859-1"
 http-equiv="content-type">
  <title>mainform</title>
</head>
<body>
<form action="daftarframe.php" method="POST"> 
<!- <form action="daftarframe.php?frameno=<?php echo $jmlf ?> " method="post"> 
<br>
<div style="text-align: center;"><big><big style="font-weight: bold;"><big>Jumlah
Frame</big></big></big><br>
<br>
<br>
<br>
<br>
<?php

$uname=$_POST["username"];
$pwd=$_POST["passwd"];

$uname="myroot";
$pwd="adminku";

mysql_connect("localhost",$uname,$pwd);

if (!@ mysql_select_db("reconcile"))  {
print "<big>Anda tidak bisa koneksi ke database! Periksa username/password anda.</big>"; 
print "<br><br><br>\n";
print '<br><br><input name="Button" type="Button" onClick="javascript:history.back();return false" value="KEMBALI">&nbsp;&nbsp;&nbsp;' . "\n";

die();
}
# query the users table for name and surname 
$query = "SELECT * FROM acc;";

# perform the query 
$result=mysql_query($query);
$num=mysql_numrows($result);
# fetch the data from the database 
$i=0;
$jmlf=0;
while ($i < $num) {
$jmlf = mysql_result($result,$i,"accno");
print $jmlf;
print "<BR>";
$j=$i+1;
++$i;
}
?>

<div style="text-align: center;">
<input size="20" name="jmlframe" value="<?php echo $jmlf; ?>" align="right" maxlength=20> &nbsp; frame<br>
<br>
<br>
<br>
<input name="next" value=" Next >>" type="submit"><br>
<input name="loguser" value="<?php print "$uname"; ?>" type="hidden"><br>
<input name="logpwd" value="<?php print "$pwd"; ?>" type="hidden"><br>
</div>
</div>
</form>
</body>
</html>
