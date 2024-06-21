<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
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
  <meta
 content="text/html; charset=ISO-8859-1"
 http-equiv="content-type">
  <title></title>
  
<script>
function checkIt()
{
	if ((document.form1.fileku[0].value.length<4) && ((document.form1.fileku[1].value.length<4) || (document.form1.fileku[2].value.length<4)) 
	{
		alert("Masukkan nama file....");
		//document.form1.fileku.focus();
		return false;
	}
	else
	{
		return true;
	}
}
</script>
</head>


<body>
<div style="text-align: center;"><br><br>
<big
 style="font-weight: bold; font-family: Arial;">Masukkan
File Movement<br>
<br><br><br>
</big>
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
<br>
<form action="upload_acmov.php" method="post" enctype="multipart/form-data" name="form1" id="form1" OnSubmit="return checkIt();">
<table
 style="width: 700px; text-align: left; margin-left: auto; margin-right: auto;"
 border="0" cellpadding="4" cellspacing="0">
  <tbody>
	<tr>
      <td style="width: 330px; height: 40px; background-color: rgb(204, 204, 255);">
		&nbsp;<span style="font-weight: bold; font-family: Arial;">Internal Data</span></td>
      <td style="width: 40px; height: 40px;"></td>
      <td style="width: 330px; height: 40px; background-color: rgb(255, 255, 204);">
		&nbsp;<span style="font-weight: bold; font-family: Arial;">Eksternal Data</span></td></td>
    </tr>

    <tr>
      <td style="width: 330px; height: 26px; background-color: rgb(204, 204, 255);">&nbsp;<input name="fileku[]" type="file" id="fileku" value="Pilih File" size="50" /></td>
      <td style="width: 40px; height: 26px;"></td>
      <td style="width: 330px; height: 26px; background-color: rgb(255, 255, 204);">&nbsp;CBEST&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input name="fileku[]" type="file" id="fileku" value="Pilih File" size="50" /></td>
    </tr>
    <tr>
      <td style="width: 330px; height: 26px; background-color: rgb(204, 204, 255);"></td>
      <td style="width: 40px;"></td>
      <td style="width: 330px; background-color: rgb(255, 255, 204);">&nbsp;EUROCL&nbsp;&nbsp;<input name="fileku[]" type="file" id="fileku" value="Pilih File" size="50" /></td>
    </tr>
    <tr>
      <td style="width: 330px; height: 26px; background-color: rgb(204, 204, 255);"></td>
      <td style="width: 40px;"></td>
      <td style="width: 330px; background-color: rgb(255, 255, 204);">&nbsp;</td>
    </tr>
    <tr>
      <td style="width: 330px;height: 10px; background-color: rgb(204, 204, 255);"></td>
      <td style="width: 40px;"></td>
      <td style="width: 330px; background-color: rgb(255, 255, 204);"></td>
    </tr>
  </tbody>
</table>
<br><br>
<div style="text-align: center;"><big
 style="font-family: Arial;"><input type="submit" class="button" name="Submit" value="Upload"  size="50"/></big><br>
</div>

</form>
<big
 style="font-weight: bold; font-family: Arial;"><br>
</big><br>
</div>
<?php
	$_SESSION['username'] = $uname;
	$_SESSION['passwd'] = $pwd;
?>
</body>
</html>

<style type="text/css">
button::-moz-focus-inner,
input[type="reset"]::-moz-focus-inner,
input[type="button"]::-moz-focus-inner,
input[type="submit"]::-moz-focus-inner,
input[type="file"] > input[type="button"]::-moz-focus-inner {
  border: none; }

.button {
  display: inline-block;
  padding: 0.5em 2em 0.55em;
  outline: none;
  cursor: pointer;
  text-align: center;
  text-decoration: none;
  -webkit-border-radius: .5em;
  -moz-border-radius: .5em;
  border-radius: .5em;
  border: solid 1px #cccccc;
  -webkit-box-shadow: 0 1px 2px rgba(0, 0, 0, 0.2);
  -moz-box-shadow: 0 1px 2px rgba(0, 0, 0, 0.2);
  box-shadow: 0 1px 2px rgba(0, 0, 0, 0.2);
  text-shadow: 0 1px 1px rgba(0, 0, 0, 0.3);
  border: solid 1px #199487;
  background-color: #1ba193;
  background: -webkit-gradient(linear, left top, left bottom, from(#25dac7), to(#1ba193));
  background: -moz-linear-gradient(top, #25dac7, #1ba193);
  filter: progid:DXImageTransform.Microsoft.gradient(startColorstr='#25dac7', endColorstr='#1ba193');
  color: #e8f5f4; }
  .button:hover {
    text-decoration: none; }
  .button:active {
    position: relative;
    top: 1px; }
  .button:hover {
    background-color: #178b7f;
    background: -webkit-gradient(linear, left top, left bottom, from(#22cdbb), to(#178b7f));
    background: -moz-linear-gradient(top, #22cdbb, #178b7f);
    filter: progid:DXImageTransform.Microsoft.gradient(startColorstr='#22cdbb', endColorstr='#178b7f'); }
  .button:active {
    background-color: #22cdbb;
    background: -webkit-gradient(linear, left top, left bottom, from(#1ba193), to(#22cdbb));
    background: -moz-linear-gradient(top, #1ba193, #22cdbb);
    filter: progid:DXImageTransform.Microsoft.gradient(startColorstr='#1ba193', endColorstr='#22cdbb');
    color: #bae2de; }
</style>
