<?php

session_start();
$con=mysqli_connect("localhost","root","","kabaddi");

$id=$_POST['id2'];

$q = "select * from team where tid= '$id'";

$result = mysqli_query($con,$q);
$num=mysqli_num_rows($result);
if($num==1){
   $reg= "delete from team where tid= '$id';";
   mysqli_query($con,$reg);
   echo "deletion successfull";
}
else{
  echo "Team id not present";
}

?>
