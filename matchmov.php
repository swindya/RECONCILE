<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html; charset=ISO-8859-1"
 http-equiv="content-type">
  <title>Rekonsiliasi Aktivitas Custody</title>
</head>
<body>
<?php
 
// for Windows
//$result = shell_exec('perl "C:/wamp/www/reconcile/reconcile.pl"');
//echo "<pre>$result</pre>";

//$result = shell_exec('cmd');
$result = shell_exec('perl "C:/wamp/www/reconcile/reconcilemov.pl"');
//$result = system('perl -e "C:/wamp/www/reconcile/helloworld.pl"');
echo "<pre>$result</pre>";
?>

<?php
//  if ($handle = opendir('C:/wamp/www/reconcile/OUTPUT')) {
//    while (false !== ($file = readdir($handle))) {
//      if ($file != "." && $file != "..") {
//        $thelist .= '<li><a href="'.$file.'">'.$file.'</a></li>';
//      }
//    }
//    closedir($handle);
//  }
?>
<span style="font-weight: bold; font-family: Arial;"><h2><big>List of files:</big></h2></span>
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

    // Define the full path to your folder from root 
    $path = "C:/wamp/www/reconcile/OUTPUT/movement"; 
	//$path = "./OUTPUT/"; 

    // Open the folder 
    $dir_handle = @opendir($path) or die("Unable to open $path"); 

    // Loop through the files 
    while ($file = readdir($dir_handle)) { 
			//print "<a href=download.php?download_file='" . $path . $file . "'>" . $file . "</a><br/>"; 
			if ($file != "." && $file != "..")
				print "<a href=downloadreg.php?download_file=" . $file . ">" . $file . "</a><br/>"; 
    }
	closedir($dir_handle); 

?> 

</body>
</html>
