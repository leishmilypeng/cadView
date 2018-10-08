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

    <link rel="stylesheet" href="${_ctx}/resource/js/lib/jquery/zTree/css/metroStyle/metroStyle.css" type="text/css">
    <script type="text/javascript" src="${_ctx}/resource/js/lib/jquery/zTree/js/jquery-1.4.4.min.js"></script>
    <script type="text/javascript" src="${_ctx}/resource/js/lib/jquery/zTree/js/jquery.ztree.core-3.5.js"></script>
    <script type="text/javascript" src="${_ctx}/resource/js/lib/jquery/zTree/js/jquery.ztree.excheck-3.5.js"></script>
    <script type="text/javascript" src="${_ctx}/resource/js/lib/jquery/zTree/js/jquery.ztree.exedit-3.5.js"></script>

    <link href="${_ctx}/resource/css/jquery/jquery-ui.css" rel="stylesheet">
    <link href="${_ctx}/resource/css/jquery/verify.css" rel="stylesheet">
</head>
<body>

    <div >
        <input type="button" value="搜索" id="searchId" onclick="">

    </div>
    <div class="zTreeDemoBackground left">
        <ul id="treeDemo" class="ztree"></ul>
    </div>
</body>
</html>
<script  type="text/javascript">

    $("#searchId").click(function(){
        window.location.href="${_ctx}/toSearchPage.do";
    });

    var demoMsg = {
        async:"正在进行异步加载，请等一会儿再点击...",
        expandAllOver: "全部展开完毕",
        asyncAllOver: "后台异步加载完毕",
        asyncAll: "已经异步加载完毕，不再重新加载",
        expandAll: "已经异步加载完毕，使用 expandAll 方法"
    }

    var setting = {
        view: {
            selectedMulti: false
        },
        check: {
            enable: true
        },
        data: {
            simpleData: {
                enable: true
            }
        },
        key: {
            id: "id",
            name:"name",
            checked: "checked"
        },
        async: {
            enable: true,
            type: "get",
            url: "${_ctx}/getChild.do",
            dataFilter: filter,
            autoParam: ["id", "name","idDir"]
        },
        callback: {
            beforeAsync: beforeAsync,
            onAsyncSuccess: onAsyncSuccess,
            onAsyncError: onAsyncError
        }

    };

    function filter(treeId, parentNode, childNodes) {
        //debugger
        if (!childNodes) return null;
        for (var i=0, l=childNodes.length; i<l; i++) {
            childNodes[i].name = childNodes[i].name.replace(/\.n/g, '.');
        }
        return childNodes;
    }

    function beforeAsync() {
        curAsyncCount++;
    }

    function onAsyncSuccess(event, treeId, treeNode, msg) {
        curAsyncCount--;
        if (curStatus == "expand") {
            expandNodes(treeNode.children);
        } else if (curStatus == "async") {
            asyncNodes(treeNode.children);
        }

        if (curAsyncCount <= 0) {
            if (curStatus != "init" && curStatus != "") {
                $("#demoMsg").text((curStatus == "expand") ? demoMsg.expandAllOver : demoMsg.asyncAllOver);
                asyncForAll = true;
            }
            curStatus = "";
        }
    }

    function onAsyncError(event, treeId, treeNode, XMLHttpRequest, textStatus, errorThrown) {
        curAsyncCount--;

        if (curAsyncCount <= 0) {
            curStatus = "";
            if (treeNode!=null) asyncForAll = true;
        }
    }

    var curStatus = "init", curAsyncCount = 0, asyncForAll = false, goAsync = false;

    function expandAll() {
        if (!check()) {
            return;
        }
        var zTree = $.fn.zTree.getZTreeObj("treeDemo");
        if (asyncForAll) {
            $("#demoMsg").text(demoMsg.expandAll);
            zTree.expandAll(true);
        } else {
            expandNodes(zTree.getNodes());
            if (!goAsync) {
                $("#demoMsg").text(demoMsg.expandAll);
                curStatus = "";
            }
        }
    }
    function expandNodes(nodes) {
        if (!nodes) return;
        curStatus = "expand";
        var zTree = $.fn.zTree.getZTreeObj("treeDemo");
        for (var i=0, l=nodes.length; i<l; i++) {
            zTree.expandNode(nodes[i], true, false, false);
            if (nodes[i].isParent && nodes[i].zAsync) {
                expandNodes(nodes[i].children);
            } else {
                goAsync = true;
            }
        }
    }

    function asyncAll() {
        if (!check()) {
            return;
        }
        var zTree = $.fn.zTree.getZTreeObj("treeDemo");
        if (asyncForAll) {
            $("#demoMsg").text(demoMsg.asyncAll);
        } else {
            asyncNodes(zTree.getNodes());
            if (!goAsync) {
                $("#demoMsg").text(demoMsg.asyncAll);
                curStatus = "";
            }
        }
    }
    function asyncNodes(nodes) {
        if (!nodes) return;
        curStatus = "async";
        var zTree = $.fn.zTree.getZTreeObj("treeDemo");
        for (var i=0, l=nodes.length; i<l; i++) {
            if (nodes[i].isParent && nodes[i].zAsync) {
                asyncNodes(nodes[i].children);
            } else {
                goAsync = true;
                zTree.reAsyncChildNodes(nodes[i], "refresh", true);
            }
        }
    }

    function reset() {
        if (!check()) {
            return;
        }
        asyncForAll = false;
        goAsync = false;
        $("#demoMsg").text("");
        $.fn.zTree.init($("#treeDemo"), setting);
    }

    function check() {
        if (curAsyncCount > 0) {
            $("#demoMsg").text(demoMsg.async);
            return false;
        }
        return true;
    }

   // var treeNodes = '${treeNodes}';
    /*
    var zNodes =[
        { id:1, pId:0, name:"父节点1", open:true},
        { id:11, pId:1, name:"父节点11"},
        { id:111, pId:11, name:"叶子节点111"},
        { id:112, pId:11, name:"叶子节点112"},
        { id:113, pId:11, name:"叶子节点113"},
        { id:114, pId:11, name:"叶子节点114"},
        { id:12, pId:1, name:"父节点12"},
        { id:121, pId:12, name:"叶子节点121"},
        { id:122, pId:12, name:"叶子节点122"},
        { id:123, pId:12, name:"叶子节点123"},
        { id:124, pId:12, name:"叶子节点124"},
        { id:13, pId:1, name:"父节点13", isParent:true},
        { id:2, pId:0, name:"父节点2"},
        { id:21, pId:2, name:"父节点21", open:true},
        { id:211, pId:21, name:"叶子节点211"},
        { id:212, pId:21, name:"叶子节点212"},
        { id:213, pId:21, name:"叶子节点213"},
        { id:214, pId:21, name:"叶子节点214"},
        { id:22, pId:2, name:"父节点22"},
        { id:221, pId:22, name:"叶子节点221"},
        { id:222, pId:22, name:"叶子节点222"},
        { id:223, pId:22, name:"叶子节点223"},
        { id:224, pId:22, name:"叶子节点224"},
        { id:23, pId:2, name:"父节点23"},
        { id:231, pId:23, name:"叶子节点231"},
        { id:232, pId:23, name:"叶子节点232"},
        { id:233, pId:23, name:"叶子节点233"},
        { id:234, pId:23, name:"叶子节点234"},
        { id:3, pId:0, name:"父节点3", isParent:true}
    ];
    */
    //var zNodes = $.parseJSON(treeNodes);

    $(document).ready(function(){
            $.fn.zTree.init($("#treeDemo"), setting);
    });

    var newCount = 1;



</script>