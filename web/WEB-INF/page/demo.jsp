<%--
  Created by IntelliJ IDEA.
  User: CPR161
  Date: 2018-10-08
  Time: 20:38
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<c:set var="_ctx" value="${pageContext.request.contextPath}"></c:set>


<script type="text/javascript" src="${_ctx}/resource/js/lib/jquery/jquery.js"></script>
<script type="text/javascript" src="${_ctx}/resource/js/lib/bootstrap/bootstrap-modal.js"></script>
<script type="text/javascript" src="${_ctx}/resource/js/lib/bootstrap/bootstrap.min.js"></script>
<link rel="stylesheet" href="${_ctx}/resource/css/public.css" type="text/css">
<link rel="stylesheet" href="${_ctx}/resource/css/bootstrap/bootstrap.min.css" type="text/css">


<html>
<head>
    <title>DWGViewX Demo-DWG Viewer ActiveX Control</title>

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
                    <param name="DrawingFile" value="http://localhost:8080/cad/resource/images/009.dwg">
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


<script>

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
        DWGViewX.SetDwgFile(dwg);
    }

</script>
