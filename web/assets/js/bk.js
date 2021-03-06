/**
 * Created by fangshilei on 18/1/30.
 */
/**
 * 全区布控
 */
var path = "";
var limit =10;
var titles = ['任务名称','任务目标','开始时间','结束时间','任务类型','布控类型','布控总数','任务状态','操作'];
var key = ['taskName','taskTarget','startTime','endTime','taskType','controlType','totalCount','taskStatus'];
function qqbkText(basePath,actionInfo,macInfo,mac,macHistoryInfo,flag,val){
    var url = basePath+"/"+actionInfo;
    path = basePath;
    //生成 全区布控页面
    //先初始化地图
    $("#MacOrbit").text(macInfo);
    $("#Mac").text(mac);
    $("#MacHistoryInfo").text(macHistoryInfo);
    $("#dp1").remove();
    $("#dp2").remove();
    $("#macAddress").remove();
    $("#button").children().remove();
    $("#mapContainer").children().remove();
    $("#button").append('<button type="button" class="btn btn-default" onclick="showdiv(\''+basePath+'\');");">新建</button>');
    $.ajax({
        type:"post",
        url:url,
        data:{pageNum:1,limit:limit},
        dataType:"json",
        success:function(data){
            if(data.records >= 0){
                createTable(data,titles,key,url);
            }else{
                alert("获取信息失败");
            }
        },
        error:function(data){
            alert("获取信息失败");
        }
    });

}
function showdiv(project) {
    document.getElementById("bg").style.display ="block";
    document.getElementById("show").style.display ="block";
    //生成表单
    var html = '<label for="taskName">任务名称:</label>' +
        '<input type="text" name="taskName" id="taskName" required placeholder="任务名称" style="color:#000000"/>';
    html = html + '<label for="controlTarget">布控目标:</label>' +
        '<input type="text" name="controlTarget" id="controlTarget" required placeholder="车牌号码、MAC地址" style="color:#000000"/>';
    html = html + '<label for="startTime">开始时间:</label>' +
        '<input type="text" name="startTime" id="startTime" required placeholder="开始时间" style="color:#000000"/>';
    html = html + '<label for="endTime">结束时间:</label>' +
        '<input type="text" name="endTime" id="endTime" required placeholder="结束时间" style="color:#000000"/>' +
        '<label for="taskName">任务类型:</label><select id="taskType" style="width:100px;"><option value="0">车辆</option><option value="0">MAC地址</option></select></br>';
    html = html + '<input type="submit" id="submit" onclick="qqbkTJ(\''+project+'\');" value="提交" />';
    $("#bk").append(html);
    //添加时间
    $("#startTime").datepicker({
        format: "yyyy-mm-dd"//日期格式
    });
    $("#endTime").datepicker({
        format: "yyyy-mm-dd"//日期格式
    });
}
function hidediv() {
    //清除表单内容后隐藏
    $("#bk").children().remove();
    document.getElementById("bg").style.display ='none';
    document.getElementById("show").style.display ='none';
}
/**
 * 提交表单
 */
function qqbkTJ(project){
    var taskName = $("#taskName").val();//任务名称
    var controlTarget = $("#controlTarget").val();
    var startTime = $("#startTime").val();
    var endTime = $("#endTime").val();
    var taskType = $("#taskType").find("option:selected").val();
    //添加布控任务
    $.ajax({
        type:"post",
        url:project+"/insertQQBK",
        data:{taskName:taskName,controlTarget:controlTarget,startTime:startTime,endTime:endTime,taskType:taskType},
        dataType:"json",
        success:function(data){
            //提示信息
            if(data.msg="true"){
                alert("添加全区布控任务成功");
                hidediv();
                //刷新table
                qqbkText(project,'getQQBKPage','布控、轨迹绑定','车辆布控','全区布控','1','车牌号码');
            }
        },
        error:function(data){
            alert("添加全区布控任务失败");
        }
    });
}
/**
 * 新建任务
 */
function qqbkCreate(){

}
function ddbk(actionInfo,macInfo,mac,macHistoryInfo,flag,val){
    //生成 全区布控页面
    //先初始化地图
    $("#MacOrbit").text(macInfo);
    $("#Mac").text(mac);
    $("#MacHistoryInfo").text(macHistoryInfo);
    $("#dp1").remove();
    $("#dp2").remove();
    $("#macAddress").remove();
    $("#button").children().remove();
    $("#mapContainer").children().remove();
    $("#button").append('<button type="button" class="btn btn-default" onclick="");">新建</button>');
}
//自定义表格
function createTable(results,titles,keys,url){
    $("#tableId tr:not(:first):not(:last)").remove();
    var html = '<div class="body-nest" id="tableStatic"><section id="flip-scroll"><table id="tableId" class="table table-bordered table-striped cf">' +
        '<thead class="cf"><tr>';
    for(var t=0;t<titles.length;t++){
        html = html + '<th>'+titles[t]+'</th>';
    }
    html = html + '</tr></thead><tbody>';
    for(var k=0;k<results.datas.length;k++){
        html = html + "<tr>";
        for(var c=0;c<keys.length;c++){
            if(keys[c]=='taskStatus'){
                var  taskStatus = ''+results.datas[k][keys[c]]+'';
                if(taskStatus=='0'){
                    html = html + '<td>未启动</td>';
                }else if(taskStatus=='2'){
                    html = html + '<td>已结束</td>';
                }else{
                    html = html + '<td>已启动</td>';
                }
            }else if(keys[c]=='taskType'){
                var  taskType = ''+results.datas[k][keys[c]]+'';
                if(taskType=='0'){
                    html = html + '<td>车辆</td>';
                }else if(taskType=='1'){
                    html = html + '<td>MAC地址</td>';
                }else{
                    html = html + '<td>未知</td>';
                }
            }else if(keys[c]=='controlType'){
                var  controlType = ''+results.datas[k][keys[c]]+'';
                if(controlType=='0'){
                    html = html + '<td>全区布控</td>';
                }else if(controlType=='1'){
                    html = html + '<td>定点布控</td>';
                }else{
                    html = html + '<td>未知</td>';
                }
            }
            else{
                html = html + '<td>'+results.datas[k][keys[c]]+'</td>';
            }

        }
        html = html+'<td><a href="#" onclick="queryResult(\''+results.datas[k].ID+'\',\''+results.datas[k].taskType+'\');">布控结果</a></tr>';
    }
    html = html+'<tr><td colspan="10"><div id="ampagination" style="float: right;margin-right: 10px;"></div></td></tr></tbody></table></section></div>';
/*<tr><td>AAC</td><td>AUSTRALIAN AGRICULTURAL COMPANY LIMITED.</td>' +
    '<td class="numeric">$1.38</td></td></tr><tr><td colspan="10"><div id="ampagination" style="float: right;margin-right: 10px;"></div></td></tr></tbody></table></section></div>';*/
    $("#mapContainer").append(html);
    //生成分页
    var pager = jQuery('#ampagination').pagination({
        page:1,
        totals:results.records,
        pageSize:limit
    });
    pager.url=url;
    pager.onChangePage(function(e){
        //点击后需要做的操作
        $.ajax({
            type:"post",
            url:url,
            data:{pageNum: e.page,limit:limit},
            dataType:"json",
            success:function(data){
                if(data.records >= 0){
                    pageTable(data,titles,key);
                }else{
                    alert("获取信息失败");
                }
            },
            error:function(data){
                alert("获取信息失败");
            }
        });
    });
}
function pageTable(results,titles,keys){
    $("#tableId tr:not(:first):not(:last)").remove();
    var html = '';
    for(var k=0;k<results.datas.length;k++){
        html = html + "<tr>";
        for(var c=0;c<keys.length;c++){
            if(keys[c]=='taskStatus'){
                var  taskStatus = ''+results.datas[k][keys[c]]+'';
                if(taskStatus=='0'){
                    html = html + '<td>未启动</td>';
                }else if(taskStatus=='2'){
                    html = html + '<td>已结束</td>';
                }else{
                    html = html + '<td>已启动</td>';
                }
            }else{
                html = html + '<td>'+results.datas[k][keys[c]]+'</td>';
            }
        }
        html = html + '<td><a href="#" onclick="queryResult(\''+results.datas[k].ID+'\',\''+results.datas[k].taskType+'\');">布控结果</a></tr>';
    }
    $("#tableId tr:last").before(html);
    /*<tr><td>AAC</td><td>AUSTRALIAN AGRICULTURAL COMPANY LIMITED.</td>' +
     '<td class="numeric">$1.38</td></td></tr><tr><td colspan="10"><div id="ampagination" style="float: right;margin-right: 10px;"></div></td></tr></tbody></table></section></div>';*/
}
//查看布控结果
function queryResult(id,taskType){
    $("#mapContainer").children().remove();
    //移除表单
    if(taskType=='0'){
        //生成车辆地图
        queryBKOrbitView('getCarBKOrbit','车辆布控','全区布控','车辆布控结果查看','0',id);
    }else if(taskType == '1'){
        queryBKOrbitView('getBKOrbit','MAC布控','全区布控','MAC布控结果查看','0',id);
    }

}
//查询实时轨迹
//其他菜单调用方法
function queryBKOrbitView(actionInfo,macInfo,mac,macHistoryInfo,flag,id){
    //先初始化地图
    $("#MacOrbit").text(macInfo);
    $("#Mac").text(mac);
    $("#MacHistoryInfo").text(macHistoryInfo);
    $('#button').children().remove();
    $('#button').append('<button type="button" class="btn btn-default" onclick="qqbkText(\''+path+'\',\'getQQBKPage\',\'布控、轨迹绑定\',\'车辆布控\',\'全区布控\',\'1\',\'车牌号码\');">返回</button>');
    $("#dp1").remove();
    $("#dp2").remove();
    if(flag=='1'){
        //先初始化一个地图
        $('#button').children().remove();
        if($('#button').children().length == 0){
            $('#button').append('<button type="button" class="btn btn-default" onclick="qqbkText(\''+path+'\',\'getQQBKPage\',\'布控、轨迹绑定\',\'车辆布控\',\'全区布控\',\'1\',\'车牌号码\');">返回</button>');
        }
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
        $.ajax({
            type:"post",
            url:path.split("execute")[0]+"/orbit/"+actionInfo,
            //contentType:"application/json;charset=utf-8",
            data:{id:id},//查询布控轨迹
            dataType:"json",
            success:function(data){
                if(data.orbit.length>0){
                    //先移除地图
                    $("#mapContainer").remove();
                    //重新生成div
                    $("#paper-middle").append('<div id="mapContainer" style="width:100%;height:100%;"></div>')
                    var mapInfo = new BMap.Map("mapContainer");
                    var pointInfo = new BMap.Point(data.orbit[0].langitude, data.orbit[0].latitude);
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
                        //否则为mac信息
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