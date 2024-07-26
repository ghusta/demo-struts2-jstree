<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html lang="en">
<%
  pageContext.setAttribute("ctx", request.getContextPath());
%>
<head>
    <title><s:text name="HelloWorld.message"/></title>

    <script src="${pageContext.request.contextPath}/webjars/jquery/3.7.1/jquery.min.js"></script>
    <script src="${pageContext.request.contextPath}/webjars/jstree/3.3.16/jstree.min.js"></script>

    <link rel="stylesheet" href="${pageContext.request.contextPath}/webjars/bootstrap/5.3.3/css/bootstrap.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/webjars/jstree/3.3.16/themes/default/style.min.css">

    <script>
    $( document ).ready(function() {
        let jqVersion = $().jquery;
        console.log( "JQuery version loaded : " + jqVersion );
        console.log( "JSTree version loaded : " + $.jstree.version );

        // init demo jstree
        $('#jstree_demo_div').jstree({
            'core' : {
                'data' : {
                    'url' : function(node) {
                        return "${pageContext.request.contextPath}/example/JsonTree.action";
                     },
                     'data': function(node) {
                         return {
                             'id': node.id
                         };
                     }
                }
            }
        });
        $('#jstree_demo_div').on("changed.jstree", function (e, data) {
            console.log(data.selected);
        });

        // init jstree #2
        $('#using_json_2').jstree({ 'core' : {
            "multiple" : false,
            'data' : [
               { "id" : "ajson1", "parent" : "#", "text" : "Simple root node" },
               { "id" : "ajson2", "parent" : "#", "text" : "Root node 2" },
               { "id" : "ajson3", "parent" : "ajson2", "text" : "Child 1" },
               { "id" : "ajson4", "parent" : "ajson2", "text" : "Child 2" },
            ]
        } });
        $('#using_json_2').on("changed.jstree", function (e, data) {
            console.log("--------------------------------------------------------");
            console.log("Selection : " , data.selected);
            let node = data.instance.get_node(data.selected[0]);
            console.log("Node : ", node);
            let isLeaf = data.instance.is_leaf(data.selected[0]);
            console.log("is leaf 🍃 : ", isLeaf);
        });
    });

    function callAjax() {
        $.ajax({
            url: "${pageContext.request.contextPath}/example/JsonTest.action",
            type: 'POST',
            beforeSend: function() {
                $('#bloc-1').html("<div class='text-bg-light p-3'>...</div>");
                $("#btn-test-1").hide();
                $("#btn-test-1-loading").show();
            },
            success: function(data) {
                console.debug("Data : ", data);
                if (data.message !== undefined) {
                    $('#bloc-1').html("<div class='text-bg-light p-3'>" + data.message + "</div>");
                }
            }
        })
        .done(function( data ) {
            $("#btn-test-1").show();
            $("#btn-test-1-loading").hide();
        });
    }
    </script>
</head>
<body>
<div class="container">
<h2><s:property value="message"/></h2>

<h3 class="mt-1">Languages</h3>
<ul>
    <li>
        <s:url var="url" action="HelloWorld">
            <s:param name="request_locale">en</s:param>
        </s:url>
        <s:a href="%{url}">English</s:a>
    </li>
    <li>
        <s:url var="url" action="HelloWorld">
            <s:param name="request_locale">es</s:param>
        </s:url>
        <s:a href="%{url}">Espanol</s:a>
    </li>
</ul>

<h3 class="mt-1">AJAX Test</h3>
<button id="btn-test-1" onclick="callAjax()" class="btn btn-outline-primary">Test</button>
<button id="btn-test-1-loading" class="btn btn-primary" style="display: none;" type="button" disabled>
  <span class="spinner-border spinner-border-sm" aria-hidden="true"></span>
  <span role="status">Loading...</span>
</button><div id="bloc-1"></div>

<h3 class="mt-1">Trees</h3>
<h4>Ajax with JSON tree</h4>
<div id="jstree_demo_div"></div>
<hr/>
<h4>Non-ajax with local JSON tree</h4>
<div id="using_json_2"></div>

<h3 class="mt-1">Debug</h3>
<a href="${pageContext.request.contextPath}/config-browser/index.action" target="_blank">Struts Config Browser</a>

</div>
</body>
</html>
