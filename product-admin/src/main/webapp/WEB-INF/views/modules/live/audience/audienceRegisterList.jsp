<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>观众登记管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		function page(n,s){
			if(n) $("#pageNo").val(n);
			if(s) $("#pageSize").val(s);
			$("#searchForm").attr("action","${ctx}/live/audienceRegister/list");
			$("#searchForm").submit();
	    	return false;
	    }
		
		function addToBacklist(){
			var audienceId = $("input[name='id']:checked").attr("audienceId");
	    	if(!audienceId){
				alert("请选择要加入黑名单的观众！");
				return false;
			}
	    	top.$.jBox.open("get:${ctx}/live/audienceRegister/audienceRegisterBacklistForm", "添加观众到黑名单",310,230,{
				buttons:{"确定":"ok","关闭":true}, bottomText:"",submit:function(v, h, f){
					if (v=="ok"){
						var audienceId = $("input[name='id']:checked").attr("audienceId");
						var roomId = $("input[name='id']:checked").attr("roomId");
						var reason = $(h).find("#otherReason").val();
						if($.trim(reason) == ''){
							alert("亲.请输入理由哦~");
							return false;
						}
						$.ajax({
							url: "${ctx}/live/audienceRegister/addBlacklist",
							data: {
								audienceId: audienceId,
								roomId: roomId,
								reason: reason
							},
							type:"post",
							dataType:"json",
							success: function( data ) {
								if(data && data.result == 'success'){
									alert('加入黑名单成功！');
									window.location.reload();
								} else {
									alert('加入黑名单失败！');
								}
							}
						});
					}
				}, loaded:function(h){
					$(".jbox-content", top.document).css("overflow-y","hidden");
				}
			});
		}

		function exportValidate() {
			var searchType = $('#searchType').val()
			var name = $('#name').val();
			var roomId = $('#roomId').val();
			var registerTimeFrom = $('#registerTimeFrom').val();
			var registerTimeTo = $('#registerTimeTo').val();
			var expParams = 'searchType=' + searchType + '&name=' + name + '&roomId=' + roomId + '&registerTimeFrom=' + registerTimeFrom + '&registerTimeTo=' + registerTimeTo;

			window.location.href = ("${ctx }/live/audienceRegister/export?" + expParams);
		}
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li class="active"><a href="${ctx}/live/audienceRegister/list">观众登记列表</a></li>
	</ul>
	<form:form id="searchForm" modelAttribute="audienceRegister" action="${ctx}/live/audienceRegister/list" method="post" class="breadcrumb form-search ">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<sys:tableSort id="orderBy" name="orderBy" value="${page.orderBy}" callback="page();"/>
		<ul class="ul-form">
			<li>
				<label>
					<form:select path="searchType" class="input-small" id="searchType">
						<form:option value="1" label="用户名"/>
						<form:option value="2" label="公司名"/>
						<form:option value="3" label="邮箱"/>
					</form:select>
				</label>
				<form:input id="name" path="name" htmlEscape="false" maxlength="50" class="input-small" cssStyle="margin-left: 38px;width: 180px;"/>
			</li>
			<li>
			<form:select path="roomId" class="input-xlarge required" id="roomId">
            	<form:option value="">全部直播</form:option>
	            <c:forEach items="${fns:getRoomList()}" var="room">
	           		<form:option value="${room.id }">${room.name }</form:option>
	            </c:forEach>
            </form:select>
            <c:if test="${fn:length(page.list)>0 }">
	            <shiro:hasPermission name="live:audienceRegister:export">
		            <li style="float:right;">
		                <a href="#" class="fr fz14 mr20" onclick="return exportValidate();">导出全部观众>></a>
		            </li>
	            </shiro:hasPermission>
            </c:if>
            <li class="clearfix"></li>
            </li>
		</ul>
        <ul class="ul-form">
			<li>登记时间：</li>
	           <li>
	           <input id="registerTimeFrom"  name="registerTimeFrom"  type="text" readonly="readonly" maxlength="20" class="input-medium Wdate required" style="width:163px;"
	               value="<fmt:formatDate value="${audienceRegister.registerTimeFrom}" pattern="yyyy-MM-dd HH:mm"/>"
	                   onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm'});"/>
	           </li>
	           <li>至</li>
	           <li>
	           <input id="registerTimeTo"  name="registerTimeTo"  type="text" readonly="readonly" maxlength="20" class="input-medium Wdate required" style="width:163px;"
	               value="<fmt:formatDate value="${audienceRegister.registerTimeTo}" pattern="yyyy-MM-dd HH:mm"/>"
	                   onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm'});"/>
	           </li>
			<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询" onclick="return page();"/></li>
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead><tr>
			<th></th>
			<th width="18%">直播主题</th>
			<th width="12%">登记时间</th>
			<th width="12%">用户名</th>
			<th width="12%">姓名</th>
			<th width="18%">公司名</th>
			<th width="10%">职位</th>
			<th width="10%">注册邮箱</th>
			<shiro:hasPermission name="live:audienceRegister:view">
				<th width="10%">操作</th>
			</shiro:hasPermission>
		</tr></thead>
		<tbody>
		<c:forEach items="${page.list}" var="audienceRegister">
			<tr>
				<td>
					<input type="radio" name="id" value="${audienceRegister.id }" roomId="${audienceRegister.room.id }" audienceId="${audienceRegister.audienceId }"/>
				</td>
				<td>${audienceRegister.room.name }</td>
				<td><fmt:formatDate value="${audienceRegister.createDate }" pattern="yyyy-MM-dd HH:mm"/></td>
				<td>${audienceRegister.user.account }</td>
				<td>${audienceRegister.name }</td>
				<td>${audienceRegister.company }</td>
				<td>${audienceRegister.job }</td>
				<td>${audienceRegister.user.email }</td>
				<shiro:hasPermission name="live:audienceRegister:view">
				<td>
	   				<a href="${ctx}/live/audienceRegister/form?id=${audienceRegister.id}">查看</a>
				</td>
    			</shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<shiro:hasPermission name="live:audienceRegister:blacklist">
    <div>
        <c:if test="${fn:length(page.list)>0 }">
            <input type="button" class="btn btn-primary" onclick="addToBacklist()" value="加入黑名单"/>&nbsp;
        </c:if>
    </div>
    </shiro:hasPermission>
	<div class="pagination">${page}</div>
</body>
</html>