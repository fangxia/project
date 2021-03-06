<%--
  Created by IntelliJ IDEA.
  User: fangshilei
  Date: 18/1/24
  Time: 上午11:12
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include  file="basePath.jsp" %>
<!DOCTYPE html>
<html lang="zh-CN">

<head>
  <meta charset="utf-8">
  <title>WI-FI视频联动管理系统</title>
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <meta name="description" content="">
  <meta name="author" content="">
  <!-- Le styles -->



  <link rel="stylesheet" href="<%=path%>/assets/css/style.css">
  <link rel="stylesheet" href="<%=path%>/assets/css/loader-style.css">
  <link rel="stylesheet" href="<%=path%>/assets/css/bootstrap.css">
  <link rel="stylesheet" href="<%=path%>/assets/js/datepicker/datepicker.css">
  <link rel="stylesheet" href="<%=path%>/assets/js/datepicker/bootstrap-datetimepicker.css">
  <link rel="stylesheet" type="text/css" href="<%=path%>/assets/js/progress-bar/number-pb.css?version=<%=System.currentTimeMillis()%>">
<%--  <link href="<%=path%>/page/css/amazeui.flat.css?version=<%=System.currentTimeMillis()%>" rel="stylesheet">
  <link rel="stylesheet" type="text/css" href="<%=path%>/page/css/zzsc-demo.css?version=<%=System.currentTimeMillis()%>">--%>
  <link rel="stylesheet" href="<%=path%>/page/dist/css/am-pagination.css?version=<%=System.currentTimeMillis()%>">
  <style type="text/css">
    canvas#canvas4 {
      position: relative;
      top: 20px;
    }

  </style>
  <style>

    *:focus{
      outline:none; /* Prevents blue border in Webkit */
    }

   /* body {
      font-family: "Helvetica Neue", Helvetica, Arial, sans-serif; /!*  *!/
    }*/

    #top_bit {
      width:760px;
      margin: 0 auto;
    }

    form {
      width:300px;
      margin: 20px auto;
    }

    p {
      line-height: 1.6;
    }

    input, textarea {
      font-family: "Helvetica Neue", Helvetica, Arial, sans-serif;
      background-color:#fff;
      border:1px solid #ccc;
      font-size:20px;
      width:300px;
      min-height:30px;
      display:block;
      margin-bottom:16px;
      margin-top:2px;

      -webkit-border-radius:5px;
      -moz-border-radius:5px;
      border-radius:5px;

      -webkit-transition: all 0.5s ease-in-out;
      -moz-transition: all 0.5s ease-in-out;
      transition: all 0.5s ease-in-out;
    }

    textarea {
      min-height:200px;
    }

    input:focus, textarea:focus {
      -webkit-box-shadow:0 0 25px #ccc;
      -moz-box-shadow:0 0 25px #ccc;
      box-shadow:0 0 25px #ccc;

      -webkit-transform: scale(1.05);
      -moz-transform: scale(1.05);
      transform: scale(1.05);
    }

    /* The interesting bit */

    input:not(:focus), textarea:not(:focus) {
      opacity:0.5;
    }

    input:required, textarea:required {
      background:url("../heatMap/images/asterisk_orange.png") no-repeat 280px 7px;
    }

    input:valid, textarea:valid {
      background:url("../heatMap/images/tick.png") no-repeat 280px 5px;
    }

    input:focus:invalid, textarea:focus:invalid {
      background:url("../heatMap/images/cancel.png") no-repeat 280px 7px;
    }

    input[type=submit] {
      padding:10px;
      background:none;
      opacity:1.0;
    }

  </style>
  <style type="text/css">
    #bg{ display: none;  position: absolute;  top: 0%;  left: 0%;  width: 100%;  height: 100%;  background-color: black;  z-index:1001;  -moz-opacity: 0.7;  opacity:.70;  filter: alpha(opacity=70);}
    #show{display: none;  position: absolute;  top: 25%;  left: 22%;  width: 53%;  height: 65%;  padding: 8px;  border: 8px solid #E8E9F7;  background-color: white;  z-index:1002;  overflow: auto;}
  </style>
  <style type="text/css">
    #mapContainer img {
      max-width: inherit;
    }
    #sub-car{
      z-index:1;
      position:absolute;
      border:1px solid #e2e2e2;
      background: #fff;
      font-size: 14px;
      font-color:#000;
      text-align: left;
      box-shadow: 2px 2px 5px #73716e;
      width:240px;
      height:180px;
    }
    #sub-car table{
      border:0px solid #fff;
      table-space:2px;
      line-height: 1.5;
    }
    #sub-car #macOrCarPlate{
      background-color:#e2e2e2;
      text-indent: 1em;
      height:20px;
    }
    #sub-car a{
      text-align: right;

    }
  </style>



  <!-- HTML5 shim, for IE6-8 support of HTML5 elements -->
  <!--[if lt IE 9]>
  <![endif]-->
  <!-- Fav and touch icons -->
  <link rel="shortcut icon" href="<%=path%>/assets/ico/minus.png?version=<%=System.currentTimeMillis()%>">
</head>

<body>
<!--弹出遮罩层-->
<div id="bg"></div>
<div id="show">
  <div style="float: right;margin-right:5px;height: 5px;"><img src="<%=basePath%>/heatMap/images/close.png" onclick="hidediv();"><%--<input id="btnclose" type="button" value="Close" onclick="hidediv();"/>--%></div>
  <form action="#" id="bk">
  </form>
</div>
<!-- Preloader -->
<div id="preloader">
  <div id="status">&nbsp;</div>
</div>
<!-- TOP NAVBAR -->
<nav role="navigation" class="navbar navbar-static-top">
  <div class="container-fluid">
    <!-- Brand and toggle get grouped for better mobile display -->
    <div class="navbar-header">
      <button data-target="#bs-example-navbar-collapse-1" data-toggle="collapse" class="navbar-toggle" type="button">
        <span class="entypo-menu"></span>
      </button>
      <button class="navbar-toggle toggle-menu-mobile toggle-left" type="button">
        <span class="entypo-list-add"></span>
      </button>




      <div id="logo-mobile" class="visible-xs">
        <h1>WEB管理<span>v1.2</span></h1>
      </div>

    </div>


    <!-- Collect the nav links, forms, and other content for toggling -->
    <div id="bs-example-navbar-collapse-1" class="collapse navbar-collapse">

      <div id="nt-title-container" class="navbar-left running-text visible-lg">
        <ul class="date-top">
          <li class="entypo-calendar" style="margin-right:5px"></li>
          <li id="Date"></li>


        </ul>
        <ul id="digital-clock" class="digital">
          <li class="entypo-clock" style="margin-right:5px"></li>
          <li class="hour"></li>
          <li>:</li>
          <li class="min"></li>
          <li>:</li>
          <li class="sec"></li>
          <li class="meridiem"></li>
        </ul>
      </div>

      <ul style="margin-right:0;" class="nav navbar-nav navbar-right">
        <li>
          <a data-toggle="dropdown" class="dropdown-toggle" href="#">
            <img alt="" class="admin-pic img-circle" src="http://api.randomuser.me/portraits/thumb/men/10.jpg?version=<%=System.currentTimeMillis()%>">Hi, 方夏 <b class="caret"></b>
          </a>
        </li>
      </ul>

    </div>
    <!-- /.navbar-collapse -->
  </div>
  <!-- /.container-fluid -->
</nav>

<!-- /END OF TOP NAVBAR -->

<!-- SIDE MENU -->
<div id="skin-select">
  <div id="logo">
    <h1>WI-FI视频联动<span>v1.0</span></h1>
  </div>

  <a id="toggle">
    <span class="entypo-menu"></span>
  </a>
  <%--<div class="dark">
    <form action="#">
                <span>
                    <input type="text" name="search" value="" class="search rounded id_search" placeholder="Search Menu..." autofocus="">
                </span>
    </form>
  </div>--%>

  <%--<div class="search-hover">
    <form id="demo-2">
      <input type="search" placeholder="Search Menu..." class="id_search">
    </form>
  </div>--%>

  <div class="skin-part">
    <div id="tree-wrap">
      <div class="side-bar">
        <ul class="topnav menu-left-nest">
          <li>
            <a href="#" style="border-left:0px solid!important;" class="title-menu-left">

              <span class="widget-menu"></span>
             <%-- <i data-toggle="tooltip" class="entypo-cog pull-right config-wrap"></i>--%>

            </a>
          </li>

          <li>
            <a class="tooltip-tip ajax-load" href="#" onclick="queryView('getHistoryOrbit','MAC轨迹查询','MAC轨迹','MAC历史轨迹查询','1','MAC地址');" title="MAC历史轨迹查询">
              <i class="icon-window"></i>
              <span>MAC历史轨迹查询</span>

            </a>
          </li>
          <li>
            <a class="tooltip-tip ajax-load" href="#" onclick="queryOrbitView('getHistoryOrbit','MAC轨迹查询','MAC轨迹','MAC历史轨迹查询','1','MAC地址');" title="MAC实时轨迹查询">
              <i class="icon-feed"></i>
              <span>MAC实时轨迹查询</span>

            </a>
          </li>
        </ul>

        <ul class="topnav menu-left-nest">
          <li>
            <a href="#" style="border-left:0px solid!important;" class="title-menu-left">

              <span class="design-kit"></span>
              <%--<i data-toggle="tooltip" class="entypo-cog pull-right config-wrap"></i>--%>

            </a>
          </li>

          <li>
            <a class="tooltip-tip ajax-load" href="#" onclick="queryView('getCarHistoryOrbit','车辆轨迹查询','车辆轨迹','车辆历史轨迹查询','1','车牌号码');" title="车辆历史轨迹查询">
              <i class="icon-location"></i>
              <span>车辆历史轨迹查询</span>

            </a>
          </li>
          <li>
            <a class="tooltip-tip ajax-load" href="#" onclick="queryOrbitView('getCarHistoryOrbit','车辆轨迹查询','车辆轨迹','车辆历史轨迹查询','1','车牌号码');" title="车辆实时轨迹查询">
              <i class="icon-feed"></i>
              <span>车辆实时轨迹查询</span>
            </a>
          </li>
        </ul>

        <ul id="menu-showhide" class="topnav menu-left-nest">
          <li>
            <a href="#" style="border-left:0px solid!important;" class="title-menu-left">

              <span class="component"></span>
              <%--<i data-toggle="tooltip" class="entypo-cog pull-right config-wrap"></i>--%>

            </a>
          </li>


          <li>
            <a class="tooltip-tip" href="#" onclick="qqbkText('<%=basePath%>/execute/','getQQBKPage','布控、轨迹绑定','车辆布控','全区布控','1','车牌号码');" title="UI Element">
              <i class="icon-monitor"></i>
              <span>全区布控</span>
            </a>
           <%-- <ul>
              <li>
                <a class="tooltip-tip2 ajax-load" href="element.html" title="Element"><i class="icon-attachment"></i><span>Element</span></a>
              </li>
              <li><a class="tooltip-tip2 ajax-load" href="button.html" title="Button"><i class="icon-view-list-large"></i><span>Button</span> <div class="noft-blue-number">10</div></a>
              </li>
              <li>
                <a class="tooltip-tip2 ajax-load" href="wizard.html" title="Tab & Accordion"><i class="icon-folder"></i><span>Wizard</span><div class="noft-purple-number">3</div></a>
              </li>
              <li>
                <a class="tooltip-tip2 ajax-load" href="calendar.html" title="Calender"><i class="icon-calendar"></i><span>Calendar</span></a>
              </li>
              <li>
                <a class="tooltip-tip2 ajax-load" href="tree.html" title="Tree View"><i class="icon-view-list"></i><span>Tree View</span></a>
              </li>
              <li>
                <a class="tooltip-tip2 ajax-load" href="grids.html" title="Grids"><i class="icon-menu"></i><span>Grids</span></a>
              </li>
              <li>
                <a class="tooltip-tip2 ajax-load" href="chart.html" title="Chart"><i class="icon-graph-pie"></i><span>Chart</span></a>
              </li>
              <li>
                <a class="tooltip-tip ajax-load" href="typhography.html" title="Typhoghrapy">
                  <i class="icon-information"></i>
                  <span>Typhoghrapy</span>
                </a>
              </li>
            </ul>--%>
          </li>
          <li>
            <a class="tooltip-tip" href="#" title="Form">
              <i class="icon-lock"></i>
              <span>定点布控</span>
            </a>
          </li>
          <li>
            <a class="tooltip-tip" href="#" title="Tables">
              <i class="icon-media-shuffle"></i>
              <span>MAC/车辆绑定</span>
            </a>
          </li>
        </ul>


      </div>
    </div>
  </div>
</div>
<!-- END OF SIDE MENU -->



<!--  PAPER WRAP -->
<div class="wrap-fluid">
  <div class="container-fluid paper-wrap bevel tlbr">





    <!-- CONTENT -->
    <!--TITLE -->
    <div class="row">
      <div id="paper-top">
        <div class="col-lg-3">
          <h2 class="tittle-content-header">
            <i class="icon-window"></i>
                            <span id="MacOrbit">MAC轨迹查询
                            </span>
          </h2>

        </div>

        <div class="col-lg-7">
          <div class="devider-vertical visible-lg"></div>
          <div class="tittle-middle-header">


          </div>

        </div>

      </div>
    </div>
    <!--/ TITLE -->
    <div id="sub-car" style="display: none;">
    </div>
    <!-- BREADCRUMB -->
    <ul id="breadcrumb">
      <li>
        <span class="entypo-home"></span>
      </li>
      <li><i class="fa fa-lg fa-angle-right"></i>
      </li>
      <li id="Mac"><a href="#" title="Sample page 1">MAC轨迹</a>
      </li>
      <li><i class="fa fa-lg fa-angle-right"></i>
      </li>
      <li id="MacHistoryInfo"><a href="#" title="Sample page 1">MAC历史轨迹查询</a>
      </li>
      <li>
        <div class="input-group input-widget" id="textMac">
          <input style="border-radius:15px" type="text" id="macAddress"  placeholder="MAC地址" class="form-control">
        </div>
      </li>
      <li>
        <div class="input-group input-widget" id="startDate">
          <input style="border-radius:15px" id="dp1" type="text"  value="" placeholder="开始时间" class="form-control">
        </div>
    </li>
      <li>
        <div class="input-group input-widget" id="endDate">
          <input style="border-radius:15px" id="dp2" type="text" value="" placeholder="结束时间" class="form-control">
        </div>
      </li>
      <li class="pull-right">
        <div class="input-group input-widget" id="button">

        </div>
      </li>
    </ul>

    <!-- END OF BREADCRUMB -->






    <div id="paper-middle">
      <div id="mapContainer" style="width:100%;height:100%;"></div>
    </div>





    <div class="content-wrap" style="height: 0px;">
      <div class="row">
        <div class="col-lg-6">
          <div id="placeholder" style="width:100%;"></div>
        </div>
      </div>
      <!-- /END OF CONTENT -->
      <!-- / END OF FOOTER -->


    </div>
  </div>
</div>
<!--  END OF PAPER WRAP -->

<!-- END OF RIGHT SLIDER CONTENT-->
<script type="text/javascript" src="<%=path%>/assets/js/jquery.js?version=<%=System.currentTimeMillis()%>"></script>
<%--<script src="<%=path%>/assets/js/progress-bar/src/jquery.velocity.min.js?version=<%=System.currentTimeMillis()%>"></script>
<script src="<%=path%>/assets/js/progress-bar/number-pb.js?version=<%=System.currentTimeMillis()%>"></script>
<script src="<%=path%>/assets/js/progress-bar/progress-app.js?version=<%=System.currentTimeMillis()%>"></script>--%>



<!-- MAIN EFFECT -->
<%--<script type="text/javascript" src="<%=path%>/assets/js/preloader.js?version=<%=System.currentTimeMillis()%>"></script>--%>
<script type="text/javascript" src="<%=path%>/assets/js/bootstrap.js?version=<%=System.currentTimeMillis()%>"></script>
<script type="text/javascript" src="<%=path%>/assets/js/app.js?version=<%=System.currentTimeMillis()%>"></script>
<script type="text/javascript" src="<%=path%>/assets/js/load.js?version=<%=System.currentTimeMillis()%>"></script>
<script type="text/javascript" src="<%=path%>/assets/js/main.js?version=<%=System.currentTimeMillis()%>"></script>
<script type="text/javascript" src="<%=path%>/heatMap/js/apiv2.0.min.js?version=<%=System.currentTimeMillis()%>"></script>
<script type="text/javascript" src="<%=path%>/assets/js/timepicker/bootstrap-timepicker.js?version=<%=System.currentTimeMillis()%>"></script>
<script type="text/javascript" src="<%=path%>/assets/js/datepicker/bootstrap-datepicker.js?version=<%=System.currentTimeMillis()%>"></script>
<script type="text/javascript" src="<%=path%>/assets/js/datepicker/bootstrap-datetimepicker.js?version=<%=System.currentTimeMillis()%>"></script>
<script type="text/javascript" src="<%=path%>/assets/js/bk.js?version=<%=System.currentTimeMillis()%>"></script>
<script type="text/javascript" src="<%=path%>/page/dist/js/am-pagination.js?version=<%=System.currentTimeMillis()%>"></script>
<!-- GAGE -->


<%--<script type="text/javascript" src="<%=path%>/assets/js/chart/jquery.flot.js?version=<%=System.currentTimeMillis()%>"></script>
<script type="text/javascript" src="<%=path%>/assets/js/chart/jquery.flot.resize.js?version=<%=System.currentTimeMillis()%>"></script>
<script type="text/javascript" src="<%=path%>/assets/js/chart/realTime.js?version=<%=System.currentTimeMillis()%>"></script>
<script type="text/javascript" src="<%=path%>/assets/js/speed/canvasgauge-coustom.js?version=<%=System.currentTimeMillis()%>"></script>--%>
<%--
<script type="text/javascript" src="<%=path%>/assets/js/countdown/jquery.countdown.js?version=<%=System.currentTimeMillis()%>"></script>



<script src="<%=path%>/assets/js/jhere-custom.js?version=<%=System.currentTimeMillis()%>"></script>
--%>



<script type="text/javascript">
$("#dp1").datepicker({
  format: "yyyy-mm-dd"//日期格式
});
$("#dp2").datepicker({
  format: "yyyy-mm-dd"//日期格式
});
var polyline = new BMap.Polyline([ new BMap.Point(116.424391,39.936625),new BMap.Point(116.438764,39.957423),new BMap.Point(116.550872,39.931314) ], {
  strokeColor : "blue",
  strokeWeight : 2,
  strokeOpacity : 0.5
});
queryView('getHistoryOrbit','MAC轨迹查询','MAC轨迹','MAC历史轨迹查询','1','MAC地址');
//其他菜单调用方法
function queryView(actionInfo,macInfo,mac,macHistoryInfo,flag,val){
  //先初始化地图
  $("#MacOrbit").text(macInfo);
  $("#Mac").text(mac);
  $("#MacHistoryInfo").text(macHistoryInfo);
  $('#button').children().remove();
  $('#button').append('<button type="button" class="btn btn-default" onclick="queryView(\''+actionInfo+'\',\''+macInfo+'\',\''+mac+'\',\''+macHistoryInfo+'\',\'0\',\''+val+'\');">查询</button>');
  if(flag=='1'){
    //清空输入的参数
    $("#macAddress").val("");
    $("#dp1").remove();
    $("#dp2").remove();
    $("#macAddress").remove();
    $('#button').children().remove();
    if($("#dp1").length == 0){
      //设置时间框
      $("#startDate").append('<input style="border-radius:15px" id="dp1" type="text"  value="" placeholder="开始时间" class="form-control">');
    }
    if($("#dp2").length == 0){
      //设置时间框
      $("#endDate").append('<input style="border-radius:15px" id="dp2" type="text"  value="" placeholder="结束时间" class="form-control">');
    }
    if($("#macAddress").length == 0){
      $("#textMac").append('<input style="border-radius:15px" type="text" id="macAddress"  placeholder="MAC地址" class="form-control">');
    }
    if($('#button').children().length == 0){
      $('#button').append('<button type="button" class="btn btn-default" onclick="queryView(\''+actionInfo+'\',\''+macInfo+'\',\''+mac+'\',\''+macHistoryInfo+'\',\'0\',\''+val+'\');">查询</button>');
    }
    $("#dp1").datepicker({
      format: "yyyy-mm-dd"//日期格式
    });
    $("#dp2").datepicker({
      format: "yyyy-mm-dd"//日期格式
    });
    $("#macAddress").attr('placeholder',val);
    //先初始化一个地图
    var map = new BMap.Map("mapContainer");
    var point = new BMap.Point(116.404,39.915);
    var marker = new BMap.Marker(point);  // 创建标注
    marker.setAnimation(BMAP_ANIMATION_DROP);
    map.clearOverlays();
    map.enableScrollWheelZoom(true);
    map.addOverlay(marker);// 将标注添加到地图中
    map.centerAndZoom(point,15);
  }else{
    //清空之前的数据
    //获取查询参数
    var macAddress = $("#macAddress").val();
    var startDate = $("#dp1").val();
    var endDate = $("#dp2").val();
    if(macAddress==""||macAddress==null){
      alert("请填写MAC地址");
      return false;
    }
    if(startDate == "" || startDate == null){
      alert("请选择开始时间");
      return false;
    }
    if(endDate == "" || endDate == null){
      alert("请选择结束时间");
      return false;
    }
    $.ajax({
      type:"post",
      url:"<%=basePath%>/orbit/"+actionInfo,
      //contentType:"application/json;charset=utf-8",
      data:{mac:macAddress,startDate:startDate,endDate:endDate},
      dataType:"json",
      success:function(data){
        if(data.enument.length>0&&data.orbit.length>0){
          //先移除地图
          $("#mapContainer").remove();
          //重新生成div
          $("#paper-middle").append('<div id="mapContainer" style="width:100%;height:100%;"></div>')
          var mapInfo = new BMap.Map("mapContainer");
          var pointInfo = new BMap.Point(data.enument[0].langitude, data.enument[0].latitude);
          mapInfo.centerAndZoom(pointInfo, 15);
          mapInfo.clearOverlays();
          mapInfo.enableScrollWheelZoom(true);
          for(var i=0;i<data.enument.length;i++){
            var pointVal = new BMap.Point(data.enument[i].langitude, data.enument[i].latitude);
            var myIcon;
            if(actionInfo.indexOf("Car")!=-1){
              myIcon = new BMap.Icon("<%=basePath%>/heatMap/images/113equipment.png", new BMap.Size(23, 25), {

              });
            }else{
              myIcon = new BMap.Icon("<%=basePath%>/heatMap/images/wifiequipment.png", new BMap.Size(23, 25), {

              });
            }
            var markerInfo = new BMap.Marker(pointVal,{icon: myIcon});  // 创建标注
            markerInfo.setTitle(data.enument[i].equipmentLocation);
            markerInfo.setAnimation(BMAP_ANIMATION_DROP); //跳动的动画
            mapInfo.addOverlay(markerInfo);// 将标注添加到地图中
          }
          var arrayList = [] ;
          var points=[];
          for(var t=0;t<data.orbit.length;t++) {
            var p = new BMap.Point(data.orbit[t].langitude, data.orbit[t].latitude);
            arrayList.push(p);
          }
          if(actionInfo.indexOf("Car")!=-1){
            //说明为车辆
            showPoly(arrayList,mapInfo,data.orbit,'0');
          }else{
            showPoly(arrayList,mapInfo,data.orbit,'1');
          }


        }

      },
      error:function(data){
        alert("获取信息失败");
      }
    });
  }

}
function closeDiv(){
  $("#sub-car").css("display", "none");
}
//查看详情
function openInfoWindow(content, top,left,flag) {
  $("#sub-car").css("top", top-100 + "px");
  $("#sub-car").css("left", left-230 + "px");
  $("#sub-car").css("display", "block");
  var html="";
  if(flag=='0'){
    html = html+'<div id="macOrCarPlate" style="font-weight: bold;">车牌号码:'+content.carPlate+'' +
            '<span style="margin-right: 5px;float: right;" onclick="closeDiv();">[X]</span></div>';
    html = html+'<table id="content"><tr> <td>通过时间：</td><td>'+content.startTime+'</td></tr>' +
            '<tr> <td>车辆照片：</td><td><img src="<%=basePath%>/heatMap/images/timg.jpeg" width="140" height="100"/></td></tr>' +
            '<tr><td colspan="2" style="float: right;margin-right: 10px;"><a href="#" style="float: right;margin-right: 10px;">查看详情</a></td></tr></table>';
  }else{
    html = html+'<div id="macOrCarPlate" style="font-weight: bold;">MAC:'+content.macAddress+'' +
            '<span style="margin-right: 5px;float: right;" onclick="closeDiv();">[X]</span></div>';
    html = html+'<table id="content"><tr> <td>通过时间：</td><td>'+content.startTime+'</td></tr>' +
            '<tr><td colspan="2"><a href="#">查看详情</a></td></tr></table>';
  }

  $("#sub-car").html(html);
}

function showPoly(pointList,mapInfo,val,flag){
  mapInfo.removeOverlay(polyline);
  //循环显示点对象
  for(c=0;c<pointList.length;c++){
    var marker = new BMap.Marker(pointList[c]);

    //将途经点按顺序添加到地图上
    var label = new BMap.Label(c+1,{offset:new BMap.Size(20,-10)});
    marker.setLabel(label);
    if(flag == '1'){
      var myIcon = new BMap.Icon("<%=basePath%>/heatMap/images/wifi.png", new BMap.Size(23, 25), {

      });
      marker = new BMap.Marker(pointList[c],{icon: myIcon});
    }else{
      var myIcon = new BMap.Icon("<%=basePath%>/heatMap/images/113.png", new BMap.Size(23, 25), {

      });
      marker = new BMap.Marker(pointList[c],{icon: myIcon});
    }
    marker.propty=val[c];
    marker.addEventListener("click", function(e) {
      openInfoWindow(e.currentTarget.propty,e.clientY, e.clientX,flag);
    });
    mapInfo.addOverlay(marker);
  }
  polyline = new BMap.Polyline(pointList, {
    strokeColor : "#21FC03",
    strokeWeight : 6,
    strokeOpacity : 0.6
  });

  mapInfo.addOverlay(polyline);

}
//查询实时轨迹
//其他菜单调用方法
function queryOrbitView(actionInfo,macInfo,mac,macHistoryInfo,flag,val){
  //先初始化地图
  $("#MacOrbit").text(macInfo);
  $("#Mac").text(mac);
  $("#MacHistoryInfo").text(macHistoryInfo);
  $('#button').children().remove();
  $("#dp1").remove();
  $("#dp2").remove();
  $('#button').append('<button type="button" class="btn btn-default" onclick="queryOrbitView(\''+actionInfo+'\',\''+macInfo+'\',\''+mac+'\',\''+macHistoryInfo+'\',\'0\',\''+val+'\');">查询</button>');
  if(flag=='1'){
    //清空输入的参数
    $("#macAddress").val("");
    $("#macAddress").remove();
    if($("#macAddress").length == 0){
      $("#textMac").append('<input style="border-radius:15px" type="text" id="macAddress"  placeholder="MAC地址" class="form-control">');
    }
    $('#button').children().remove();
    if($('#button').children().length == 0){
      $('#button').append('<button type="button" class="btn btn-default" onclick="queryOrbitView(\''+actionInfo+'\',\''+macInfo+'\',\''+mac+'\',\''+macHistoryInfo+'\',\'0\',\''+val+'\');">查询</button>');
    }
    $("#macAddress").attr('placeholder',val);
    //先初始化一个地图
    var map = new BMap.Map("mapContainer");
    var point = new BMap.Point(116.404,39.915);
    var marker = new BMap.Marker(point);  // 创建标注
    marker.setAnimation(BMAP_ANIMATION_DROP);
    map.clearOverlays();
    map.enableScrollWheelZoom(true);
    map.addOverlay(marker);// 将标注添加到地图中
    map.centerAndZoom(point,15);
  }else{
    //清空之前的数据
    //获取查询参数
    var macAddress = $("#macAddress").val();
    if(macAddress==""||macAddress==null){
      alert("请填写MAC地址");
      return false;
    }
    $.ajax({
      type:"post",
      url:"<%=basePath%>/orbit/"+actionInfo,
      //contentType:"application/json;charset=utf-8",
      data:{mac:macAddress,startDate:"",endDate:""},
      dataType:"json",
      success:function(data){
        if(data.enument.length>0&&data.orbit.length>0){
          //先移除地图
          $("#mapContainer").remove();
          //重新生成div
          $("#paper-middle").append('<div id="mapContainer" style="width:100%;height:100%;"></div>')
          var mapInfo = new BMap.Map("mapContainer");
          var pointInfo = new BMap.Point(data.enument[0].langitude, data.enument[0].latitude);
          mapInfo.centerAndZoom(pointInfo, 15);
          mapInfo.clearOverlays();
          mapInfo.enableScrollWheelZoom(true);
          for(var i=0;i<data.enument.length;i++){
            var pointVal = new BMap.Point(data.enument[i].langitude, data.enument[i].latitude);
            var myIcon;
            if(actionInfo.indexOf("Car")!=-1){
              myIcon = new BMap.Icon("<%=basePath%>/heatMap/images/113equipment.png", new BMap.Size(23, 25), {

              });
            }else{
              myIcon = new BMap.Icon("<%=basePath%>/heatMap/images/wifiequipment.png", new BMap.Size(23, 25), {

              });
            }
            var markerInfo = new BMap.Marker(pointVal,{icon: myIcon});  // 创建标注
            markerInfo.setTitle(data.enument[i].equipmentLocation);
            markerInfo.setAnimation(BMAP_ANIMATION_DROP); //跳动的动画
            mapInfo.addOverlay(markerInfo);// 将标注添加到地图中
          }
          var arrayList = [] ;
          var points=[];
          for(var t=0;t<data.orbit.length;t++) {
            var p = new BMap.Point(data.orbit[t].langitude, data.orbit[t].latitude);
            arrayList.push(p);
          }
          if(actionInfo.indexOf("Car")!=-1){
            //说明为车辆
            showSSPoly(arrayList,mapInfo,data.orbit,'0');
          }else{
            showSSPoly(arrayList,mapInfo,data.orbit,'1');
          }


        }

      },
      error:function(data){
        alert("获取信息失败");
      }
    });
  }

}
function showSSPoly(pointList,mapInfo,val,flag){
  mapInfo.removeOverlay(polyline);
  //循环显示点对象
  var marker ;
  for(c=0;c<pointList.length;c++){
    if(c==pointList.length-1){
      //设置最后一个标准的图片
      var myIcon = new BMap.Icon("<%=basePath%>/heatMap/images/1.gif", new BMap.Size(23, 25), {

      });

      marker = new BMap.Marker(pointList[c],{icon: myIcon});
    }else{
      if(flag == '1'){
        var myIcon = new BMap.Icon("<%=basePath%>/heatMap/images/wifi.png", new BMap.Size(23, 25), {

        });
        marker = new BMap.Marker(pointList[c],{icon: myIcon});
      }else{
        var myIcon = new BMap.Icon("<%=basePath%>/heatMap/images/113.png", new BMap.Size(23, 25), {

        });
        marker = new BMap.Marker(pointList[c],{icon: myIcon});
      }

    }
    mapInfo.addOverlay(marker);
    //将途经点按顺序添加到地图上
    var label = new BMap.Label(c+1,{offset:new BMap.Size(20,-10)});
    marker.setLabel(label);
    marker.propty=val[c];
    marker.addEventListener("click", function(e) {
      openInfoWindow(e.currentTarget.propty,e.clientY, e.clientX,flag);
    });
  }
  polyline = new BMap.Polyline(pointList, {
    strokeColor : "#21FC03",
    strokeWeight : 6,
    strokeOpacity : 0.6
  });

  mapInfo.addOverlay(polyline);

}
</script>

</body>

</html>
