<?php
header('Content-Type:application/json');

//解析用户传递来的数据
@$phone = $_REQUEST['phone'];
if(empty($phone))
{
  echo '[]';
  return;
}

//连接数据库，从数据库中的hmc_dish表中
//的$start位置读5条数据
//$conn = mysqli_connect('127.0.0.1',
//'root','','haomaiche');
//mysqli_query($conn,'set names utf8');
require("init.php");

//多表查询
$sql = "select hmc_order.user_name,hmc_dish.img_sm,hmc_order.oid,hmc_order.order_time,hmc_order.did from hmc_dish,hmc_order where hmc_order.did=hmc_dish.did and hmc_order.phone=$phone";
$result = mysqli_query($conn,$sql);

//返回给客户端
//①fetchAll ②fetch_assoc
$output=[];
while(true)
{
  $row = mysqli_fetch_assoc($result);
  if(!$row)//没有更多数据退出循环
  {
    break;
  }
  $output[] = $row;
}

echo json_encode($output);



?>