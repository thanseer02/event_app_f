<?php
include 'connect.php';
$action=$_POST['action'];
$time=$_POST['time'];
$sql=mysqli_query($con,"INSERT into event(action,time) values ('$action','$time')");
if($sql)
{
    $myarray['result']='success....';

}
else
{
    $myarray['result']='failed....';
}
echo json_encode($myarray);
?>