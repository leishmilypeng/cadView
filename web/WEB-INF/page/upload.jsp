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
    <script type="text/javascript" src="${_ctx}/resource/js/lib/jquery/ajaxfileupload.js"></script>
</head>
<body onblur="self.focus()">
    <div style="margin-bottom: 10px;margin-top: 10px;">
        <jsp:include page="header.jsp"/>
    </div>

    <div>
       <span style="color: red;">注意：上传时请选择正确的CAD图纸文件！！！</span>
    </div>
    <div>
        <label>是否全局替换:</label>
        <input type="checkbox"  id="replaceAllId">
    </div>
    <%--替换图纸--%>
    <div style="float: left;">
        <label>选择新图纸</label>
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
            var checked = $("#replaceAllId").prop("checked");
            var msg = "确认替换？";
            var isReplaceAll=0;
            if(checked){
                isReplaceAll =1;
                msg = "确认替换全局图纸？";
            }
            var f = confirm(msg);
            if(f){
                $.ajaxFileUpload({
                        url:'${_ctx}/uploadSaveFiles.do?id='+selectedKey+"&isReplaceAll="+isReplaceAll, //用于文件上传的服务器端请求地址
                        secureuri: false, //是否需要安全协议，一般设置为false
                        fileElementId: 'uploadSaveFiles', //文件上传域的ID
                        dataType: 'json', //返回值类型 一般设置为json
                        success: function (data, status)  //服务器成功响应处理函数
                        {
                            alert("替换成功，请重新双击查看图纸！");
                            window.close();
                            /*
                            if(data.success) {
                                alert("替换成功，请重新查看图纸！");
                                window.close();
                            }else{
                                alert("替换失败！");
                            }
*/
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