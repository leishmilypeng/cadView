<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: CPR161
  Date: 2018-09-19
  Time: 19:03
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<c:set var="_ctx" value="${pageContext.request.contextPath}"></c:set>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <meta name="viewport" content="width=device-width, minimum-scale=1, maximum-scale=1">
    <meta name="apple-mobile-web-app-status-bar-style" content="black" />
    <meta name="format-detection" content="telephone=no" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
    <title id ="loginTitle">CAD查看</title>
    <link rel="icon"  href="${_ctx}/resource/images/public/favicon_02.gif" type="image/x-icon"></link>
    <script type="text/javascript" src="${_ctx}/resource/js/lib/jquery/jquery.js"></script>
    <script type="text/javascript" src="${_ctx}/resource/js/lib/jquery/jquery-ui.min.js"></script>
    <script type="text/javascript" src="${_ctx}/resource/js/lib/jquery/v.js"></script>

    <script type="text/javascript" src="${_ctx}/resource/js/lib/bootstrap/bootstrap-modal.js"></script>
    <script type="text/javascript" src="${_ctx}/resource/js/lib/bootstrap/bootstrap.min.js"></script>
    <link rel="stylesheet" href="${_ctx}/resource/css/public.css" type="text/css">
    <link rel="stylesheet" href="${_ctx}/resource/css/bootstrap/bootstrap.min.css" type="text/css">

    <link href="${_ctx}/resource/css/jquery/jquery-ui.css" rel="stylesheet">
    <link href="${_ctx}/resource/css/jquery/verify.css" rel="stylesheet">


    <script>
        function ZoomIn() {
            DWGViewX.ZoomIn();
        }
        function ZoomOut() {
            DWGViewX.ZoomOut();
        }
        function ZoomAll() {
            DWGViewX.ZoomAll();
        }
        function HideToolbar() {
            DWGViewX.ShowToobar = !DWGViewX.ShowToobar
        }
        function Pan() {
            DWGViewX.PanByMouse();
        }
        function ZoomWindow() {
            DWGViewX.ZoomRectByMouse();
        }
        function HideLayoutBar() {
            DWGViewX.ShowLayoutBar = !DWGViewX.ShowLayoutBar;
        }
        function Background() {
            DWGViewX.Background = DWGViewX.Background == 0 ? 7 : 0
        }
        function Print() {
            DWGViewX.Print();
        }
    </script>


</head>
<body>

    <div >
        <span>查询图号</span>
        <input type="text" id="searchKeyId">
        <input type="button" value="搜索" id="searchId" onclick="">

    </div>

    <div style="margin-top: 20px;">
        <div style="width: 25%;float: left;border:1px solid black;">
            <select name="leftList" id="undo_redo_left" class="form-control" size="13" multiple="multiple" style="overflow:scroll;" >
            </select>
        </div>
        <div style="width: 55px;float: left;">
            <input type="button" value="添加" id="addId" onclick="">

        </div>
        <div  style="width: 25%;float: left;border:1px solid black;">
            <select name="rightList" id="undo_redo_right" class="form-control" size="13" multiple="multiple" style="overflow:scroll;"  ></select>
        </div>
        <div style="width: 8%;float: left;">
            <input type="button" value="删除" id="delId" onclick="">
            <input type="button" value="打包存档" id="packageId" onclick="" style="margin-top: 100px;">
        </div>

       <%-- <div style="width: 100%;height: 100%;float: left;border:1px solid black;">--%>
            <%--<img style="width: 100%;height: 100%;" src="" name="图片展示" title="" id="showImgId">--%>
<%--

            <object id="DWGViewX" codebase="${_ctx}/resource/dwgviewx.cab" height="520"
                    width="700" classid="clsid:AC53EFE4-94A7-47E6-BBFC-E9B9CF322299">
                <param name="_Version" value="65536">
                <param name="_ExtentX" value="18521">
                <param name="_ExtentY" value="13758">
                <param name="_StockProps" value="0">
                <param name="DrawingFile" value="${_ctx}/resource/images/009.dwg">
                <param name="ShowToobar" value="-1">
                <param name="ShowLayoutBar" value="-1">

            </object>
--%>
           <%-- <iframe src="${_ctx}/demo.do" style="width: 100%;height: 800px;"> </iframe>--%>
        <%--</div>--%>
    </div>

    <div style="padding: 30px;">
        <%--
        <a href="javascript:ZoomIn()">Zoom In</a> | <a href="javascript:ZoomOut()">Zoom Out</a> | <a href="javascript:ZoomAll()">Zoom All</a>
        | <a href="javascript:ZoomWindow()">Zoom Window</a>| <a href="javascript:Pan()">Pan</a>| <a href="javascript:HideToolbar()">Show/Hide Toolbar</a>
        | <a href="javascript:HideLayoutBar()">Show/Hide LayoutBar</a>
        |<a href="javascript:Print()">Print</a>
        |<a href="javascript:Background()">Background</a>
    --%>
        <table border="0">
            <tr>
                <td class="ieb">
                    <object id="DWGViewX" codebase="http://www.autodwg.com/dwgviewx/dwgviewx.cab" height="520"
                            width="700" classid="clsid:AC53EFE4-94A7-47E6-BBFC-E9B9CF322299">
                        <param name="_Version" value="65536">
                        <param name="_ExtentX" value="18521">
                        <param name="_ExtentY" value="13758">
                        <param name="_StockProps" value="0">
                        <%--<param name="DrawingFile" value="${_ctx}/resource/images/009.dwg">--%>
                        <param name="DrawingFile" value="http://localost:8080/cad/resource/images/009.dwg">
                        <param name="ShowToobar" value="-1">
                        <param name="ShowLayoutBar" value="1">

                    </object>
                </td>
                <td valign="top">
                    <table width="100%" border="0" cellspacing="10" style="margin-left: 10px;">
                        <tr>
                            <td width="100%">
                                <div>

                                    <p>Or, you can load a local drawing to view it:</p>
                                    <input type="file" id="drawing" class="file" accept=".dwg, .dxf, .dwf" onchange="loadDWG()" style="width: 400px;" />

                                </div>
                            </td>
                        </tr>

                    </table>
                </td>
            </tr>
        </table>

        <button type="button" id="btn" data-toggle="modal" data-target="#myModal" style="display: none"></button>
    </div>


</body>
</html>
<script  type="text/javascript">
    $(function() {
        //查询
        $("#searchId").off("click").on("click", function(event){
            var keyValue = $("#searchKeyId").val();
            if(keyValue==""){
                alert("请输入查询条件！");
            }else{
                $.ajax({
                    "type" : 'post',
                    "url" : '${_ctx}/doSearch.do',
                    "dataType" : "json",
                    "async" : false,
                    "data" : {
                        "keyValue":keyValue
                    },
                    success : function(result) {
                        if(result!=null){
                            var cadObj = result;
                            $("#undo_redo_left").empty();
                            for(var i=0;i<cadObj.length;i++) {
                                var obj = cadObj[i];
                                $("#undo_redo_left").append("<option value='" + obj.id + "' path='"+obj.path+"'  >" + obj.name + "</option>");//新增
                            }
                        }
                    }
                });
            }
        });


        //添加
        $("#addId").off("click").on("click", function(event) {
            var leftObj = $("#undo_redo_left");
            var leftOptions = leftObj[0].options;
            var leftLength = leftOptions.length;

            var mapObj = {};
            var rightObj = $("#undo_redo_right");
            var rightOptions = rightObj[0].options;
            var rigthLen = rightOptions.length;
            for (var j = 0; j < rigthLen; j++) {
                var rOp = rightOptions[j];
                mapObj[rOp.value] = rOp.text;
            }

            if (leftLength < 0) {
                alert("请先选择要添加的文件！");
            }
            var delArr = [];

            for (var i = 0; i < leftLength; i++) {
                var op = leftOptions[i];
                var key = op.value;
                if (mapObj[key] == null && op.selected) {
                    var path = $(op).attr("path");
                    rightObj.append("<option value='" + key + "'  path='"+path+"'  >" + op.text + "</option>");//新增
                    delArr.push(key);
                }
            }

            // 删除左列表
            for (var k = 0; k < delArr.length; k++) {
                $("#undo_redo_left option[value='"+delArr[k]+"']").remove();
            }


        });

        //删除
        $("#delId").off("click").on("click", function(event){
            var leftObj = $("#undo_redo_left");
            var leftOptions = leftObj[0].options;
            var leftLength = leftOptions.length;

            var mapObj = {};
            var rightObj = $("#undo_redo_right");
            var rightOptions = rightObj[0].options;
            var rigthLen = rightOptions.length;


            for (var j = 0; j < leftLength; j++) {
                var rOp = leftOptions[j];
                mapObj[rOp.value] = rOp.text;
            }

            if (rightOptions.length < 0) {
                alert("请先选择要删除的文件！");
            }
            var delArr = [];

            for (var i = 0; i < rigthLen; i++) {
                var op = rightOptions[i];
                var key = op.value;
                if (mapObj[key] == null && op.selected) {
                    var path = $(op).attr("path");
                    leftObj.append("<option value='" + key + "' path='"+path+"' >" + op.text + "</option>");//新增
                    delArr.push(key);
                }
            }

            // 删除左列表
            for (var k = 0; k < delArr.length; k++) {
                $("#undo_redo_right option[value='"+delArr[k]+"']").remove();
            }

        });

        //打包存档
        $("#packageId").off("click").on("click", function(event){


        });

        //右边双击查看
        $("#undo_redo_right").off("dblclick").on("dblclick", function(event){
            var rightObj = $("#undo_redo_right");
            var rightOptions = rightObj[0].options;
            var rigthLen = rightOptions.length;
            for (var i = 0; i < rigthLen; i++) {
                var op = rightOptions[i];
                var key = op.value;
                var name = op.text;
                if(op.selected){
                    //path.replace(file,"file");
                    //$("#showImgId").attr("src",'${_ctx}/showImg.do?id='+key);
                    //$("#showImgId").attr("title",name);
                    $("#DWGViewX param[name='DrawingFile']").val('${_ctx}/showImg.do?id='+key)
                    // 通过文件流Base64方式展示

                }
            }

        });



    });


    function isIE() {
        if (!!window.ActiveXObject || "ActiveXObject" in window)
            return true;
        else
            return false;
    }

    window.onload = function () {
        if (document.all.DWGViewX.object == null) {
            $(".not_installed").show();
            $(".ieb").hide();
        }

        if (!isIE()) {
            $(".not_installed").hide();
            $(".ieb").hide();
            $(".elseb").show();
        }
    }

    $.getJSON("/include-responsive/ajax.aspx?op=browser&rnd=" + Math.random,
            function (result) {
                if (result.status) {
                    str = result.browser.replace("InternetExplorer", "IE").replace(/(^\s*)|(\s*$)/g, "");;
                    if (str != "IE") {
                        $("#btn").click();
                    }
                }
            });

    var DWGViewX = document.getElementById("DWGViewX");
    function loadDWG() {
        var dwg = $("#drawing").val();
        debugger
        DWGViewX.SetDwgFile(dwg);
    }




</script>