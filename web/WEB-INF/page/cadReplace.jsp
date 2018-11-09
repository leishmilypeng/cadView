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
    <title id ="loginTitle">CAD图纸替换和删除</title>
    <link rel="icon"  href="${_ctx}/resource/images/public/favicon_02.gif" type="image/x-icon">
    <script type="text/javascript" src="${_ctx}/resource/js/lib/jquery/jquery.js"></script>
    <script type="text/javascript" src="${_ctx}/resource/js/lib/jquery/jquery-ui.min.js"></script>
    <script type="text/javascript" src="${_ctx}/resource/js/lib/jquery/v.js"></script>

    <script type="text/javascript" src="${_ctx}/resource/js/lib/bootstrap/bootstrap-modal.js"></script>
    <script type="text/javascript" src="${_ctx}/resource/js/lib/bootstrap/bootstrap.min.js"></script>
    <link rel="stylesheet" href="${_ctx}/resource/css/public.css" type="text/css">
    <link rel="stylesheet" href="${_ctx}/resource/css/bootstrap/bootstrap.min.css" type="text/css">

    <link href="${_ctx}/resource/css/jquery/jquery-ui.css" rel="stylesheet">
    <link href="${_ctx}/resource/css/jquery/verify.css" rel="stylesheet">

    <script type="text/javascript" src="${_ctx}/resource/js/lib/jquery/ajaxfileupload.js"></script>
    <%--
    <link href="${_ctx}/resource/js/lib/jquery/jquery-file-upload/css/jquery.fileupload.css" rel="stylesheet">
    <script src="${_ctx}/resource/js/lib/jquery/jquery-file-upload/js/jquery.fileupload.js" type ="text/javascript"></script>
    <script src="${_ctx}/resource/js/lib/jquery/jquery-file-upload/js/jquery.fileupload-process.js" type ="text/javascript"></script>
    <script src="${_ctx}/resource/js/lib/jquery/jquery-file-upload/js/jquery.fileupload-image.js" type ="text/javascript"></script>
    <script src="${_ctx}/resource/js/lib/jquery/jquery-file-upload/js/jquery.fileupload-validate.js" type ="text/javascript"></script>
--%>

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
    <%--
    <img src="${_ctx}/resource/images/logo.png">
    <span style="font-style:normal;font-weight:900;font-size: x-large;">武汉三工光电图纸检索系统</span>
--%>
    <jsp:include page="header.jsp"/>
    </div>

    <div>
        <%--左侧区域-菜单--%>
        <div style="width:150px;float: left; ">
            <jsp:include page="menu.jsp"/>
        </div>

        <div>
            <div >
                <span>查询图号</span>
                <input type="text" id="searchKeyId">
                <input type="button" value="搜索" id="searchId" onclick="">

            </div>

            <div style="margin-top: 20px;">
                <div style="width: 15%;height:800px;float: left;border:0px solid black;">
                    <select name="leftList" id="undo_redo_left" class="form-control" size="13" multiple="multiple" style="overflow:scroll;height: 95%" ></select>

                    共<span id="leftNumId">0</span>条
                </div>
                <div style="width: 50px;float: left;">
                    <div style="margin-top: 450px;">
                        <input type="button" value="清除" id="clearId" onclick="" style="margin-top: 10px;">
                    </div>
                </div>

            </div>

            <div style="padding-left: 30px;width: 60%;float: left;">

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

            <%--替换图纸--%>
            <div style="float: left;">
                <label>请选择新文件地址</label>
                <input type="button" value="选择文件" id="chooseFileId">
                <%--
                <input type="file" name="multipartFile" id="uploadSaveFiles" style="width: 300px !important;"/>
                <input type="button" name="确认替换" id="confirmUploadFile" value="确认替换">
                --%>
            </div>

        </div>
    </div>

    <div style="width: 100%;float: left;">
        <jsp:include page="bottom.jsp"/>
    </div>

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



        // clearId
        $("#clearId").off("click").on("click", function(event){
            var leftObj = $("#undo_redo_left");
            var leftOp = leftObj[0].options;
            var len = leftOp.length;
            for(var i=len-1;i>=0;i--){
                var op = $(leftOp[i]);
                op.remove();
            }

            var leftLen = $("#undo_redo_left")[0].options.length;
            $("#leftNumId").html(leftLen);

            $("#searchKeyId").val("");

        });

        //左边双击查看
        $("#undo_redo_left").off("dblclick").on("dblclick", function(event){
            var leftObj = $("#undo_redo_left");
            var leftOptions = leftObj[0].options;
            var leftLen = leftOptions.length;
            for (var i = 0; i < leftLen; i++) {
                var op = leftOptions[i];
                var key = op.value;
                var name = op.text;
                if(op.selected){
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


    // confirmUploadFile
    // 点击上传
    $("#confirmUploadFile").off("click").on("click", function(event){
        var leftObj = $("#undo_redo_left");
        var leftOptions = leftObj[0].options;
        var leftLen = leftOptions.length;
        var selectedKey = "";
        for (var i = 0; i < leftLen; i++) {
            var op = leftOptions[i];
            var key = op.value;
            var name = op.text;
            if (op.selected) {
                selectedKey = key;
            }
        }

        if(selectedKey==""){
            alert("请选择要替换的文件");
            return;
        }

        var f = confirm("确认是否替换？");
        if(f){
            ajaxFileUpload(selectedKey);

            /*
            $('#uploadSaveFiles').fileupload({
                url : '${_ctx }/uploadSaveFiles.do?id='+selectedKey,
                dataType : 'json',
                iframe : true,
                singleFileUploads : true,
                error: function(jqXHR, textStatus, errorThrown) {
                },
                add: function(e, data) {
                    var flag = true;
                    $.each(data.files, function(index, file){
                        var filename = file.name;
                        var filesize = file.size;
                        filename = filename.toUpperCase();
                        if(filename.indexOf(".")<0||(filename.lastIndexOf("DWG") >= 0)){
                            openDialog("请选择正确的文件格式！");
                            flag = false;
                            return false;
                        }
                        //文件大于10M不让上传 需求汪炳良 2017年8月1日
                        if(filesize > 10 * 1024 * 1024 ){
                            openDialog("上传的文件不能大于10M!");
                            flag = false;
                            return false;
                        }
                    });
                    if (flag) {
                        data.submit();
                    }
                },
                done: function(e, data) {
                    var result = eval(data.result);
                    if(result.success){
                        var fileNames="";
                        var list=result.resultList;
                        for(var i =0;i<list.length;i++){
                            fileNames+=list[i].id.fileId+",";
                        }
                        alert("上传成功！");
                    }else {
                        alert("上传失败！");
                    }
                }
            });
            */



        }
    });



    function ajaxFileUpload(selectedKey) {
        $.ajaxFileUpload({
                    url: '${_ctx }/uploadSaveFiles.do?id='+selectedKey, //用于文件上传的服务器端请求地址
                    secureuri: false, //是否需要安全协议，一般设置为false
                    fileElementId: 'uploadSaveFiles', //文件上传域的ID
                    dataType: 'json', //返回值类型 一般设置为json
                    success: function (data, status)  //服务器成功响应处理函数
                    {
                        var result = eval(data.result);
                        if(result.success){
                            alert("上传成功！");
                        }else {
                            alert("上传失败！");
                        }
                    },
                    error: function (data, status, e)//服务器响应失败处理函数
                    {
                        alert(e);
                    }
                }
        )
        return false;
    }


    $("#chooseFileId").off("click").on("click", function(event) {
        var leftObj = $("#undo_redo_left");
        var leftOptions = leftObj[0].options;
        var leftLen = leftOptions.length;
        var selectedKey = "";
        for (var i = 0; i < leftLen; i++) {
            var op = leftOptions[i];
            var key = op.value;
            var name = op.text;
            if (op.selected) {
                selectedKey = key;
            }
        }

        if (selectedKey == "") {
            alert("请选择要替换的文件");
            return;
        }
        //openwindow("${_ctx }/openUploadPage.do?id="+selectedKey,"上传图纸",650,220);
        window.open("${_ctx }/openUploadPage.do?id="+selectedKey);

    });


    function openwindow(url,name,iWidth,iHeight)
    {
        var url;                            //转向网页的地址;
        var name;                           //网页名称，可为空;
        var iWidth;                         //弹出窗口的宽度;
        var iHeight;                        //弹出窗口的高度;
        //window.screen.height获得屏幕的高，window.screen.width获得屏幕的宽
        var iTop = (window.screen.height-30-iHeight)/2;       //获得窗口的垂直位置;
        var iLeft = (window.screen.width-10-iWidth)/2;        //获得窗口的水平位置;
        window.open(url,name,'height='+iHeight+',,innerHeight='+iHeight+',width='+iWidth+',innerWidth='+iWidth+',top='+iTop+',left='+iLeft+',toolbar=no,menubar=no,scrollbars=auto,resizeable=no,location=no,status=no');
    }

</script>