<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: CPR161
  Date: 2018-09-19
  Time: 19:03
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<c:set var="_ctx" value="${pageContext.request.contextPath}"/>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <meta name="viewport" content="width=device-width, minimum-scale=1, maximum-scale=1">
    <meta name="apple-mobile-web-app-status-bar-style" content="black" />
    <meta name="format-detection" content="telephone=no" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
    <title id ="loginTitle">图纸管理</title>
    <script type="text/javascript" src="${_ctx}/resource/js/lib/jquery/jquery.js"></script>
    <script type="text/javascript" src="${_ctx}/resource/js/lib/jquery/jquery-ui.min.js"></script>
    <script type="text/javascript" src="${_ctx}/resource/js/lib/jquery/v.js"></script>
    <link href="${_ctx}/resource/css/jquery/jquery-ui.css" rel="stylesheet">
    <link href="${_ctx}/resource/css/jquery/verify.css" rel="stylesheet">

    <script type="text/javascript" src="${_ctx}/resource/js/lib/jquery/ajaxfileupload.js"></script>
</head>
<body>
    <div style="margin-bottom: 10px;margin-top: 10px;">
        <jsp:include page="header.jsp"/>
    </div>

    <%--替换图纸--%>
    <div style="float: left;">
        <label>请选择新文件地址</label>
        <input type="file" name="multipartFile" id="uploadSaveFiles" style="width: 300px !important;">
        <input type="button" name="确认替换" id="confirmUploadFile" value="确认替换">
    </div>

</body>
</html>
<script  type="text/javascript">

    $(function() {
        $("#confirmUploadFile").off("click").on("click", function(){
            var id =  "${id}";
            ajaxFileUpload(id);
        });

        function ajaxFileUpload(selectedKey) {
            var f = confirm("确认是否替换？");
            if(f){
                $.ajaxFileUpload({
                        url:'${_ctx}/uploadSaveFiles.do?id='+selectedKey, //用于文件上传的服务器端请求地址
                        secureuri: false, //是否需要安全协议，一般设置为false
                        fileElementId: 'uploadSaveFiles', //文件上传域的ID
                        dataType: 'json', //返回值类型 一般设置为json
                        success: function ()  //服务器成功响应处理函数
                        {

                            alert("替换成功，请重新查看图纸！");
                            window.close();

                        },
                        error: function (data, status, e)//服务器响应失败处理函数
                        {
                            alert(e);
                        }
                    });
            }
            return false;
        }


    });



</script>