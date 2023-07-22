<?php
include 'connect.php';
// $id=$_POST['id'];
// $sql=mysqli_query($con,"SELECT * from event where id=$id");
$sql=mysqli_query($con,"SELECT * from event ");

$list=array();
if($sql->num_rows>0)
{
    while($row=mysqli_fetch_assoc($sql))
    {
        $myarray['result']='success';
        $myarray['id']=$row['id'];
        $myarray['action']=$row['action'];
        $myarray['time']=$row['time'];
        array_push($list,$myarray);

    }
}
else
{
    $myarray['result']='faild';
    array_push($list,$myarray);
}
echo json_encode($list);
?>