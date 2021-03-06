<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/pages/main/header.jsp"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<base href="<%=basePath%>">

<title>My JSP 'userListp.jsp' starting page</title>
<style type="text/css">
.modal-dialog {
	min-width: 300px;
	max-width: 560px;
}
</style>
</head>

<body>
	<jsp:include page="/WEB-INF/pages/main/top.jsp" />
	<!-- Main Container -->
	<div class="main-container container-fluid">
		<!-- Page Container -->
		<div class="page-container">

			<jsp:include page="/WEB-INF/pages/main/left_device.jsp" />

			<!-- Page Content -->
			<div class="page-content">
				<jsp:include page="/WEB-INF/pages/main/header_button.jsp" />

				<!-- Page Body -->
				<div class="page-body">

					<div class="row">
						<div class="col-xs-12 col-md-12">
							<div class="widget">
								<div class="widget-header ">
									<span class="widget-caption"><i
										class="menu-icon fa fa-users"></i>机构列表</span>

									<div class="widget-buttons">
										<a href="#" data-toggle="maximize"> <i
											class="fa fa-expand"></i> </a> <a href="#" data-toggle="collapse">
											<i class="fa fa-minus"></i> </a> <a href="#"
											data-toggle="dispose"> <i class="fa fa-times"></i> </a>
									</div>
								</div>
								<div class="widget-body">
									<div class="table-toolbar">
										<a href='#' class='btn btn-danger' id="deletes"><i
											class='fa fa-trash-o'></i>批量删除</a>&nbsp;
											<a href='#' class='btn btn-info' id="creates"><i
											class='fa fa-ok'></i>批量导入</a>&nbsp;
											<a href='#' class='btn btn-info' id="daochu_excel"><i
											class='fa fa-ok'></i>导出数据</a>&nbsp;
										<div class="btn-group pull-right"></div>
									</div>
									<table class="table table-striped table-hover table-bordered"
										id="userdatatable" style="width: 100%;">
										<thead>
											<tr role="row">
											<th><label> <input type="checkbox" id="checkedAll"> <span
													class="text"></span> </label>
											</th>
												<th>机构名称</th>
												<th>机构负责人</th>
												<th>联系电话</th>
												<th>负责人工号</th>
												<th>传真</th>
												<th>功能</th>
											</tr>
										</thead>

										<tbody>


										</tbody>
									</table>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- footer begin -->
	<jsp:include page="/WEB-INF/pages/main/footer.jsp" />
	<script
		src="<%=request.getContextPath()%>/assets/js/datatable/datatables-init-UserList.js"></script>
	<script
		src="<%=request.getContextPath()%>/assets/js/datatable/datatables-init-DeviceDetal.js"></script>
	<script>
		InitiateUserListTable.init();
		var username =null;
		$(".DTTT").css('display', 'none');
		//Delete an Existing Row
		$('#deletes').on("click", function(e) {
			e.preventDefault();
			var set = $("#userdatatable tbody tr input[type=checkbox]");
			var checked = $(this).is(":checked");
			var c = 0;
			$(set).each(function() {
				var input = this;
				if (input.checked) {
					c++;
				}
			});
			if (c < 1) {
				alert("请选择要删除的数据!");
				return false;
			}
			if (confirm("你确定要删除这" + c + "个机构吗?") == false) {
				return;
			}
			var list = [];
			$.each($(set), function(i) {
				var input = this;
				if (input.checked) {
					list[i] = $(this).val().trim();
				}
			});
			$.ajax({
				url : getRootPath() + "/hr/user/delete/" + list,
				type : "GET",
				success : function(strData) {
					alert(strData.detail);
					window.parent.location.reload();
				}
			});

		});
		$("#userdatatable").on("click", "a.role", function(e) {
			var nRow = $(this).closest('tr')[0];
			
			username = $(nRow).find("div").attr("name"); 
				var url = "<%=request.getContextPath()%>/hr/user/toEdit/"+ username;
				$(window.parent.document).find("#toTarget").attr("src",url);
				$("#personnelbtnok").attr("onclick","submitEdit()");
				$('.modal-title').text("编辑账户组信息");
					modal();
			
		});
		//导入
		$("#creates").bind("click",function(){
				var url = "<%=request.getContextPath()%>/hr/file/tofile";
				window.open(url);
				return false;
		});
		function modal() {
    	$("#myModal").on("show", function() { 
        	$("#myModal a.btn,#Close_btn").on("click", function(e) {
            $("#myModal").modal('hide'); 
        	});
    	});
	
	    $("#myModal").on("hide", function() { 
	        $("#myModal a.btn").off("click");
	    });
    
	    $("#myModal").on("hidden", function() { 
	        $("#myModal").remove();
	    });
    
	    $("#myModal").modal({ 
	        "backdrop" : "static",
	        "keyboard" : true,
	        "show" : true 
	    });
	    $("#Close_btn").click(function(){
	        $("#myModal").modal('hide');
	    })
	    
    }
    function submitEdit() {
    	$("#toTarget")[0].contentWindow.submitEdit();
    }
    	
        //导出excel
      $("#daochu_excel").bind("click",function(){
      	if(confirm("你确定要导出机构信息吗?")){
      		$.ajax({
				url : "${pageContext.request.contextPath}/manager/v1/employee/user/excel",
				type : "post",
				contentType : "application/json; charset=utf-8",
				success : function(strData) {
					alert("导出成功,已存储电脑桌面!");
					Notify('恭喜：操作成功了哟.', 'top-full-width', '2000', 'darkgray', 'fa-check', true);
				},
				error : function(strData) {
					Notify('遗憾：操作失败！', 'top-full-width', '2000', 'red', 'fa-check', true);
				}
			});
      	}
      	return false;
     });
      	//全选
       	$("#checkedAll").change(function() {
       		if($("#checkedAll").is(":checked")) {
       			$("#userdatatable tbody tr input[type=checkbox]").each(function() {
       				$(this).prop("checked", true);
       			});
       		}else {
       			$("#userdatatable tbody tr input[type=checkbox]").each(function() {
       				$(this).prop("checked", false);
       			});
       		}
       	});
	</script>
</body>
<!-- 新增账户 -->
<div id="myModal" class="modal fade">
		<div class="modal-dialog">
			<div class="modal-content" style=" width:540px; ">

				<!-- dialog body -->
				<div class=" modal-header">
					<button type="button" class="close" data-dismiss="modal">&times;</button>
					<h4 class="modal-title">机构-编辑</h4>
				</div>
				<div class=" modal-body">
					<div class="row">
						<div class="col-sm-12">

							<%-- <jsp:include page="/WEB-INF/pages/personnel/personnel_add.jsp"></jsp:include> --%>
					 <iframe id="toTarget" name="myFrame" src="" width="400px" height="500px"
							marginwidth="0" marginheight="0" frameborder="0" scrolling="no"></iframe> 
						</div>
					</div>
				</div>
				<!-- dialog buttons -->
				<div class="modal-footer">
					<input class="btn bg-blue-zdy" id="personnelbtnok" type="button" value="确定" />
					<button type="button" class="btn btn-danger font-color-btn" id="Close_btn">取消</button>
				</div>
			</div>
		</div>
	</div>
</html>
