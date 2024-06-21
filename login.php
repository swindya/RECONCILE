<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<?php
session_start();

?>
<head>
  <meta content="text/html; charset=ISO-8859-1"
 http-equiv="content-type">
  <title>Rekonsiliasi Aktivitas Custody</title>
</head>
<body>
<form action="movenonmove.php" method="post"> <br>
  <br><br><br>
  <div style="text-align: center;"><span style="font-weight: bold;"><big><big>Rekonsiliasi Aktivitas Custody
</big> </big><br>
  <br>
  <img style="width: 100px; height: 32px;" alt="" src="logobni.jpg"><br>
  <br>
  <br>
  </span></div>
 <?php

	$statuslogin = 0;
	
	if(isset($_SESSION['statuslogin'])) {
		$statuslogin = $_SESSION['statuslogin'];
		if ($statuslogin == 8) {
			//session_destroy();
			$_SESSION['start'] = time();
		}
	}
	else
		$statuslogin = 0;
	if ($statuslogin == 8) {
 ?>
  <div style="text-align: center;"><small><span style="color: rgb(255, 0, 0); font-family: Arial;">
Username/password salah/invalid</span></small><br></div>
 <?php
	}
	else
	print "<br>";
 ?>
  <div style="text-align: center;">Username&nbsp;&nbsp; :&nbsp;&nbsp; <input size="20" name="username"><br>
  <br>
Password&nbsp;&nbsp; :&nbsp;&nbsp; <input size="20" name="passwd"
 type="password"><br>
  </div>
  <br>
  <br>
  <br>
  <div style="text-align: center;"><input tabindex="3"
 value="   Login   " name="login" type="submit"><br>
  </div>
  <br>
  <br>
  <br>
  <br>
  <br>
  <br>
</form>
</body>
</html>
<?php
	$_SESSION['start'] = time(); // Taking now logged in time.
            // Ending a session in 30 minutes from the starting time.
    $_SESSION['expire'] = $_SESSION['start'] + (30 * 60);
	//session_destroy();
?>