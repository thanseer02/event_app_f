<?php
include 'connect.php';
$action=$_POST['action'];
$time=$_POST['time'];
$id=$_POST['id'];
$sql=mysqli_query($con,"UPDATE event set action='$action',time='$time' where id='$id'");
if($sql)
{
    $myArray['result']='success';
}
else
{
    $myArray['result']='faild';
}
echo json_encode($myArray);
?>