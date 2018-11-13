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
    <script type="text/javascript" src="${_ctx}/resource/js/lib/jquery/jquery.js"></script>
    <script type="text/javascript" src="${_ctx}/resource/js/lib/jquery/jquery-ui.min.js"></script>
    <script type="text/javascript" src="${_ctx}/resource/js/lib/jquery/v.js"></script>

    <link href="${_ctx}/resource/css/jquery/jquery-ui.css" rel="stylesheet">
    <link href="${_ctx}/resource/css/jquery/verify.css" rel="stylesheet">


    <style>
      /*  .menuClass{
            margin-top: 40px;
            margin-left: 10px;
        }*/
        .menuTextClass{
            background-color:#428bca;
            font-size: 25px;
        }
        .buttonClass{
            margin: auto;
            border: none;
            background-color: #3667d3;
            width: 125px;
            position: relative;
            top: 45px;
            border-radius: 10px;
            padding: 10px 0;
            color: #fff;
            font-size: 20px;
            font-family: 微软雅黑;
            outline: none;
            margin: 15px 10px 15px 10px  ;
        }
    </style>

</head>



<body>

    <div >
        <div>
            <input type="button" class="buttonClass menuClass" do_url="${_ctx}/toSearchPage.do"  value="图纸检索">
        </div>
        <div>
            <input type="button" class="buttonClass menuClass" do_url="${_ctx}/cadReplace.do"  value="图纸替换">
        </div>
        <div>
            <input type="button" class="buttonClass menuClass" do_url=""  value="重名识别">
        </div>
        <div>
            <input type="button" class="buttonClass menuClass" do_url=""  value="操作日志">
        </div>
        <div>
            <input type="button" class="buttonClass menuClass" do_url="${_ctx}/setPassPage.do"  value="权限管理">
        </div>
        <div>
            <input type="button" class="buttonClass menuClass" do_url=""  value="图纸借用">
        </div>
        <div>
            <input type="button" class="buttonClass menuClass" do_url=""  value="图纸管理">
        </div>
    </div>
</body>
</html>
<script  type="text/javascript">

    $(".menuClass").off("click").on("click", function(event){
        var $this = $(this);
        var doUrl = $this.attr("do_url");
        if(doUrl==""){
            alert("正在加紧开发中...");
            return;
        }else{
            window.location.href=doUrl;
        }

    });


</script>