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
    <link href="static/ace/css/bootstrap-table.min.css" rel="stylesheet"/>
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

                        <form action="pandian/${msg }.do" name="Form" id="Form" method="post">
                            <input type="hidden" name="saomamoshi" id="saomamoshi" value="1"/>
                            <div id="zhongxin" style="padding-top: 13px;">
                                <table id="table_report" class="table table-striped table-bordered table-hover">
                                    <tr>
                                        <td style="width:88px;text-align: right;padding-top: 13px;">库位:</td>
                                        <td><input  type="text" name="kuwei" id="kuwei" maxlength="30"  style="width:98%;"/></td>
                                    </tr>
                                    <tr>
                                        <td colspan="2" style="text-align: center;">扫描货号:</td>
                                    </tr>
                                    <tr>
                                        <td colspan="2">
                                            <table id="saomiao" class="table ">
                                                <tr>
                                                    <td style="width:82px;text-align: right;padding-top: 13px;">商品条码:</td>
                                                    <td><input type="text" name="shangpinbianhao"    maxlength="30"  style="width:98%;"/></td>
                                                    <td style="width:82px;text-align: right;padding-top: 13px;">数量:</td>
                                                    <td><input type="number" name="shuliang"  maxlength="30"  style="width:98%;"/></td>
                                                </tr>
                                            </table>
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
<script type="text/javascript" src="static/ace/js/bootstrap-table.js"></script>
<script type="text/javascript" src="static/ace/js/bootstrap-table-zh-CN.js"></script>
<script type="text/javascript">
    $(top.hangge());
    $("input[name='kuwei']:last").focus();
    $(document).keydown(function (event) {
        if(13 == event.keyCode){
            var str = $("input:focus").attr("name");
            if("kuwei" === str){
                $("input[name='shangpinbianhao']:last").focus();
            }else if ("shangpinbianhao" === str){
                $("input[name='shuliang']:last").focus();
            }else if ("shuliang" === str){
                 $("#saomiao").append('<tr><td style="width:82px;text-align: right;padding-top: 13px;">商品条码:</td>' +
                 ' <td><input type="text"  name="shangpinbianhao"   maxlength="30"  style="width:98%;"/>' +
                 '</td><td style="width:82px;text-align: right;padding-top: 13px;">数量:</td>' +
                 '<td><input type="number" name="shuliang"    maxlength="30"  style="width:98%;"/></td> ' +
                 '</tr>');
                $("input[name='shangpinbianhao']:last").focus();
            }

        }
    });
    //保存
    function save(){
        $("#Form").submit();
        $("#zhongxin").hide();
        $("#zhongxin2").show();
    }

</script>
</body>
</html>
