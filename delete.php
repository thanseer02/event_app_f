<?php
include 'connect.php';
$id=$_POST['id'];
$sql=mysqli_query($con,"DELETE from event where id='$id'");
if($sql)
{
    $myarray['result']='Success.........';   
}
else
{
    $myarray['result']='Faild.........';
}
echo json_encode($myarray);
?>