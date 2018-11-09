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
    <title id ="loginTitle">菜单</title>
    <link rel="icon"  href="${_ctx}/resource/images/public/favicon_02.gif" type="image/x-icon"></link>
    <script type="text/javascript" src="${_ctx}/resource/js/lib/jquery/jquery.js"></script>
    <script type="text/javascript" src="${_ctx}/resource/js/lib/jquery/jquery-ui.min.js"></script>
    <script type="text/javascript" src="${_ctx}/resource/js/lib/jquery/v.js"></script>

    <link href="${_ctx}/resource/css/jquery/jquery-ui.css" rel="stylesheet">
    <link href="${_ctx}/resource/css/jquery/verify.css" rel="stylesheet">


    <style>
        .menuClass{
            margin-top: 40px;
            margin-left: 10px;
        }
    </style>

</head>



<body>

    <div >
        <div class="menuClass" do_url="${_ctx}/toSearchPage.do">图纸检索</div>
        <div class="menuClass" do_url="${_ctx}/cadReplace.do">图纸替换</div>
        <div class="menuClass" do_url="">重名识别</div>
        <div class="menuClass" do_url="${_ctx}/showLog.do">操作日志</div>
        <div class="menuClass" do_url="${_ctx}/setPassPage.do">权限管理</div>
        <div class="menuClass" do_url="">图纸借用</div>
        <div class="menuClass" do_url="">图纸管理</div>
    </div>
</body>
</html>
<script  type="text/javascript">

    $(".menuClass").off("click").on("click", function(event){
        var $this = $(this);
        var doUrl = $this.attr("do_url");
        if(doUrl==""){
            alert("功能正在加紧开发中...");
            return;
        }else{
            window.location.href=doUrl;
        }

    });


</script>