<%--
  Created by IntelliJ IDEA.
  User: lzf
  Date: 2017/5/14
  Time: 9:29
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <base href="<%=basePath%>">
    <!-- jsp文件头和头部 -->
    <%@ include file="../../system/index/top.jsp"%>
</head>
<body class="no-skin">
<!-- /section:basics/navbar.layout -->
<div class="main-container" id="main-container">
    <!-- /section:basics/sidebar -->
    <div class="main-content">
        <div class="main-content-inner">
            <div class="page-content">
                <div class="row">
                    <div class="col-xs-12">
                        <form action="rukubaoguo/${msg }.do" name="Form" id="Form" method="post">
                            <div id="zhongxin" style="padding-top: 13px;">
                                <table id="table_report" class="table table-striped table-bordered table-hover">
                                    <tr>
                                        <td colspan="2" style="text-align: center;">扫描包裹</td>
                                    </tr>
                                    <tr>
                                        <td colspan="2">
                                            <table id="saomiao" class="table ">
                                                <tr>
                                                    <td style="width:82px;text-align: right;padding-top: 13px;">包裹单号:</td>
                                                    <td><input type="text"  onblur="searchInfo(this)" name="baoguodanhao"  maxlength="30"  style="width:98%;"/></td>
                                                </tr>
                                            </table>
                                        </td>

                                    </tr>
                                    <tr>
                                        <td colspan="2">
                                            <div class="row">
                                                <div class="col-xs-4">
                                                    <div class="col-xs-4">
                                                        <div class="row">
                                                            <div class="col-xs-12">
                                                                <h3> 序号：</h3>
                                                            </div>
                                                        </div>
                                                        <div class="row">
                                                            <div class="col-xs-12 col-xs-offset-4">
                                                                <h3 id="xuhao">0</h3>
                                                            </div>
                                                        </div>
                                                </div>
                                                <div class="col-xs-4">
                                                    <div class="row">
                                                        <div class="col-xs-12">
                                                            <h2> 当前库位：</h2>
                                                        </div>
                                                    </div>
                                                    <div class="row">
                                                        <div class="col-xs-12 col-xs-offset-4">
                                                            <h2 id="dangqiancangwei"></h2>
                                                        </div>
                                                    </div>
                                                </div>
                                                    <div class="row">
                                                        <div class="col-xs-12">
                                                            <h2> 预警：</h2>
                                                        </div>
                                                    </div>
                                                    <div class="row">
                                                        <div class="col-xs-12 col-xs-offset-4">
                                                            <h2 id="yujinh"></h2>
                                                        </div>
                                                    </div>

                                                </div>
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="text-align: center;" colspan="10">
                                            <a class="btn btn-mini btn-primary" onclick="save();">保存</a>
                                            <a class="btn btn-mini btn-danger" onclick="top.Dialog.close();">取消</a>
                                        </td>
                                    </tr>
                                </table>
                            </div>
                            <div id="zhongxin2" class="center" style="display:none"><br/><br/><br/><br/><br/><img src="static/images/jiazai.gif" /><br/><h4 class="lighter block green">提交中...</h4></div>
                        </form>
                    </div>
                    <!-- /.col -->
                </div>
                <!-- /.row -->
            </div>
            <!-- /.page-content -->
        </div>
    </div>
    <!-- /.main-content -->
</div>
<!-- /.main-container -->


<!-- 页面底部js¨ -->
<%@ include file="../../system/index/foot.jsp"%>
<!--提示框-->
<script type="text/javascript" src="static/js/jquery.tips.js"></script>
<script type="text/javascript">
    $(top.hangge());

    $("input:last").focus();
    $(document).keydown(function (event) {
        if(13 == event.keyCode){
            $("#saomiao").append('<tr><td style="width:82px;text-align: right;padding-top: 13px;">包裹单号:</td> <td>' +
                    '<input type="text" onblur="searchInfo(this)" name="baoguodanhao"  maxlength="30"  style="width:98%;"/></td> </tr>');
            $("input:last").focus();
        }
    });

    //保存
    function save(){
        $("#Form").submit();
        $("#zhongxin").hide();
        $("#zhongxin2").show();
    }

    function searchInfo(obj){
        var baoguodanhao = $(obj).val();
        if(baoguodanhao && baoguodanhao !== ""){
            var xuhao = $("#xuhao").html();
            $("#xuhao").html((parseInt(xuhao)+1));
            $.ajax({
                type: "POST",
                url: '<%=basePath%>rukubaoguo/getkuwei.do?',
                data: {baoguodanhao:baoguodanhao},
                dataType:'json',
                cache: false,
                success: function(data){
                    var cangwei = data.cangwei;
                    var yujing = data.yujing;
                    $("#dangqiancangwei").html(cangwei);
                    if(yujing && yujing != ""){
                        $("#yujing").html(yujing);
                    }else{
                        $("#yujing").html("");
                    }

                }
            });
        }

    }

</script>
</body>
</html>
