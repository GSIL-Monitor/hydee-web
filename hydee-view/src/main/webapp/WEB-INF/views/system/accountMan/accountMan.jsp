<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ include file="/include.inc.jsp"%>
<style type="text/css">
	.compTips{
		background-color: white;
		border: 1px #cacaca solid;
		width: 200px;
		max-height: 200px;
		overflow-x: hidden;
		position: absolute;
		display: none;
		z-index: 200;
	}
	.compTips li {
		width: 100%;
		display: inline-block;
		overflow: hidden;
		cursor: pointer;
		margin: 1px 0 1px 0;
	}
	.compTips li:HOVER {
		background: #E6E6FA;
	}
</style>
<div class="right-main">
	<div class="table-height30 marginTop20 right-main-top">
		<a href="javascript:;"
			class="width80 fakeBtn-hover-crimson floatLeft addAccount">新建账户</a>
		<div class="floatRight">
			<label class="positionRelative width250" id="searchForm">
				<select class="xiala" name="findType" id="findType">
					<option value="0" <c:if test="${page.findType == '0'}">selected</c:if>>全部</option>
					<option value="1" <c:if test="${page.findType == '1'}">selected</c:if>>厂商</option>
					<option value="2" <c:if test="${page.findType == '2'}">selected</c:if>>连锁</option>
				</select>
				<input type="text" id="keywords" name="keywords" class="labelInput width250 verticalMJ" maxlength="14" autocomplete="off" placeholder="按厂商搜索" value="${page.keywords}"> 
				<input type="button" class="btn-hover-blue searchBtn" value="搜索">
			</label>
		</div>
		<div class="clear"></div>
	</div>
	<ul class="ul-table-tHeader marginTop20 paddingLR20">
		<li class="width100">身份</li>
		<li class="width200">公司名称</li>
		<li class="width100">账号</li>
		<li class="width70">角色</li>
		<li class="width140">创建时间</li>
		<li class="width140">最后登录时间</li>
		<li class="width80">状态</li>
		<li class="width180 textAlignC">操作</li>
		<div class="clear"></div>
	</ul>
	<c:forEach items="${reList}" var="item">
		<ul class="ul-table-tBody  paddingLR20"
			style="height:60px; padding-top:10px;">
			<li class="width100">${item.xmCustomerId == null ? '厂商' : '连锁'}</li>
			<li class="width200">${item.company == null ? '暂无' : item.company}</li>
			<li class="width100">${item.userName}</li>
			<li class="width70">${item.roleName}</li>
			<li class="width140">${item.createTimeFmt}</li>
			<li class="width140">${item.lastLoginTimeFmt == null ? '尚未登录' : item.lastLoginTimeFmt}</li>
			<li class="width80">
				<c:choose>
					<c:when test="${item.status==1}">已启用</c:when>
					<c:when test="${item.status==2}">已锁定</c:when>
					<c:when test="${item.status==3}">待审核</c:when>
					<c:when test="${item.status==4}">审核不通过</c:when>
				</c:choose>
			</li>
			<li class="width180 textAlignC" uid="${item.id}">
				<a class="operation disInlineBlock btn_update">修改</a> 
				<c:choose>
					<c:when test="${item.status==1}">
						<a class="operation disInlineBlock btn_update_status" status="2">禁用</a>
						<a class="operation disInlineBlock btn_resetPwd">重置密码</a> 
					</c:when>
					<c:when test="${item.status==2}">
						<a class="operation disInlineBlock btn_update_status" status="1">启用</a>
					</c:when>
					<c:when test="${item.status==3}">
						<a class="operation disInlineBlock btn_authPass">审核通过</a>
						<a class="operation disInlineBlock btn_update_status" status="4">审核不通过</a>
					</c:when>
					<c:when test="${item.status==4}"></c:when>
				</c:choose>
			</li>
			<div class="clear"></div>
		</ul>
	</c:forEach>

	<div class="tcdPageCode" count="${page.totalResult}" page="${page.currentPage}" form="/view/accountMan" filter="#searchForm"></div>
</div>

<div class="bgShow"></div>

<div class="floatLayer width600 addAccountSel">
	<div class="header">新建账户</div>
	<div id="userParms" class="main">
		<input id="id" type="hidden">
		<ul class="ul-info table-height30">
			<li class="width80 textAlignR marginRight10"></li>
			<li>
				<label class="input">
					<input type="radio" name="isChain" rid="0" checked="checked"/>厂家
					<input type="radio" name="isChain" rid="1"/>连锁
				</label>
			</li>
			<div class="clear"></div>
		</ul>
		<ul class="ul-info table-height30">
			<li class="width80 textAlignR marginRight10">公司名称</li>
			<li><label class="input"> <input id="customerId"
					type="text" style="display: none;"> <input id="company"
					type="text" cid="" class="labelInput width200" ctype="required">
				<div id="compTips" class="compTips">
					<ul>
						<li style="display:none;"></li>
						<c:forEach var="item" items="${compList}" varStatus="s">
							<li cid="${item.customerId}">${item.companyName}</li>
						</c:forEach>
					</ul>
				</div>
			</label></li>
			<div class="clear"></div>
		</ul>
		<ul class="ul-info table-height30" id="xmUserId">
			<li class="width80 textAlignR marginRight10">小蜜用户</li>
			<li>
				<label class="input">
					<input id="xmBindUserId" cid="" type="text" class="labelInput width200">
					<div id="userTips" class="compTips">
						<ul id="userUl">
							<li style="display:none;"></li>
							<%--<li cid="${item.customerId}">${item.companyName}</li>--%>
						</ul>
					</div>
				</label>
			</li>
			<div class="clear"></div>
		</ul>
		<ul class="ul-info table-height30">
			<li class="width80 textAlignR marginRight10">联系人姓名</li>
			<li><label class="input"> <input id="realName"
					type="text" class="labelInput width200" ctype="required">
			</label></li>
			<div class="clear"></div>
		</ul>
		<ul class="ul-info table-height30">
			<li class="width80 textAlignR marginRight10">联系人手机</li>
			<li><label class="input"> <input id="userPhone"
					type="text" class="labelInput width200" ctype="mobile">
			</label></li>
			<div class="clear"></div>
		</ul>
		<ul class="ul-info table-height30">
			<li class="width80 textAlignR marginRight10">电子邮箱</li>
			<li><label class="input"> <input id="email" type="text"
					class="labelInput width200" ctype="email">
			</label></li>
			<div class="clear"></div>
		</ul>
		<ul class="ul-info table-height30">
			<li class="width80 textAlignR marginRight10">登陆账号</li>
			<li><label class="input"> <input id="userName"
					type="text" class="labelInput width200" ctype="username">
			</label></li>
			<div class="clear"></div>
		</ul>
		<ul class="ul-info table-height30" id="pwd">
			<li class="width80 textAlignR marginRight10">密码</li>
			<li><label class="input"> <input id="userPassword"
					type="password" class="labelInput width200" ctype="password">
			</label></li>
			<div class="clear"></div>
		</ul>
		<ul class="ul-info table-height30">
			<li class="width80 textAlignR marginRight10">所属角色</li>
			<li><label class="input"> 
				<select id="roleId" class="width200 xiala" ctype="required" errtips="您尚未创建任何角色">
					<c:forEach items="${roleList}" var="item" varStatus="s">
						<option value="${item.roleId}">${item.roleName}</option>
					</c:forEach>
				</select>
			</label></li>
			<div class="clear"></div>
		</ul>

		<ul class="ul-info table-height30">
			<li class="width80 textAlignR marginRight10">佣金</li>
			<li style="margin-right:10px;">每领一次红包，平台服务费</li>
			<li class="width130">
				<label class="input">
					<label class="inputLabel" ></label>
					<input type="text" id="serveCharge" ctype="double" class="labelInput width80 " autocomplete="off" placeholder="0.3">
				</label>
				<span class="marginLeft5">元</span>
			</li>
			<div class="clear"></div>
		</ul>
		<c:if test="${false}"><%-- 以前设计的百分比， 后面不要 --%>
			<ul class="ul-info table-height30">
				<li class="width80 textAlignR null marginRight10"></li>
				<li style="margin-right:10px;">用户领取红包，按红包金额百分比抽取佣金</li>
				<li class="width130">
					<label class="input">
						<label class="inputLabel" ></label>
						<input type="text" id="serveChargePercent" ctype="double" class="labelInput width80 " autocomplete="off" placeholder="2">
					</label>
					<span class="marginLeft5">%</span>
				</li>
				<div class="clear"></div>
			</ul>
		</c:if>
	</div>
	<div class="footer">
		<input type="button" value="确定"
			class="floatLayerSure btn-hover-crimson width80 marginRight10">
		<input type="button" value="取消"
			class="floatLayerCancel btn-hover-crimson width80">
	</div>
</div>

<div class="shadowWhite displayNone redistribution">
	<!--审核通过-->
	<div class="contentWrapper">
		<div class="content">
			<div class="detailTitle">审核通过</div>
			<div class="div-line"></div>
			<input id="authId" type="text" style="display: none;">
			<ul class="ul-info table-height30" style="margin-top:70px; margin-left:90px;">
				<li class="width80" style="font-size:16px;">所属角色</li>
				<li class="width180"><label> 
				<select id="authRid" class="xiala" style="width:100px; height:30px; font-size:16px;" ctype="required" errtips="您尚未创建角色">
					<c:forEach items="${roleList}" var="item" varStatus="s">
						<option value="${item.roleId}">${item.roleName}</option>
					</c:forEach>
				</select></label></li>
				<div class="clear"></div>
			</ul>
		</div>
		<div class="btn-wraper width360">
			<input type="button" value="确定" class="btn-hover-crimson marginRight10 btnForSure"> 
			<input type="button" value="取消" class="btn-line-crimson btnCancel">
		</div>
	</div>
</div>

<div class="shadowWhite displayNone increaseBonus">
	<div class="contentWrapper">
	<div class="content">
	<div class="detailTitle">修改密码</div>
	<div class="div-line" style="margin-bottom:50px;"></div>
		<input id="updatePwdId" type="text" style="display: none;">
		<ul class="ul-info table-height30">
		<li class="width80">新密码</li>
		<li class="width180"><input id="userPasswordEx" type="password" class="width250" ctype="password"></li>
		<div class="clear"></div>
		</ul>
		<ul class="ul-info table-height30">
		<li class="width80">密码确认</li>
		<li class="width180"><input id="passwordRepaet" type="password" class="width250" ctype="required"></li>
		<div class="clear"></div>
		</ul>
	</div>
	<div class="btn-wraper width360">
	<input type="button" value="确定" class="btn-hover-crimson marginRight10 btnForSure">
	<input type="button" value="取消" class="btn-line-crimson btnCancel">
	</div>
	</div>
</div>



<script type="text/javascript">
	var compTipsDiv = $("#compTips");
	var userTipsDiv = $("#userTips");
	var _isChain = $('input:radio[name=isChain]:checked').attr("rid");
	$(function(){
		dimSearchCompany();
		$("input:radio[name='isChain']").bind("change", function() {
			_isChain = $(this).attr("rid");
			dimSearchCompany();
		});

	});

	function dimSearchCompany(){
		if(_isChain == 1){
			$("#xmUserId").show();
			if($("#company").length > 0){
//				compTipsDiv.css("left",$("#company").position().left+460+"px");
//				compTipsDiv.css("top",($("#company").position().top+$("#company").height())+315+"px");
				$("#company").bind("keyup",function(){
					var _keyword = $(this).val(),
							v = _keyword.replace(/^\s+|\s+$/g,""),
							trs = compTipsDiv.find("li:gt(0)");
					compTipsDiv.show();
					if(v==""){
						trs.filter(":hidden").show();
					}else{
						trs.hide().filter(":contains('"+_keyword+"')").show();
					}
				});
				$("#compTips li").bind("click",function(){
					$("#company").val($(this).html());
					$("#company").attr("cid",$(this).attr("cid"));
					dimSearchXmUser($(this).attr("cid"));
				});
				$(document).click(function() {
					compTipsDiv.hide();
				});
			}
		}else{
			compTipsDiv.hide();
			$("#xmUserId").hide();
			$("#company").unbind("keyup");

		}
	}

	function dimSearchXmUser(_xmCustomerId){
		$.ajax({
			url 	 : "${mvcPath}/view/accountMan/queryXmUserId",
			type 	 : "post",
			dataType : "json",
			data 	 : {customerId :_xmCustomerId},
			success  : function(data, textStatus, XMLHttpResponse) {
				if(data.result){
					var _userUl = $("#userUl");
					_userUl.empty();
					var _mobileUsers = data.data.mobileUsers;
					for(var i = 0;i<_mobileUsers.length;i++){
						var _mobileUser = _mobileUsers[i];
						var _html = '<li cid="'+_mobileUser.userId+'">'+_mobileUser.userName+'</li>';
						_userUl.append(_html);
					}
					dimXmUser();
				}
			}
		});
	}

	function dimXmUser(){
		if(_isChain == 1){
			if($("#xmBindUserId").length > 0){
//				userTipsDiv.css("left",$("#xmBindUserId").position().left+460+"px");
//				userTipsDiv.css("top",($("#xmBindUserId").position().top+$("#xmBindUserId").height())+315+"px");
				$("#xmBindUserId").bind("keyup",function(){
					var _keyword = $(this).val(),
							v = _keyword.replace(/^\s+|\s+$/g,""),
							trs = userTipsDiv.find("li:gt(0)");
					userTipsDiv.show();
					if(v==""){
						trs.filter(":hidden").show();
					}else{
						trs.hide().filter(":contains('"+_keyword+"')").show();
					}
				});
				$("#userTips li").bind("click",function(){
					$("#xmBindUserId").val($(this).html());
					$("#xmBindUserId").attr("cid",$(this).attr("cid"));
				});
				$(document).click(function() {
					userTipsDiv.hide();
				});
			}
		}else{
			userTipsDiv.hide();
			$("#xmBindUserId").unbind("keyup");
		}
	}



    $(".addAccount").bind("click",function(){
    	$("#userParms input").val("");
    	$("#pwd").show();
    	$("#userPassword").attr("ctype","password");
    	$(".addAccountSel .header:eq(0)").html("新建账户");
    	$(".addAccountSel,.bgShow").fadeIn();
    });
    
    $(".floatLayerCancel,.btnCancel").bind("click",function(){
    	$(".increaseBonus,.addAccountSel,.bgShow,.redistribution").fadeOut();
    })
    
    $(".floatLayerSure").click(function(){
    	var params = $("#userParms").params();
		if(_isChain == 1){
			var _customerId = $("#company").attr("cid");
			var _bindUserId = $("#xmBindUserId").attr("cid");
			if(isNull(_customerId)){
				$.hd.tips($("#company"),"此项为必填项!");
				return;
			}
			if(isNull(_bindUserId)){
				$.hd.tips($("#xmBindUserId"),"此项为必填项!");
				return;
			}
			params.xmCustomerId = _customerId;
			params.xmBindUserId = _bindUserId;

		}
    	if(params == null) return false;
    	$.ajax({
			url 	 : "${mvcPath}/view/accountMan/saveOrUpdate",
			type 	 : "post",
			dataType : "json",
			data 	 : params,
			success  : function(data, textStatus, XMLHttpResponse) {
				if(data.result){
					$(".addAccountSel,.bgShow").fadeOut();
//			    	if(window.confirm($("#id").val().length ==0 ? "账户新增成功!" : "账户修改成功!")){
						refreshPage();
//					};
				}else{
					switch (data.status) {
					case 1005:
						// 机构名被占用
						$.hd.tips($("#company"), data.errors);
						break;
					case 1001:
						// 用户名被占用
						$.hd.tips($("#userName"), data.errors);
						break;
					case 1045:
						// 该员工不存在
						$.hd.tips($("#xmBindUserId"), data.errors);
						break;
					case 1046:
						// 该员工没有登录过小蜜
						$.hd.tips($("#xmBindUserId"), data.errors);
						break;
					default:
						$.hd.alertMsg.error(data.errors || "服务器繁忙,稍后请重试!");
						break;
					}
				}
			}
		});
    });
    
    $(".btn_update").click(function(){
    	var _this = $(this),
    		_uid = _this.parent().attr("uid");
    	$.ajax({
			url 	 : "${mvcPath}/view/accountMan/detail",
			type 	 : "post",
			dataType : "json",
			data 	 : {userId :_uid},
			success  : function(data, textStatus, XMLHttpResponse) {
				if(data.result){
					var _user = data.data.user;
					for(var key in _user){
						if(key == "xmCustomerId"){
							if(!isNull(_user[key])){
								var _company = data.data.company;
								$("#company").attr("cid",_user[key]);
								$("#company").val(_company.companyName);
								$('input:radio[name=isChain][rid="1"]').attr("checked","checked");
								_isChain = 1;
								dimSearchCompany();
								dimSearchXmUser(_user[key]);
							}
						}else if(key == "xmBindUserId"){
							if(!isNull(_user[key])){
								var _mobileUser = data.data.mobileUser;
								$("#xmBindUserId").attr("cid",_user[key]);
								$("#xmBindUserId").val(_mobileUser.userName);
							}
						}else{
							$("#"+key).val(_user[key]);
						}
		            }
					$("#userPassword").val("");
					$("#pwd").hide();
					$("#userPassword").removeAttr("ctype");
					$(".addAccountSel .header:eq(0)").html("修改角色");
			    	$(".addAccountSel,.bgShow").fadeIn();
				}else{
					$.hd.alertMsg.error(data.errors || "服务器繁忙,稍后请重试!");
				}
			}
		});
    });
	function isNull(arg1)
	{
		return !arg1 && arg1!==0 && typeof arg1!=="boolean"?true:false;
	}
    // 审核通过
    $(".btn_authPass").click(function(){
    	$("#authId").val($(this).parent().attr("uid"));
    	$(".redistribution,.bgShow").fadeIn();
    });
    // 审核通过-服务器请求
    $(".redistribution .btnForSure").click(function(){
    	var _this = $(this),
    		_uid = $("#authId").val(),
    		_rid = $("#authRid").val();
    	console.log(_uid,_rid);
    	$.ajax({
			url 	 : "${mvcPath}/view/accountMan/passAuth",
			type 	 : "post",
			dataType : "json",
			data 	 : {userId :_uid,roleId :_rid},
			success  : function(data, textStatus, XMLHttpResponse) {
				if(data.result){
			    	$(".redistribution,.bgShow").fadeOut();
//			    	if(window.confirm("审核通过")){
						refreshPage();
//					};
				}else{
					$.hd.alertMsg.error(data.errors || "服务器繁忙,稍后请重试!");
				}
			}
		});
    });
    // 重置密码
    $(".btn_resetPwd").click(function(){
    	$("#updatePwdId").val($(this).parent().attr("uid"));
    	$(".increaseBonus,.bgShow").fadeIn();
    });
 	// 重置密码-服务企请求
 	$(".increaseBonus .btnForSure").click(function(){
    	var _this = $(this),
    		_uid = $("#updatePwdId").val(),
    		_password = $("#userPasswordEx").val(),
    		_passwordRepeat = $("#passwordRepaet").val(),
    		_params = $(".increaseBonus").params();
    	if( _params != null ){
	    	// 判断密码是否一致
	    	if(_password != _passwordRepeat){
	    		$("#passwordRepaet").val("");
	    		$.hd.tips($("#userPasswordEx"), "两次密码输入不一致,请重新输入!");
	    		return false;
	    	}
	    	// 请求服务
	    	$.ajax({
				url 	 : "${mvcPath}/view/accountMan/resetPassword",
				type 	 : "post",
				dataType : "json",
				data 	 : {userId :_uid,userPassword :_password},
				success  : function(data, textStatus, XMLHttpResponse) {
					if(data.result){
				    	$(".increaseBonus,.bgShow").fadeOut();
						$.hd.alertMsg.info("重置成功");
					}else{
						$.hd.alertMsg.error(data.errors || "服务器繁忙,稍后请重试!");
					}
				}
			});
    	}
 	});
    
    $(".btn_update_status").click(function(){
    	var _this = $(this),
    		_uid = _this.parent().attr("uid"),
    		_status = _this.attr("status");
    	$.ajax({
			url 	 : "${mvcPath}/view/accountMan/updateStatus",
			type 	 : "post",
			dataType : "json",
			data 	 : {userId :_uid,status :_status},
			success  : function(data, textStatus, XMLHttpResponse) {
				if(data.result){
//			    	if(window.confirm("操作成功")){
						refreshPage();
//					};
				}else{
					$.hd.alertMsg.error(data.errors || "服务器繁忙,稍后请重试!");
				}
			}
		});
    });
    
    $(".searchBtn:first").click(function(){
    	var companyKey = $("#keywords").val(); 
    	var _findType = $("#findType").val();
    	refreshPage({keywords: companyKey,findType:_findType});
    });
</script>
