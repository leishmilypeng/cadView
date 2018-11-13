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
    <title id ="loginTitle">修改密码</title>
    <script type="text/javascript" src="${_ctx}/resource/js/lib/jquery/jquery.js"></script>
    <script type="text/javascript" src="${_ctx}/resource/js/lib/jquery/jquery-ui.min.js"></script>
    <script type="text/javascript" src="${_ctx}/resource/js/lib/jquery/v.js"></script>
    <link rel="stylesheet" href="${_ctx}/resource/js/lib/jquery/zTree/css/metroStyle/metroStyle.css" type="text/css">
    <link href="${_ctx}/resource/css/jquery/jquery-ui.css" rel="stylesheet">
    <link href="${_ctx}/resource/css/jquery/verify.css" rel="stylesheet">

    <style>
        .labelTextClass{
            width: 150px;;
        }
    </style>
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
    <div>
        <label class="labelTextClass">原密码：</label>
        <input type="password" id="passwordOld" >
    </div>
    <div>
        <label class="labelTextClass">修改密码：</label>
        <input type="password" id="passwordNew" >
    </div>
    <div>
    <label class="labelTextClass">确认密码：</label>
        <input type="password" id="passwordCheck" >
        <input type="button" id="loginKey" value="修改密码">
    </div>
</div>

</body>
</html>
<script  type="text/javascript">


    $(function() {

        $("#loginKey").off("click").on("click", function(event){

            var passwordOld =  $("#passwordOld").val();
            if(passwordOld==""){
                alert("请输入原密码！");
                $("#passwordOld").focus();
                return;
            }
            var passwordNew =  $("#passwordNew").val();
            if(passwordNew==""){
                alert("请输入新密码！");
                $("#passwordNew").focus();
                return;
            }
            var passwordCheck =  $("#passwordCheck").val();
            if(passwordCheck==""){
                alert("请输入新密码！");
                $("#passwordCheck").focus();
                return;
            }
            if(passwordNew!=passwordCheck){
                alert("新密码与确认密码不一致，请检查！");
                $("#passwordCheck").focus();
                return;
            }
            $.ajax({
                "type" : 'post',
                "url" : '${_ctx}/modifyPass.do',
                "dataType" : "json",
                "async" : false,
                "data" : {
                    "passwordOld":passwordOld,
                    "passwordNew":passwordNew,
                    "passwordCheck":passwordCheck
                },
                success : function(result) {
                    if(result.success){
                        window.location.href="${_ctx}/toSearchPage.do";
                    }else{
                        alert(result.msg);
                    }
                }
            });


        });


    });


</script>