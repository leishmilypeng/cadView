<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.Iterator" %>
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

<%

    String SERVER_NAME = request.getServerName();
    String SERVER_SOFTWARE = request.getServletContext().getServerInfo();
    String SERVER_PROTOCOL = request.getProtocol();
    Integer SERVER_PORT = request.getServerPort();
    String REQUEST_METHOD = request.getMethod();
    String PATH_INFO = request.getPathInfo();
    String PATH_TRANSLATED = request.getPathTranslated();
    String SCRIPT_NAME = request.getServletPath();
    String DOCUMENT_ROOT = request.getRealPath("/");
    String QUERY_STRING = request.getQueryString();
    String REMOTE_HOST = request.getRemoteHost();
    String REMOTE_ADDR = request.getRemoteAddr();
    String AUTH_TYPE = request.getAuthType();
    String REMOTE_USER = request.getRemoteUser();
    String CONTENT_TYPE = request.getContentType();
    Integer CONTENT_LENGTH = request.getContentLength();
    String HTTP_ACCEPT = request.getHeader("Accept");
    String HTTP_USER_AGENT = request.getHeader("User-Agent");
    String HTTP_REFERER = request.getHeader("Referer");
    HashMap infoMap = new HashMap();
    infoMap.put("SERVER_NAME", SERVER_NAME); infoMap.put("SERVER_SOFTWARE", SERVER_SOFTWARE); infoMap.put("SERVER_PROTOCOL", SERVER_PROTOCOL); infoMap.put("SERVER_PORT", SERVER_PORT);infoMap.put("REQUEST_METHOD", REQUEST_METHOD); infoMap.put("PATH_INFO", PATH_INFO); infoMap.put("PATH_TRANSLATED", PATH_TRANSLATED); infoMap.put("SCRIPT_NAME", SCRIPT_NAME); infoMap.put("DOCUMENT_ROOT", DOCUMENT_ROOT); infoMap.put("QUERY_STRING", QUERY_STRING); infoMap.put("REMOTE_HOST", REMOTE_HOST); infoMap.put("REMOTE_ADDR", REMOTE_ADDR); infoMap.put("AUTH_TYPE", AUTH_TYPE); infoMap.put("REMOTE_USER", REMOTE_USER); infoMap.put("CONTENT_TYPE", CONTENT_TYPE); infoMap.put("CONTENT_LENGTH", CONTENT_LENGTH); infoMap.put("HTTP_ACCEPT", HTTP_ACCEPT); infoMap.put("HTTP_USER_AGENT", HTTP_USER_AGENT); infoMap.put("HTTP_REFERER", HTTP_REFERER); Iterator it = infoMap.keySet().iterator();


%>

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
    <div style="margin-bottom: 10px;margin-top: 10px;">
            <img src="${_ctx}/resource/images/logo.png">
            <span style="font-style:normal;font-weight:900;font-size: x-large;">武汉三工光电图纸检索系统</span>

    </div>

    <div >
        <span>查询图号</span>
        <input type="text" id="searchKeyId">
        <input type="button" value="搜索" id="searchId" onclick="">
        <%--<input type="button" value="初始化" id="initId" onclick="">--%>

    </div>

    <div style="margin-top: 20px;">
        <div style="width: 15%;height:800px;float: left;border:0px solid black;">
            <select name="leftList" id="undo_redo_left" class="form-control" size="13" multiple="multiple" style="overflow:scroll;height: 95%" ></select>

            共<span id="leftNumId">0</span>条
        </div>
        <div style="width: 55px;float: left;">
            <input type="button" value="添加" id="addId" onclick="">

        </div>
        <div  style="width: 15%;height:800px;float: left;border:0px solid black;">
            <select name="rightList" id="undo_redo_right" class="form-control" size="13" multiple="multiple" style="overflow:scroll;height: 95%;"  ></select>
            共<span id="rightNumId">0</span>条
        </div>
        <div style="width: 50px;float: left;">
            <div>
                <input type="button" value="删除" id="delId" onclick="">
            </div>
            <div style="margin-top: 450px;">
                <input type="button" value="打包存档" id="packageId" onclick="" >
                <input type="button" value="清除" id="clearId" onclick="" style="margin-top: 10px;">
            </div>
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

    <div style="padding-left: 30px;width: 60%;float: left;">
        <%--
        <a href="javascript:ZoomIn()">Zoom In</a> | <a href="javascript:ZoomOut()">Zoom Out</a> | <a href="javascript:ZoomAll()">Zoom All</a>
        | <a href="javascript:ZoomWindow()">Zoom Window</a>| <a href="javascript:Pan()">Pan</a>| <a href="javascript:HideToolbar()">Show/Hide Toolbar</a>
        | <a href="javascript:HideLayoutBar()">Show/Hide LayoutBar</a>
        |<a href="javascript:Print()">Print</a>
        |<a href="javascript:Background()">Background</a>
    --%>
        <div style="display: none;">
            <p>查看本地CAD文件,仅支持（dwg,dxf,dwf）三种格式:</p>
            <input type="file" id="drawing" class="file" accept=".dwg, .dxf, .dwf" onchange="loadDWG()" style="width: 400px;" />
            <button type="button" id="btn" data-toggle="modal" data-target="#myModal" style="display: none"></button>
        </div>

        <div>
            <object id="DWGViewX" codebase="http://www.autodwg.com/dwgviewx/dwgviewx.cab" height="750"
            <%--<object id="DWGViewX" codebase="http://${header["Host"]}${_ctx}/resource/dwgviewx.cab" height="520"--%>
                    width="1000" classid="clsid:AC53EFE4-94A7-47E6-BBFC-E9B9CF322299">
                <param name="_Version" value="65536">
                <param name="_ExtentX" value="18521">
                <param name="_ExtentY" value="13758">
                <param name="_StockProps" value="0">
                <param name="DrawingFile" value="http://${header["Host"]}${_ctx}/resource/cad/009.dwg">
                <%--<param name="DrawingFile" value="http://localost:8080/cad/resource/images/009.dwg">--%>
                <param name="ShowToobar" value="-1">
                <param name="ShowLayoutBar" value="-1">

            </object>


        </div>

    </div>
    <div style="width: 100%;float: left;">
        <span style="margin-right: 100px;margin-left: 80%;font-weight: bold;">2018 V1版</span>
    </div>

    <%--
    <div>

        JSTL方式<br/>${pageContext.request}                  |取得请求对象<br>
        ${pageContext.session}                  |取得session对象<br>
        ${pageContext.request.queryString}      |取得请求的参数字符串<br>
        ${pageContext.request.requestURL}       |取得请求的URL，但不包括请求之参数字符串<br>
        ${pageContext.request.contextPath}      |服务的web application的名称<br>
        ${pageContext.request.method}           |取得HTTP的方法(GET、POST)<br>
        ${pageContext.request.protocol}         |取得使用的协议(HTTP/1.1、HTTP/1.0)<br>
        ${pageContext.request.remoteUser}       |取得用户名称<br>
        ${pageContext.session.id}               |取得session的ID<br>
        ${header["User-Agent"]}|用户浏览器的版本<br/>
        ${header["Host"]}|IP<br/>
        ${pageContext.request.remoteAddr }      |取得用户的IP地址<br>
        ${pageContext.servletContext.serverInfo}|取得主机端的服务信息<br>
        ${pageContext.request.serverPort}|端口信息<br>
        ${pageContext.request.serverName}|服务器名称<br>
        ${pageContext.request.remoteHost}|客户机名称<br>



    </div>
--%>

</body>
</html>
<script  type="text/javascript">

    var DWGViewX = document.getElementById("DWGViewX");

    $(function() {

        $("#initId").click(function(){
            window.location.href="${_ctx}/index.do";
        });

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
                            var length = cadObj.length;
                            for(var i=0;i<length;i++) {
                                var obj = cadObj[i];
                                $("#undo_redo_left").append("<option value='" + obj.id + "' path='"+obj.path+"'  >" + obj.name + "</option>");//新增
                            }
                            $("#leftNumId").html(length);

                        }
                    }
                });
            }
        });

        // enter搜索  searchId
        $("#searchKeyId").off("keydown").on("keydown", function(event) {
            if (event.keyCode == 13) {
                $("#searchId").click();
            }
        });

        //左边双击添加
        $("#undo_redo_left").off("dblclick").on("dblclick", function(event){
            $("#addId").click();
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


            var leftLen = $("#undo_redo_left")[0].options.length;
            var rightLen = $("#undo_redo_right")[0].options.length;
            $("#leftNumId").html(leftLen);
            $("#rightNumId").html(rightLen);

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
                if (op.selected) {
                    delArr.push(key);
                }
                if (mapObj[key] == null && op.selected) {
                    var path = $(op).attr("path");
                    leftObj.append("<option value='" + key + "' path='"+path+"' >" + op.text + "</option>");//新增

                }
            }

            // 删除左列表
            for (var k = 0; k < delArr.length; k++) {
                $("#undo_redo_right option[value='"+delArr[k]+"']").remove();
            }

            var leftLen = $("#undo_redo_left")[0].options.length;
            var rightLen = $("#undo_redo_right")[0].options.length;
            $("#leftNumId").html(leftLen);
            $("#rightNumId").html(rightLen);

        });

        //打包存档
        $("#packageId").off("click").on("click", function(event){
            var mapObj = {};
            var rightObj = $("#undo_redo_right");
            var rightOptions = rightObj[0].options;
            var rigthLen = rightOptions.length;
            for (var j = 0; j < rigthLen; j++) {
                var rOp = rightOptions[j];
                mapObj[rOp.value] = rOp.text;
            }

            if(isEmptyObject(mapObj)){
                alert("请先选择图纸！");
                return;
            }

            $.ajax({
                "type" : 'post',
                "url" : '${_ctx}/doPackage.do',
                "dataType" : "json",
                "async" : false,
                "data" : {
                    "mapObj":JSON.stringify(mapObj)
                },
                success : function(result) {
                    if(result!=null){
                        debugger
                        window.location.href="${_ctx}/download.do?zipFileName="+result;
                    }
                }
            });

        });

        // clearId
        $("#clearId").off("click").on("click", function(event){
            var leftObj = $("#undo_redo_left");
            var leftOp = leftObj[0].options;
            var len = leftOp.length;
            for(var i=len-1;i>=0;i--){
                var op = $(leftOp[i]);
                op.remove();
            }

            var rightObj = $("#undo_redo_right");
            var rightOp = rightObj[0].options;
            var len2 = rightOp.length;
            for(var i=len2-1;i>=0;i--){
                var op = $(rightOp[i]);
                op.remove();
            }

            var leftLen = $("#undo_redo_left")[0].options.length;
            var rightLen = $("#undo_redo_right")[0].options.length;
            $("#leftNumId").html(leftLen);
            $("#rightNumId").html(rightLen);

            $("#searchKeyId").val("");

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
                    //$("#DWGViewX param[name='DrawingFile']").val('${_ctx}/showImg.do?id='+key)
                    // 通过文件流Base64方式展示

                    $.ajax({
                        "type" : 'post',
                        "url" : '${_ctx}/showCad.do',
                        "dataType" : "json",
                        "async" : false,
                        "data" : {
                            "key":key
                        },
                        success : function(result) {
                            if(result!=null){
                                var cadFile = "http://${header['Host']}${_ctx}/resource/cad/"+result;
                                //$("#DWGViewX param[name='DrawingFile']").val(cadFile)
                                DWGViewX.SetDwgFile(cadFile);
                            }
                        }
                    });


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


    function loadDWG() {
        var dwg = $("#drawing").val();
        //debugger
        //dwg = "http://localost:8080/cad/resource/images/008.dwg";
        DWGViewX.SetDwgFile(dwg);
    }


    function isEmptyObject(obj) {
        for (var key in obj){
            return false;//返回false，不为空对象
        }
        return true;//返回true，为空对象
    }


</script>