<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<?php
	session_start();
	if(isset($_SESSION['statuslogin'])) {
		$statuslogin = $_SESSION['statuslogin'];
	}
?>
<html>
<head>
<?php

if (!isset($_POST["username"])) {
	$uname=$_SESSION["username"];
}
else
	$uname=$_POST["username"];
if (!isset($_POST["passwd"])) {
	$pwd=$_SESSION["passwd"];
}
else
	$pwd=$_POST["passwd"];


//mysql_connect("localhost","myuser","userku");
mysql_connect("localhost",$uname,$pwd);

if (!@ mysql_select_db("mysql"))  {
print "<big>Anda tidak bisa koneksi ke database! Periksa username/password anda.</big>"; 
print "<br><br><br>\n";
?>
<meta http-equiv="refresh" content="0; url=login.php" />
<?php
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

if (isset($_SESSION['expire'])) {
	if ($now > $_SESSION['expire']) {
		//$_SESSION['statuslogin'] = 8;
		//session_destroy();
?>
<meta http-equiv="refresh" content="0; url=login.php" />
<?php
	}
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
  <title>movenonmove</title>
  <link href='multi-line-button.css' rel='stylesheet' />
</head>

<?php
if ($num > 0) {
?>

<body>

<div style="text-align: center;">
<big style="font-weight: bold; font-family: Arial;"><font
 size="+7">Menu Utama</font><br>
<br><br><br>
</big>

<br>

<br>
<br>
<br>
<br>

<table
 style="width: 600px; text-align: left; margin-left: auto; margin-right: auto;"
 border="1" cellpadding="2" cellspacing="2">
  <tbody>
    <tr>
      <td style="width: 300px; text-align: center;">
	  <br>     
	  <a button  class='multi-line-button' href='uploadreg.php' style='width:14em'>
        <span class='title'>Reguler</span>
        <span class='subtitle'>rekonsiliasi data 'Non Movement'</span>
	  </a>
      </td>
      <td style="width: 300px; text-align: center;">
	  	  <br>     
	  <a button  class='multi-line-button' href='uploadmov.php' style='width:14em'>
        <span class='title'>Movement</span>
        <span class='subtitle'>rekonsiliasi data 'Movement'</span>
	  </a>
	  </td>
    </tr>
  </tbody>
</table>
<big style="font-weight: bold; font-family: Arial;"><br>
</big><big style="font-weight: bold; font-family: Arial;"><small><span
 style="font-weight: bold;"></span></small></big><br>
</div>

<a button  class='multi-line-button' href='listoutput.php' style='color:yellow;width:14em'>
<span class='title'>View Last Output</span>
<span class='subtitle'>Reguler & Movement</span>
</a>

<?php
}
	$_SESSION['username'] = $uname;
	$_SESSION['passwd'] = $pwd;
	$_SESSION['start'] = time(); // Taking now logged in time.
	//$_SESSION['statuslogin'] = 8;
?>
</body>
</html>

<style type="text/css">
button2, a.button {
border: 1px solid rgba(0,0,0,0.3);
background: #eee;
color: #515151;
display: inline-block;
font-size: 24px;
font-weight: 700;
padding: 21px 34px;
position: relative;
text-decoration: none;
background: -webkit-gradient(linear, left bottom, left top, color-stop(0.21, rgb(203,203,203)), color-stop(0.58, rgb(227,226,226)));
background: -moz-linear-gradient(center bottom, rgb(203,203,203) 21%, rgb(227,226,226) 58%);
-moz-border-radius: 5px;
-webkit-border-radius: 5px;
border-radius: 5px;
-moz-box-shadow: 0 0 0 5px rgba(255,255,255,0.3) /* glass edge */, inset 0 1px 0 0 rgba(255,255,255,0.5) /* top highlight */, inset 0 -3px 0 0 rgba(0,0,0,0.5) /* bottom shadow */;
-webkit-box-shadow: 0 0 0 5px rgba(255,255,255,0.3), inset 0 1px 0 0 rgba(255,255,255,0.5), inset 0 -3px 0 0 rgba(0,0,0,0.5);
box-shadow: 0 0 0 5px rgba(255,255,255,0.3), inset 0 1px 0 0 rgba(255,255,255,0.5), inset 0 -3px 0 0 rgba(0,0,0,0.5);
text-shadow: 0 1px rgba(255,255,255,0.6);
}
button2::-moz-focus-inner, a.button2::-moz-focus-inner {
padding:0;
border:0;
}
button2:hover, a.button:hover {
background: #cbcbcb;
cursor: pointer;
}
button2:active, a.button:active {
background: #ccc;
padding: 22px 34px 20px; /* Bump down text–Thanks to Jason for the suggestion */
-moz-box-shadow: 0 0 0 5px rgba(255,255,255,0.3), inset 0 -1px 0 0 rgba(255,255,255,0.5), inset 0 2px 5px 0 rgba(0,0,0,0.2);
-webkit-box-shadow: 0 0 0 5px rgba(255,255,255,0.3), inset 0 -1px 0 0 rgba(255,255,255,0.5), inset 0 2px 5px 0 rgba(0,0,0,0.2);
box-shadow: 0 0 0 5px rgba(255,255,255,0.3), inset 0 -1px 0 0 rgba(255,255,255,0.5), inset 0 2px 5px 0 rgba(0,0,0,0.2);
text-shadow: none;
}
button2[disabled] {
background: #ddd;
color: #ccc;
cursor: default;
-moz-box-shadow: 0 0 0 5px rgba(255,255,255,0.2), inset 0 -1px 0 0 rgba(0,0,0,0.5);
-webkit-box-shadow: 0 0 0 5px rgba(255,255,255,0.2), inset 0 -1px 0 0 rgba(0,0,0,0.5);
box-shadow: 0 0 0 5px rgba(255,255,255,0.2), inset 0 -1px 0 0 rgba(0,0,0,0.5);
text-shadow: none;
}
button2[disabled]:active {
background: #ddd;
color: #ccc;
}
.red {
background: #e1001a;
color: #fff;
background: -webkit-gradient(linear, left bottom, left top, color-stop(0.21, rgb(192,0,22)), color-stop(0.58, rgb(226,0,26)));
background: -moz-linear-gradient(center bottom, rgb(192,0,22) 21%, rgb(226,0,26) 58%);
text-shadow: 0 1px rgba(0,0,0,0.25);
}
.red:hover {
background: #cb0018;
text-shadow: 0 1px rgba(0,0,0,0);
}
.red:active {
background: #ae0014;
}
a.smaller {
font-size: 12px;
margin: 18px 0px;
padding: 10px 14px;
}
a.smaller:active {
padding: 11px 14px 9px;
}	
</style>