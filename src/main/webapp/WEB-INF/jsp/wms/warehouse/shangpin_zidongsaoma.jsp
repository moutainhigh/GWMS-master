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

                        <form action="chukushangpin/${msg }.do" name="Form" id="Form" method="post">
                            <div id="zhongxin" style="padding-top: 13px;">
                                <input type="hidden" name="dangqiantiaoma" id="dangqiantiaoma" />
                                <input type="hidden" name="saomamoshi" id="saomamoshi" value="0"/>
                                <table id="table_report" class="table table-striped table-bordered table-hover">
                                    <tr>
                                        <td style="width:88px;text-align: right;padding-top: 13px;">订单号:</td>
                                        <td><input  type="text" name="dingdanhao" id="dingdanhao" maxlength="30"  style="width:98%;"/></td>
                                    </tr>
                                    <tr id="yujingtr" style="display: none">
                                        <td style="width:88px;text-align: right;padding-top: 13px;">预警:</td>
                                        <td><input readonly type="text"id="yujingstatus" maxlength="30"  style="width:98%;"/></td>
                                    </tr>
                                    <tr>
                                        <td colspan="2" style="text-align: center;">扫描条码:</td>
                                    </tr>
                                    <tr>
                                        <td colspan="2">
                                            <div style=" height:350px; overflow:scroll;">
                                            <table id="saomiao" class="table  table-bordered table-hover">
                                                <tr>
                                                    <td style="width:82px;text-align: right;padding-top: 13px;">商品条码:</td>
                                                    <td><input type="text" name="huohao" onblur="searchInfo(this)"  maxlength="30"  style="width:98%;"/></td>
                                                </tr>
                                            </table>
                                            </div>
                                        </td>

                                    </tr>
                                    <tr>
                                        <td colspan="2">
                                            <div class="row">
                                                <div class="col-xs-4">
                                                    <table id="huizong" data-height="300"  class="table table-bordered"></table>
                                                </div>
                                                <div class="col-xs-4">
                                                    <table id="mingxi" data-height="300"  class="table table-bordered"></table>
                                                </div>
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
<script type="text/javascript" src="static/ace/js/bootstrap-table.js"></script>
<script type="text/javascript" src="static/ace/js/bootstrap-table-zh-CN.js"></script>
<script type="text/javascript">
    $(top.hangge());
    $("input[name='dingdanhao']:last").focus();
    $(document).keydown(function (event) {
        if(13 == event.keyCode){
            var str = $("input:focus").attr("name");
            if("dingdanhao" === str){
                var dingdanhao = $("#dingdanhao").val();
                $.ajax({
                    type: "POST",
                    url: '<%=basePath%>innerorder/getyujing.do?',
                    data: {dingdanhao:dingdanhao},
                    dataType:'json',
                    cache: false,
                    success: function(data){
                        var yujing = data.yujing;
                        if(yujing && yujing != ""){
                            $("#yujingstatus").val(yujing);
                            $("#yujingtr").removeAttr("style");
                        }
                    }
                });
                $("input[name='huohao']:last").focus();
            }else if ("huohao" === str){
                $("#saomiao").append('<tr><td style="width:82px;text-align: right;padding-top: 13px;">商品条码:</td>' +
                        ' <td><input type="text"  onblur="searchInfo(this)" name="huohao"  maxlength="30"  style="width:98%;"/>' +
                        '</tr>');
                $("input[name='huohao']:last").focus();
            }

        }
    });
    //保存
    function save(){
        $("#Form").submit();
        $("#zhongxin").hide();
        $("#zhongxin2").show();
    }
    function huizong(){
        var option = {
            url: '${pageContext.request.contextPath}/chukushangpin/huizong.do', //请求地址
            columns: [
                {
                    field : 'tiaoma',
                    align : "center",
                    title : '商品条码'
                },
                {
                    field : 'shuliang',
                    align : "center",
                    title : '数量'
                },
                {
                    field : 'kuwei',
                    align : "center",
                    title : '库位'
                }
            ],//表格字段
            method:"post",
            search:false,
            queryParamsType : "undefined",
            queryParams:function(params) {
                var obj = $("#Form").serialize();
                return obj;
            }, //查询条件
            sidePagination: "server", //服务端请求
            singleSelect:true,//设置表格单选
            cache:false,//是否对表格数据进行缓存，默认false
            contentType:"application/x-www-form-urlencoded",//spring只有这个格式在POST请求下，才能实现
            dataType:"json"//这格式传输内容的格式
        };
        $("#huizong").bootstrapTable(option);
    }

    function mingxi(){
        var option = {
            url: '${pageContext.request.contextPath}/chukushangpin/mingxi.do', //请求地址
            columns: [
                {
                    field : 'tiaoma',
                    align : "center",
                    title : '商品条码'
                },
                {
                    field : 'shuliang',
                    align : "center",
                    title : '数量'
                },
                {
                    field : 'kuwei',
                    align : "center",
                    title : '库位'
                }
            ],//表格字段
            method:"post",
            search:false,
            queryParamsType : "undefined",
            queryParams:function(params) {
                var obj = {};
                obj["tiaoma"] = $("#dangqiantiaoma").val();
                return obj;
            }, //查询条件
            sidePagination: "server", //服务端请求
            singleSelect:true,//设置表格单选
            cache:false,//是否对表格数据进行缓存，默认false
            contentType:"application/x-www-form-urlencoded",//spring只有这个格式在POST请求下，才能实现
            dataType:"json"//这格式传输内容的格式
        };
        $("#mingxi").bootstrapTable(option);
    }

    $(function(){
        huizong();
        mingxi("");
    });

    function searchInfo(obj){
        var tiaoma = $(obj).val();
        if(tiaoma && tiaoma !== ""){
            $("#dangqiantiaoma").val(tiaoma);
            var dingdanhao = $("#dingdanhao").val();
            $("#mingxi").bootstrapTable("refresh");
            $("#huizong").bootstrapTable("refresh");
            var xuhao = $("#xuhao").html();
            $("#xuhao").html((parseInt(xuhao)+1));
            $.ajax({
                type: "POST",
                url: '<%=basePath%>chukushangpin/getkuwei.do?',
                data: {dingdanhao:dingdanhao,tiaoma:tiaoma},
                dataType:'json',
                cache: false,
                success: function(data){
                    var cangwei = data.cangwei;
                    $("#dangqiancangwei").html(cangwei);
                }
            });
        }

    }
</script>
</body>
</html>
