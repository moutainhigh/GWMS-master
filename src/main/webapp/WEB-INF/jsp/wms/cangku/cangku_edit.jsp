<%--
  Created by IntelliJ IDEA.
  User: lzf
  Date: 2017/4/4
  Time: 9:05
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
                        <form action="cangku/${msg }.do" name="Form" id="Form" method="post">
                            <input type="hidden" name="id" id="id" value="${cangku.id}"/>
                            <div id="zhongxin" style="padding-top: 13px;">
                                <table id="table_report" class="table table-striped table-bordered table-hover">
                                    <tr>
                                        <td style="width:82px;text-align: right;padding-top: 13px;">仓库编号:</td>
                                        <td>
                                            <input type="text"
                                                    <c:if test="${msg == 'edit' }">
                                                        disabled
                                                    </c:if>
                                                   name="cangkubianhao" id="cangkubianhao" value="${cangku.cangkubianhao}" maxlength="30"style="width:98%;"/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width:82px;text-align: right;padding-top: 13px;">仓库名称:</td>
                                        <td>
                                            <input  type="text" name="cangkuname" id="cangkuname" value="${cangku.cangkuname}"
                                                    maxlength="50" style="width:98%;"/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width:82px;text-align: right;padding-top: 13px;">仓库属性:</td>
                                        <td>
                                            <select class="chosen-select form-control" name="cangkushuxing" id="cangkushuxing" data-placeholder="请选择" style="vertical-align:top;width:98%;">
                                                <option value="">请选择</option>
                                                <c:choose>
                                                    <c:when test="${not empty dictionaries}">
                                                        <c:forEach items="${dictionaries}" var="dic" varStatus="baoguanStatus">
                                                            <option value="${dic.BIANMA}" id="${dic.BIANMA}"
                                                                    <c:if test="${dic.BIANMA == cangku.cangkushuxing}">
                                                                        selected="selected"
                                                                    </c:if>
                                                            >${dic.NAME}</option>
                                                        </c:forEach>
                                                    </c:when>
                                                </c:choose>
                                            </select>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width:82px;text-align: right;padding-top: 13px;">备注:</td>
                                        <td><textarea rows="5" cols="10" id="beizhu" name="beizhu" style="width:98%;"  title="备注">${cangku.beizhu}</textarea></td>
                                    </tr>
                                    <c:if test="${QX.adminOrder == 1 }">
                                        <tr>
                                            <td style="width:78px;text-align: right;padding-top: 13px;">创建者:</td>
                                            <td >
                                                <input type="text" disabled name="createuser" id="createuser" value="${cangku.createuser}" maxlength="255" title="申报价" style="width:98%;"/>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="width:78px;text-align: right;padding-top: 13px;">创建时间:</td>
                                            <td >
                                                <input type="text" disabled name="createtime" id="createtime" value="${cangku.formatCreateTime}" maxlength="255" title="申报价" style="width:98%;"/>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="width:78px;text-align: right;padding-top: 13px;">修改者:</td>
                                            <td >
                                                <input type="text" disabled name="updateuser" id="updateuser" value="${cangku.updateuser}" maxlength="255" title="申报价" style="width:98%;"/>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="width:78px;text-align: right;padding-top: 13px;">修改时间:</td>
                                            <td >
                                                <input type="text" disabled name="updatetime" id="updatetime" value="${cangku.formateUpdateTime}" maxlength="255" title="申报价" style="width:98%;"/>
                                            </td>
                                        </tr>
                                    </c:if>
                                    <tr>
                                        <td style="text-align: center;" colspan="10">
                                            <a class="btn btn-mini btn-primary" onclick="save();">保存</a>
                                            <a class="btn btn-mini btn-danger" onclick="top.Dialog.close();">取消</a>
                                        </td>
                                    </tr>
                                </table>
                            </div>
                        </form>
                        <div id="zhongxin2" class="center" style="display:none"><img src="static/images/jzx.gif" style="width: 50px;" /><br/><h4 class="lighter block green"></h4></div>
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
    //保存

    function save(){
        $("#Form").submit();
        $("#zhongxin").hide();
        $("#zhongxin2").show();
    }


</script>
</body>
</html>
