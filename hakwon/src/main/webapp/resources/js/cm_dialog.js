var fnc_return; 

var fncReturns = {};

var cm_dialog_param = {
	is_confirmbox_esc : false
};

//layer popup 가운데로 
function cmLayerPopupCenter(layerBox) {
	
	
	var popW = layerBox.outerWidth();
	var popH = layerBox.outerHeight();
	var scroll_top = jQuery(document).scrollTop();
	var winW = jQuery(window).width();
	var winH = jQuery(window).height();
	var top = (winH - popH) / 2 - 30;
	
	if (winW > popW) {
		layerBox.css("left", winW / 2 - popW / 2);
	}
	else {
		layerBox.css("left", 0);
	}
	
	
	if(popH > winH - 100){
		jQuery('.pop-contents', layerBox).css('height', winH-200);
	} else {
		jQuery('.pop-contents', layerBox).css('height', 'auto');
		
		layerBox.css({'top' : top + scroll_top});
	}
}

//layer popup 가운데로 
function cmLayerPopupCenter2(customId) {
	
	var layerBox = $("#div_"+customId);
	var iframe = $("#"+customId, layerBox);
	var popW = layerBox.width();
	var popH = iframe.height();
	var winW = jQuery(window).width();
	var winH = jQuery(window).height();
	var top = (winH - popH) / 2 - 30;
	
	if (winW > popW) {
		layerBox.css("left", winW / 2 - popW / 2);
	}
	else {
		layerBox.css("left", 0);
	}

	if(popH > winH - 100){
//		jQuery('.pop-contents', layerBox).css('height', winH-200);
		layerBox.css({'top' : 50, 'height' : winH-200});
		
	} else {
//		jQuery('.pop-contents', layerBox).css('height', 'auto');
		layerBox.css({'top' : top, 'height' : 'auto'});
	}
}

//layer popup 가운데로 
function cmLayerPopupCenter3(customId) {
	
	var layerBox = $("#div_"+customId);
	var iframe = $("#"+customId, layerBox);
	var popH = iframe.height();
	var popW = layerBox.width();
	var winW = jQuery(window).width();
	var winH = jQuery(window).height();
	var top = (winH - popH) / 2;
	
	if (winW > popW) {
		layerBox.css("left", winW / 2 - popW / 2);
	}
	else {
		layerBox.css("left", 0);
	}
	
	if(popH > winH - 100){
		layerBox.css({'top' : 50, 'height': winH-100});
	} else {
		layerBox.css({'top' : top, 'height' : 'auto'});
	}
}

// 레이어 팝업 background 보이기
function showLayerPopupBackground( id ) {
	var bgPop;
	if (id != undefined && id != "") {
		bgPop			= jQuery("#" + id);
		if (bgPop.html() == null) {
			bgPop = jQuery("<div id=\""+ id +"\"></div>").appendTo(jQuery("body"));
		}
	}
	else {
		bgPop			= jQuery(".bg_pop").eq(0);
		if (bgPop.size() == 0) {
			bgPop = jQuery("<div class=\"bg_pop\"></div>").appendTo(jQuery("body"));
		}
	}
	bgPop.show();
}

// 레이어 팝업 background 숨기기
function hideLayerPopupBackground(id) {
	if (id != undefined && id != "") {
		jQuery("#" + id).hide();
	}
	else {
		jQuery(".bg_pop").eq(0).hide();
	}
}

function cmDialogOpen(customId, p_opt) {
	var defaults = {
			maxWidth : "2000"
			// , maxHeight : "1000"
			, modal : true
			, scroll :"auto"
			, position : undefined
			, width : undefined
			, height : undefined
			, changeViewAutoSize : false
			, noscroll : "N"
			, sideBtn : "N"
			, sideNextShow : true
			, sidePrevShow : true
			, sideNextFnc: ""
			, sidePrevFnc: ""
			, popinpop : "N"
			, param : undefined
		};
	var options = jQuery.extend(defaults, p_opt);

	$('body').addClass('pop_open');
	
	if (jQuery('#div_'+customId).html() != null) {
		jQuery('#div_'+customId).remove();
	}
	
	// $('body').addClass('pop_open');
	var arrHtml	= [];
	if(options.popinpop == "Y"){
		arrHtml.push("<div id='div_"+customId+"' class='common_layer_popup2 pop-contents open'>");
	}else{
		arrHtml.push("<div id='div_"+customId+"' class='common_layer_popup pop-contents open'>");
	}
	if(customId == 'pop_sampler'){
		arrHtml.push("    <iframe id='"+customId+"' name='"+customId+"' class='ui-iframe-style2' src='about:blank' style='overflow:hidden;background-color:#fff; width:100%; heigth:100%;' scrolling='yes' marginwidth='0' marginheight='0' frameborder='0' vspace='0' hspace='0'></iframe>");
//		arrHtml.push("    <a href=\"javascript:cmDialogClose('"+customId+"');\" class='btn_popClose2'>팝업닫기</a>");
		arrHtml.push("    <a href=\"#\" class='btn_popClose2'>팝업닫기</a>");
	}else{
		arrHtml.push("    <iframe id='"+customId+"' name='"+customId+"' class='ui-iframe-style' src='about:blank' style='overflow:hidden;background-color:#fff; width:100%; heigth:100%;' scrolling='yes' marginwidth='0' marginheight='0' frameborder='0' vspace='0' hspace='0'></iframe>");
		arrHtml.push("    <a href=\"javascript:;\" class='btn_popClose'>팝업닫기</a>");
	}
	
	
	if(options.sideBtn == "Y"){
		arrHtml.push("    <a href=\"javascript:;\" class=\"btn_popPrev\" style=\"display:none\"><span class=\"blind\">이전</span></a>");
		arrHtml.push("    <a href=\"javascript:;\" class=\"btn_popNext\" style=\"display:none\"><span class=\"blind\">다음</span></a>");		
	}
	
	arrHtml.push("</div>");
	
	var layerBox 	= jQuery(arrHtml.join("")).appendTo("body");
	var iframe 		= jQuery("iframe", layerBox);
	var btnClose 	= jQuery(".btn_popClose", layerBox);
	if(customId == 'pop_sampler'){
		btnClose 	= jQuery(".btn_popClose2", layerBox);
	}
	
	if(typeof options.sideNextFnc == "function"){
		jQuery(".btn_popNext").unbind("click").bind("click", function (e) {
			e.preventDefault();
			options.sideNextFnc();
		});
	}
	
	if(typeof options.sidePrevFnc == "function"){
		jQuery(".btn_popPrev").unbind("click").bind("click", function (e) {
			e.preventDefault();
			options.sidePrevFnc();
		});
	}
	
	if (options.modal == true) {
		if(options.popinpop == "Y"){
			showLayerPopupBackground("common_layer_popupBg2");
		}else{
			showLayerPopupBackground("common_layer_popupBg");
		}
	}else{
		$('body').removeClass('pop_open');
	}
	
	if (options.width != undefined) {
		var width = ("" + options.width).toLowerCase();
		if (width.indexOf("%") == -1 && width.indexOf("px") == -1) {
			options.width += "px";
		}
	}
	if (options.height != undefined) {
		var height = ("" + options.height).toLowerCase();
		if (height.indexOf("%") == -1 && height.indexOf("px") == -1) {
			options.height += "px";
		}
	}
	
	iframe.width(options.width);
	if(options.popinpop == "Y"){
		$('.common_layer_popup2 .btn_popClose').css('marginLeft', parseInt(options.width)/2 - 31 + 'px');
	}else{
		$('.common_layer_popup .btn_popClose').css('marginLeft', parseInt(options.width)/2 - 31 + 'px');
	}

	iframe.height(options.height);

	layerBox.show().data("options", options);
	
	if(options.sidePrevShow){
		$(".btn_popPrev").show();
	}
	if(options.sideNextShow){
		$(".btn_popNext").show();
	}
	
	if(options.param != undefined){
		iframe.attr({src: options.url+"?"+options.param});
	}else{
		iframe.attr({src: options.url});
	}
	
	// layer popup 종료후 실행될 function setting
	if (options.fnc_return != undefined) {
		fncReturns[customId]		= options.fnc_return;
	}
	
	if(options.popinpop == "Y"){
		btnClose.click(function(event){
			event.preventDefault();
			cmDialogClose(customId,"E");
		});
	}else{
		btnClose.click(function(event){
			event.preventDefault();
			cmDialogClose(customId);
		});
	}
	
	if ( options.changeViewAutoSize ) {
		jQuery("#"+customId).load(function (event) {
			var popBody = jQuery("#"+customId).contents().find("body");
			var height  = jQuery(".pop_con", popBody).height() + 80;
			if(customId == 'shop_sample'){
				height  = jQuery(".pop_con", popBody).height();
			}
			if (options.maxHeight > height) {
				// jQuery('#div_'+customId).height(height);
			}
			if(options.height){
				
				jQuery('#'+customId).css('height', options.height);
			} else {
				jQuery('#'+customId).css('height', height);
			}
			
			popBody.resize(function (event) {
				
				height = jQuery(".pop_con", popBody).height();
				
				if (jQuery('#div_'+customId).height() != height) {
					if (options.maxHeight > height) {
						jQuery('#div_'+customId).height(height);
						jQuery('#'+customId).height(height);
					}
					else  {
						jQuery('#div_'+customId).height(options.maxHeight);
						jQuery('#'+customId).height(options.maxHeight);
					}
				}
				
			});
			try {
				popBody.resize();
			} catch (e) {}
			
		});
	}
	
	if ( options.position == undefined || options.position.length < 2) {
		jQuery("#"+customId).load(function (event) {
			if(options.noscroll == "Y"){
				cmLayerPopupCenter2(customId);
				
				jQuery(window).resize(function (event) {
					cmLayerPopupCenter2(customId);
				});
			}else{
				cmLayerPopupCenter3(customId);
				
				jQuery(window).resize(function (event) {
					cmLayerPopupCenter3(customId);
				});
			}
		});
	}
	
	else {
		var left = ("" + options.position[0]).toLowerCase();
		if (left.indexOf("%") == -1 && left.indexOf("px") == -1) {
			options.position[0] += "px";
		}
		var top = ("" + options.position[1]).toLowerCase();
		if (top.indexOf("%") == -1 && top.indexOf("px") == -1) {
			options.position[1] += "px";
		}
		 layerBox.css({"left" : options.position[0], "top" : options.position[1]});
	}
	
	jQuery(document).keyup(function(e){
		event.preventDefault();
		if(e.keyCode === 27){
			if(customId == 'pop_sampler'){
				btnClose 	= jQuery(".btn_popClose2").click();
			}else{
				jQuery(".btn_popClose").click();
			}
		}
	});//esc로 닫기
	
	// if ( options.changeViewAutoSize ) {
	// 	jQuery("#"+customId).load(function (event) {
			
	// 		var popBody = jQuery("#"+customId).contents().find("body");
	// 		var height  = jQuery(".pop_con", popBody).height() + 80;
	// 		console.log(height);
	// 		if (options.maxHeight > height) {
	// 			// jQuery('#div_'+customId).height(height);
	// 		}
	// 		jQuery('#'+customId).css('height', height);
			
	// 		popBody.resize(function (event) {
			
	// 			height = jQuery(".pop_con", popBody).height();
				
	// 			if (jQuery('#div_'+customId).height() != height) {
	// 				if (options.maxHeight > height) {
	// 					jQuery('#div_'+customId).height(height);
	// 					jQuery('#'+customId).height(height);
	// 				}
	// 				else  {
	// 					jQuery('#div_'+customId).height(options.maxHeight);
	// 					jQuery('#'+customId).height(options.maxHeight);
	// 				}
	// 			}
				
	// 		});
	// 		try {
	// 			popBody.resize();
	// 		} catch (e) {}
	// 	});
	// }
	
}

/**
 * IFrame 레이어 팝업 종료 함수
 */
function cmDialogClose(customId,flag){
	$('body').removeClass('pop_open');
	//창 종료 후 실행될 함수
	if (typeof fncReturns[customId] == "function") {
		fncReturns[customId]();
	}
	if(flag != "Y" && flag != "E"){
		hideLayerPopupBackground("common_layer_popupBg");
	}else if(flag == "E"){
		hideLayerPopupBackground("common_layer_popupBg2");
	}
	
	jQuery('#div_'+customId).remove();
}

function cmDialogResize(customId, chg_height, flag_chg) {
	var div = parent.jQuery("#div_" + customId);
	var options = div.data("options");
	
	if (flag_chg == undefined) {
		flag_chg = "N";
	}
	
	if(flag_chg == "N" && options != undefined && options.height != undefined) {
		parent.jQuery('#'+customId).css('height', options.height);
	} else {
//		parent.jQuery('#'+customId).css('height', chg_height);
		cmLayerPopupCenter3(customId);
	}
}

/**
 * IFrame을 이용한 레이어 팝업
 * @param options
 */
function dialogOpen(p_opt){
	
	if (jQuery('#common_dialog').html() == null) {
		var arrHtml	= [];
		
		arrHtml.push("<div id=\"common_dialog\" style=\"display:none;padding:0px;margin:0px;\">");
		arrHtml.push("<iframe id=\"popcontent\" name=\"popcontent\" class=\"ui-iframe-style\" src=\"about:blank\" scrolling=\"auto\" marginwidth=\"0\" marginheight=\"0\" frameborder=\"0\" vspace=\"0\" hspace=\"0\"></iframe>");
		arrHtml.push("</div>");
		jQuery(arrHtml.join("")).appendTo("body");
	}

	var defaults = {
		maxWidth : "600"
		, maxHeight : "600"
		, modal : true
	};
	var options = jQuery.extend(defaults, p_opt);
	
	jQuery('#common_dialog').dialog({
			title: 		options.title,
			bgiframe: 	true,
	        autoOpen: 	false,
	        width:		options.width,
     		height:		options.height,
     		minWidth :  options.minWidth,
     		minHeight : options.minHeight,
     		maxWidth :  options.maxWidth,
     		maxHeight : options.maxHeight,
     		position : options.position,
			modal: 		typeof options.modal == 'undefined' ? true : options.modal ,
			resizable:  false,
	        open: function() { 
	        	jQuery('.msgBoxHide').hide();
				jQuery('#popcontent').height(jQuery(this).height()-10); 
				jQuery('#popcontent').width(jQuery(this).width()-10); 
			},
	        resize: function() { 
				jQuery('#popcontent').hide(); 
			},
	        resizeStop: function() { 
				jQuery('#popcontent').show();
				jQuery('#popcontent').height(jQuery(this).height()-10);  
				jQuery('#popcontent').width(jQuery(this).width()-10); 
			},
			close: function(){
				jQuery('.msgBoxHide').show();
				jQuery('#popcontent').attr('src','');
				jQuery('#common_dialog').dialog('destroy');
			} 
	}); 
						
	//dialog 종료후 실행될 function setting
	if (options.fnc_return != undefined) {
		fnc_return		= options.fnc_return;
	}
	
	//dialog시 불러올 iframe 주소
	jQuery('#popcontent').attr({src: options.url});
	
	if ( options.changeViewAutoSize ) {
		jQuery("#popcontent").load(function (event) {
			
			var popBody = jQuery("#popcontent").contents().find("body");
			var height = popBody.height();
			
			if (options.maxHeight > height) {
				jQuery('#common_dialog').height(height);
				jQuery('#popcontent').height(height);
			}
			
			popBody.resize(function (event) {
				height = popBody.height();
				
				if (jQuery('#common_dialog').height() != height) {
					if (options.maxHeight > height) {
						jQuery('#common_dialog').height(height);
						jQuery('#popcontent').height(height);
					}
					else  {
						jQuery('#common_dialog').height(options.maxHeight);
						jQuery('#popcontent').height(options.maxHeight);
					}
				}
			});
		});
	}
	
	//to-do : 타이틀 없애는 거 추가
	if ( typeof options.hideTitle != 'undefined' || options.hideTitle == true ) {
		jQuery('.ui-dialog-titlebar').hide();
	}
	else {
		jQuery('.ui-dialog-titlebar').show();
	}
	
	jQuery('#popcontent').show();
	jQuery('#common_dialog').dialog("open");
}

/**
 * IFrame 레이어 팝업 종료 함수
 */
function dialogClose(){
	//창 종료 후 실행될 함수
	
	if (typeof fnc_return == "function") {
		fnc_return();
	}

    fnc_return = null;
	
	jQuery('#popcontent').attr('src','');
	jQuery('#common_dialog').dialog('destroy');
	jQuery('.msgBoxHide').show();
}

function cmDialog(jQueryObj, options) {
	
	jQueryObj.dialog({
		title: 		options.title,
		bgiframe: 	true,
        autoOpen: 	false,
        width:		options.width,
 		height:		options.height,
 		position : options.position,
 		minWidth :  options.minWidth,
 		minHeight : options.minHeight,
 		maxWidth :  options.maxWidth,
 		maxHeight : options.maxHeight,
		modal: 		typeof options.modal == 'undefined' ? true : options.modal ,
		resizable:  false,
        open: function() { 
        	jQuery('.msgBoxHide').hide();
			if ( options.open ) options.open();
		},
        resize: function() { 
        	if ( options.resize ) options.resize();
		},
        resizeStop: function() { 
        	if ( options.resizeStop ) options.resizeStop; 
		},
		close: function(){
			jQuery('.msgBoxHide').show();
			if ( options.close ) options.close();
		} 
	}); 
	
	jQueryObj.dialog("open");
}


function showConfirmBox( p_opt ) {
	
	if (typeof p_opt != "object" || p_opt == null) {
		alert("설정 오류");
		return
	}
	
	var _defaults = {
		title : "확인"
		, desc : ""
		, message : ""
		, option : undefined
		, ok_func : undefined
		, ok_str : "확인"
		, cancel_func : undefined
		, cancel_str : "취소"
		, close_func : "취소"
		, append_class : "txt_confirm"
		, width : undefined
	};
	
	var opt = $.extend(_defaults, p_opt);
	
	var title			= opt.title;
	var desc			= opt.desc;
	var message			= opt.message;
	var	ok_func			= opt.ok_func;
	var	cancel_func		= opt.cancel_func;
	var close_func		= opt.close_func;
	var	option			= opt.option;
	var ok_str			= opt.ok_str;
	var cancel_str  	= opt.cancel_str;
	var append_class  	= opt.append_class;
	var width			= opt.width;
	
	var confirmBox		= makeConfirmBox(title, desc, message, ok_str, cancel_str, append_class, close_func);
	
	if (title == "") {
		jQuery(".message-title", confirmBox).hide();
	}
	
	confirmBox.addClass("open");	
	
	if (width != undefined) {
		confirmBox.width(width);
	}
	
	confirmBox.show();
	showLayerPopupBackground("commonConfirmBoxBg");
	cmLayerPopupCenter(confirmBox);
	

	$('body').addClass('pop_open');
	$('<span class="bg_pop" id="bg_pop_confirm_box"></span>').appendTo('body');
	
	if (typeof option == "object" && option != null) {
		var ok_str		= option.ok_str || "";
		var cancel_str	= option.cancel_str || "";
		
		if (ok_str != "") {
			jQuery(".btn_ok", confirmBox).html(ok_str);
		}
		if (cancel_str != "") {
			jQuery(".btn_cancel", confirmBox).html(cancel_str);
		}
	}
	
	// ok 버튼 클릭시
	jQuery(".btn_ok", confirmBox)
		.unbind("click")
		.bind("click", function (e) {
			e.preventDefault();
			hideConfirmBox();
			if (typeof ok_func == "function") {
				ok_func();
			}
		});
	
	// cancel 버튼 클릭시
	jQuery(".btn_cancel", confirmBox)
		.unbind("click")
		.bind("click", function (e) {
			e.preventDefault();
			hideConfirmBox();
			if (typeof cancel_func == "function") {
				cancel_func();
			}
		});
	
	jQuery(".btn_popClose", confirmBox)
		.unbind("click")
		.bind("click", function (e) {
			e.preventDefault();
			hideConfirmBox();
			
			if (typeof close_func == "function") {
				close_func();
			}
		});
	
	msgBoxHide(true);
	jQuery(".btn_ok", confirmBox).eq(0).focus();
	
	if (!cm_dialog_param.is_confirmbox_esc) {
		// esc 닫기
		jQuery(document).keydown(function(e){
			if(e.keyCode == 27) {
				var div = jQuery("#commonConfirmBox");
				if (div != undefined && !div.hasClass("layer_remove")) {
					div.find(".btn_cancel").click();
				};
			}
		});
	}
	
	
	
	cm_dialog_param.is_confirmbox_esc = true;
}

/**
 * Confirm 박스 생성
 */
function makeConfirmBox(title, desc, message, ok_str, cancel_str, append_class, close_func) {
	
	jQuery("#commonConfirmBox").remove();
	
	var arrHtml			= [];
	arrHtml.push("<div id=\"commonConfirmBox\" >");
	arrHtml.push("    <div class=\"pop-inner pop-contents\">");
	arrHtml.push("        <div class=\"head\">");
	arrHtml.push("            <h2 class=\"ttl\">"+title+"</h2>");
	arrHtml.push("            <p class=\"desc\">"+desc+"</p>");
	arrHtml.push("        </div>");
	arrHtml.push("        <div class=\"edit_con\">");
	arrHtml.push("            <p class=\""+ append_class +"\">"+message+"</p>");
	arrHtml.push("            <div class=\"btn_area center\">");
	arrHtml.push("                <span class=\"btn_jq btn_type05 s2\"><a href=\"#\" class=\"btn s_btn light btn_cancel\"><em>"+cancel_str+"</em></a></span>");
	arrHtml.push("                <span class=\"btn_jq btn_type02 s2\"><a href=\"#\" class=\"btn s_btn yellow btn_ok\"><em>"+ok_str+"</em></a></span>");
	arrHtml.push("            </div>");
	arrHtml.push("        </div>");
	arrHtml.push("        <a href=\"javascript:;\" class=\"btn_popClose\" >팝업닫기</a>");
	arrHtml.push("    </div>");
	arrHtml.push("</div>");

	var div = jQuery(arrHtml.join("\n")).appendTo(jQuery("body"));
	
	return div;	
}

// confirm 닫기
function hideConfirmBox() {
	var confirmBox		= jQuery("#commonConfirmBox");
	confirmBox.hide().addClass("layer_remove");
	msgBoxHide(false);
	
	hideLayerPopupBackground("commonConfirmBoxBg");
	
	$('#bg_pop_confirm_box').remove();
	$('body').removeClass('pop_open');
}
//[e] confirm

function msgBoxHide( flag ) {
	if (flag)
		jQuery(".msgBoxHide").hide();
	else
		jQuery(".msgBoxHide").show();
}

////[s] Message Box
function showMessageBox( object ) {
	
	if (typeof object != "object" || object == null) {
		alert("showMessageBox : 설정 오류");
		return
	}
	
	var title				= object.title || "알림";
	var message				= object.message || "";
	var width				= object.width || 320;
	
	messageBox		= makeMessageBox(title, message);

	if (width != undefined) {
		messageBox.width(width);
	}

	messageBox.show();
	showLayerPopupBackground("commonMessageBoxBg");
	
	cmLayerPopupCenter(messageBox);
	
	if(typeof object.close == "function") {
		messageBox.data("close_function", object.close);
	}
	
	msgBoxHide(true);
	jQuery(".btn_ok", messageBox).eq(0).focus();
	jQuery(document).keyup(function(e){
		event.preventDefault();
		if(e.keyCode === 32){
			jQuery(".btn_ok").click();
		}
	});//Space Bar로 닫기 
}

//messge box 닫기
function hideMessageBox() {
	var messageBox		= jQuery("#commonMessageBox");
	
	msgBoxHide(false);
	hideLayerPopupBackground("commonMessageBoxBg");
	
	var close_function = messageBox.data("close_function");
	if (close_function != undefined) {
		close_function();
	}
	
	messageBox.remove();
}

// message box 
function makeMessageBox(title, message) {
	jQuery("#commonMessageBox").remove();
	
	var arrHtml	=	[];
	
	arrHtml.push("<div id=\"commonMessageBox\" >");
	arrHtml.push("		<div class=\"pop-inner pop-contents\">");
	arrHtml.push("			<div class=\"head\">");
	arrHtml.push("				<h1 class=\"title\">"+title+"</h1>");
	arrHtml.push("			</div>");
	arrHtml.push("			<div class=\"content\">");
	arrHtml.push("				<p class=\"txt_message\" style=\"margin-top: 10px;\">"+message+"</p>");
	arrHtml.push("				<div class=\"submit-a\">");
	arrHtml.push("					<span class=\"btn_jq btn_type02 s2\"><a href=\"#\" class=\"btn s_btn yellow btn_ok\"  onclick=\"hideMessageBox(); return false;\"><em>확인</em></a></span>");
	arrHtml.push("				</div>");
	arrHtml.push("			</div>");
	arrHtml.push("		</div>");
	arrHtml.push("		<a href=\"javascript:;\" class=\"btn_layer_close\" onclick=\"hideMessageBox();return false;\">팝업닫기</a>");
	arrHtml.push("</div>");
	
	var div = jQuery(arrHtml.join("\n")).appendTo(jQuery("body"));
	return div;
}
//[e] Message Box


//[s] Loading Box
var loading_interval = undefined;

function showLoadingBox() {
	var loadingBox		= makeLoadingBox();
	
	showLayerPopupBackground("commonLoadingBoxBg");
	loadingBox.show();
	cmLayerPopupCenter(loadingBox);

	//msgBoxHide(true);
}

// Loading box 닫기
function hideLoadingBox() {
	var loadingBox		= jQuery("#commonLoadingBox");
	
	if (loading_interval != undefined) {
		clearInterval(loading_interval);
		loading_interval = undefined;
	}
	
	loadingBox.remove();
	hideLayerPopupBackground("commonLoadingBoxBg");
	//msgBoxHide(false);
}

// Loading box 
function makeLoadingBox() {
	
	jQuery("#commonLoadingBox").remove();
	
	var arrHtml = [];
	
	arrHtml.push("<div id=\"commonLoadingBox\">");
	
	arrHtml.push("    <div class=\"preloader_wrap\">");
	arrHtml.push("    	<div class=\"cont\">  ");
	arrHtml.push("    		<span></span>");
	arrHtml.push("    		<span></span>");
	arrHtml.push("    		<span></span>");
	arrHtml.push("    		<span></span>");
	arrHtml.push("    	</div>");
	arrHtml.push("    </div>");
	
	arrHtml.push("</div>");
	
	var div = jQuery(arrHtml.join("\n")).appendTo(jQuery("body"));
	return div;
}

function showPersonalLoadingBox() {
	
	var loadingBox		= makePersonalLoadingBox();
	
	loadingBox.show();
	
	cmLayerMobilePopupCenter(loadingBox);
	
	loading_interval = setInterval(function () {
		var div = jQuery("div", "#personalAreaLoadingBox");
		
		if (div.html() != null) {
			var cls_num = parseInt(div.attr("class").split("-")[1]);
			
			if (cls_num == 20) {
				cls_num = 1;
			}
			else {
				cls_num++;
			}
			div.attr("class", "l-" + cls_num);
		}
		else {
			clearInterval(loading_interval);
		}
	}, 91);
	
	msgBoxHide(true);
}

// Loading box 닫기
function hidePersonalLoadingBox() {
	
	var loadingBox		= jQuery("#personalAreaLoadingBox");
	
	if (loading_interval != undefined) {
		clearInterval(loading_interval);
		loading_interval = undefined;
	}

	loadingBox.remove();
	msgBoxHide(false);
}

// Loading box 
function makePersonalLoadingBox() {
	
	jQuery("#personalAreaLoadingBox").remove();
	
	var arrHtml = [];
	
	arrHtml.push("<div id=\"personalAreaLoadingBox\">");
	
	//arrHtml.push("    <div class=\"l-10\" ></div>");
	
	arrHtml.push("</div>");
	
	var div = jQuery(arrHtml.join("\n")).appendTo(jQuery("#ul_list2"));
	return div;
}

function cmLayerMobilePopupCenter(layerBox) {
	
	var popW = layerBox.width();
	var popH = layerBox.height();
	var scroll_top = jQuery(document).scrollTop();
	var winH = isNaN(window.innerHeight) ? window.clientHeight : window.innerHeight;
	var winW = jQuery(window).width();
	var top = (winH - popH) / 2;
	
	if (winW > popW) {
		// layerBox.css("left", winW / 2 - popW / 2);
	}
	else {
		// layerBox.css("left", 0);
	}
	
//	layerBox.css({'top':scroll_top + 150});
	
	if(popH > winH - 100){
		jQuery('.pop_content', layerBox).css('height', winH-200);
		// layerBox.css({'top':scroll_top + 50});
	} else {
		jQuery('.pop_content', layerBox).css('height', 'auto');
		// layerBox.css({'top':top + scroll_top});
	}
	
}

function cmInstarViewPopup(key){
	var nextkey = $("#"+key+"_next_id").text();
	var prevkey = $("#"+key+"_prev_id").text();
	cmDialogOpen("popInstaView", {
		url : GLOBAL_WEB_ROOT + "comm/comm_instar_view_pop.do?i_sKey="+key
		, width : "845px"
		, height : "545px"
		, changeViewAutoSize : true
		, modal : true
		, scroll : "no"
		, sideBtn : "Y"
		, sideNextFnc : function(){
			if ( nextkey != "") {
				parent.cmDialogClose("popInstaView");
				cmInstarViewPopup(nextkey);
			}
		}
		, sidePrevFnc : function(){
			if ( prevkey != "") {
				parent.cmDialogClose("popInstaView");
				cmInstarViewPopup(prevkey);
			}
		}
	});
}
