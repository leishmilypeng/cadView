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
    <%--
    <img src="${_ctx}/resource/images/logo.png">
    <span style="font-style:normal;font-weight:900;font-size: x-large;">武汉三工光电图纸检索系统</span>
    --%>
    <jsp:include page="header.jsp"/>
</div>

<div>
    <label>密码：</label>
    <input type="password" id="passwordId" >
    <input type="button" id="loginKey" value="登录">
</div>

</body>
</html>
<script  type="text/javascript">


    $(function() {

        $("#loginKey").off("click").on("click", function(event){

            var password =  $("#passwordId").val();
            if(password==""){
                alert("请输入密码！");
                return;
            }
            $.ajax({
                "type" : 'post',
                "url" : '${_ctx}/login.do',
                "dataType" : "json",
                "async" : false,
                "data" : {
                    "password":password
                },
                success : function(result) {
                    if(result.success){
                        window.location.href="${_ctx}/cadReplace.do";
                    }else{
                        alert(result.msg);
                    }
                }
            });


        });


    });

    $("#confirmUploadFile").off("click").on("click", function(event){
        debugger
        ajaxFileUpload("1");

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

</script>