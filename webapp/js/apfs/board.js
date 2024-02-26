
$(document).ready(function(){
	if(window.history && window.history.pushState){
		if(window.location.href.indexOf("http://localhost:8080/front/board/boardContentsView.do") != -1){
			window.history.pushState("forward", null, window.location.href);
		}
		
		$(window).on("popstate", function(){
			if((window.location.href.indexOf("http://localhost:8080/front/board/boardContentsView.do") == 0)){
				$("#writeFrm").attr("target", "_self");
				$("#writeFrm").attr("action", boardContentsListPageUrl);
				$("#writeFrm").submit();
			}
		});
	}
	
	$("#refreshBtn").click(function() {
		$("#captchaImg").attr("src", "/captcha?=id"+Math.random());
	});
	
	$('#captchaSubmitBtn').click(function(){
		if ( !$('#captchaText').val() ) {
			alert('이미지에 보이는 숫자를 입력해 주세요.');
		} else {
			$.ajax({
				url: '/CaptchaSubmit.jsp',
				type: 'POST',
				dataType: 'text',
				data: 'answer=' + $('#captchaText').val(),
				async: false,
				success: function(resp) {
					alert(resp);
					$('#reLoad').click();
					$('#captchaText').val('');
				}
			});
		}
	});
	
	$(".board-img ul li a").click(function() {
		if($(this).hasClass("curr")) return false;

		$t = $(this).attr("href");
		$(".board-img p.img img").removeClass("curr");
		$($t).addClass("curr");
		$(this).parents("ul").find("a").removeClass("curr").end().end().addClass("curr");
		return false;
	});
	
	// 로그인 시도 이벤트 처리 (.login) (2018.07.11(수))
	$(".login").click(function(){
		$.ajax({
			type: "POST", 
            url: "/front/member/memberLogin.do", 
            data:{
           		id : $("#id").val(),
           		password : $("#password").val()
            },
            dataType: 'json',
			success:function(data){
				if(data.success == "true"){
					location.href='/front/board/boardContentsListPage.do?menuId='+menuId+'&boardId='+boardId;
					return;
				} else {
					alert("회원정보가 없습니다.");
					return;
				}
			}
		});
	});
	
	// "각 게시물 상세보기 이벤트 처리 (.detail_view)" (2018.07.11(수))
	$('.detail_view').each(function(i){
		$(this).click(function(e){
			e.preventDefault();
			
			$("#contId").val($(this).attr("viewId"));
			
			if($("#contId").val() == "") {
				alert("게시물 아이디 정보가 없습니다");
				return;
			} else {
				if(isNaN($("#contId").val())) {
					alert("게시물 아이디는 숫자로만 확인됩니다.");
					return;
				}
			}
			
			if ($(this).attr("openYn")=='N') {
				$("#pwdContId").val($(this).attr("viewId"));
				
				$.ajax({
			        url: "/front/board/pwdCheck.do",
			        dataType: "json",
			        type:"post",
			        data: {
			        	contId : $("#pwdContId").val(),
			        	boardId : $("#boardId").val()
			        },
			        success: function(data) {
			        	if (data.success == "true") {
			        		$("#listFrm").attr("target", "_self");
			    			$("#listFrm").attr("action", boardContentsViewUrl);
			    			$("#listFrm").submit();
			                return;
						} else {
							popupShow();
							/*
			        		if((auth_sname == "") || (auth_sname == null)){
			        			if(confirm("비공개 글입니다. 실명인증을 하시겠습니까?")){
			        				$("#requestUrl").val(window.location.pathname);			        			    
			        			    $("#listFrm").attr("target", "_self");
			        				$("#listFrm").attr("action", authCheckUrl);
			        				$("#listFrm").submit();
			        				return;
			        			} else {
			        				return;
			        			}
			        		}
		        			 */
			        		//alert("비공개 글은 작성자 본인만 열람 하실수 있습니다.");
			        	}
			        },
			        error: function(e) {
			            //alert("테이블을 가져오는데 실패하였습니다.");
			        }
			    });
				return;
			}
		    
		    $("#listFrm").attr("target", "_self");
			$("#listFrm").attr("action", boardContentsViewUrl);
			$("#listFrm").submit();
		});
	});	
	
	// "각 게시물 etc 상세보기 이벤트 처리 (.etc_detail_view)" (2018.07.11(수))
	$(".etc_detail_view").click(function(){
		if($(this).attr("contentsid") == "") {
			alert("해당 게시물 컨텐츠 아이디값이 비어 있으므로, 들어갈 수 없습니다.");
			return;
		} else {
			if(isNaN($(this).attr("contentsid"))) {
				alert("해당 게시물 컨텐츠 아이디는 숫자만 허용됩니다.");
				return;
			}
		}
		
		$("#contId").val($(this).attr("contentsid"));
		
		$("#listFrm").attr("target", "_self");
		$("#listFrm").attr("action", boardEtcContentsViewUrl);
		$("#listFrm").submit();
		
	});
	
	// "이전글 제목 클릭 (.prev_view)" (2018.07.11(수))
	$(".prev_view").click(function(){
		$("#contId").val($(this).attr("preId"));
		if ($(this).attr("preOpenYn")=='N') {
			$("#pwdContId").val($(this).attr("preId"));
			
			$.ajax({
		        url: "/front/board/pwdCheck.do",
		        dataType: "json",
		        type:"post",
		        data: {
		        	contId : $("#pwdContId").val(),
		        	boardId : $("#boardId").val()
		        },
		        success: function(data) {
		        	if (data.success == "true") {
		        		$("#writeFrm").attr("target", "_self");
		        		$("#writeFrm").attr("action", boardContentsViewUrl);
		        		$("#writeFrm").submit();
		                return;
					} else {						
		        		if((auth_sname == "") || (auth_sname == null)) {
		        			if(confirm("비공개 글입니다. 실명인증을 하시겠습니까?")){
		        				$("#requestUrl").val(window.location.pathname);		        			    
		        			    $("#writeFrm").attr("target", "_self");
				        		$("#writeFrm").attr("action", "/front/auth/authCheck.do");
				        		$("#writeFrm").submit();
				        		return;
		        			} else {
		        				return;
		        			}
		        		}
		        		alert("비공개 글은 작성자 본인만 열람 하실수 있습니다.");
		        	}
		        },
		        error: function(e) {
		            //alert("테이블을 가져오는데 실패하였습니다.");
		        }
		    });
			
			
			return;
		}
	    
	    $("#writeFrm").attr("target", "_self");
		$("#writeFrm").attr("action", boardContentsViewUrl);
		$("#writeFrm").submit();
	});
	
	// "다음글 제목 클릭 (.next_view)" (2018.07.11(수))
	$(".next_view").click(function(){
		$("#contId").val($(this).attr("nextId"));
		
		if ($(this).attr("nextOpenYn")=='N') {
			$("#pwdContId").val($(this).attr("nextId"));
			
			$.ajax({
		        url: "/front/board/pwdCheck.do",
		        dataType: "json",
		        type:"post",
		        data: {
		        	contId : $("#pwdContId").val(),
		        	boardId : $("#boardId").val()
		        },
		        success: function(data) {
		        	if (data.success == "true") {
		        		$("#writeFrm").attr("target", "_self");
		        		$("#writeFrm").attr("action", boardContentsViewUrl);
		        		$("#writeFrm").submit();
		                return;
					} else {
		        		if((auth_sname == "") || (auth_sname == null)) {
		        			if(confirm("비공개 글입니다. 실명인증을 하시겠습니까?")) {
		        				$("#requestUrl").val(window.location.pathname);        			    
		        			    $("#writeFrm").attr("target", "_self");
				        		$("#writeFrm").attr("action", "/front/auth/authCheck.do");
				        		$("#writeFrm").submit();
				        		return;
		        			} else {
		        				return;
		        			}
		        		}
		        		alert("비공개 글은 작성자 본인만 열람 하실수 있습니다.");
		        	}
		        },
		        error: function(e) {
		            //alert("테이블을 가져오는데 실패하였습니다.");
		        }
		    });			
			return;
		}

		$("#writeFrm").attr("target", "_self");
		$("#writeFrm").attr("action", boardContentsViewUrl);
		$("#writeFrm").submit();
	});
	
	// "게시물 등록화면 가기 (.btn_insert_submit)" (2018.07.11(수))
	$(".btn_insert_submit").click(function(){
		/*        // 2019.04.05 개인정보 처리 지적 후속 조치
		if($("#boardId").val() == "51") {
			if("${MEMBER_AUTH.sName}"==""||"${MEMBER_AUTH.sName}"==null) {
				alert("실명인증을 먼저 하셔야 합니다.");
				return;
			}
		}
		*/
	    $("#listFrm").attr("target", "_self");
	    $("#listFrm").attr("action", boardContentsWriteUrl);
	    $("#listFrm").attr("method", "post");		//	웹 호환성 진단 조치로 get 방식으로 수정 -> 글쓰기 화면으로 이동할 때 post로 변경    2021.05.12
	    $("#listFrm").submit();
	});
	
	// "실명인증하기 (.btn_diskey_pass_submit)" (2018.07.11(수))
	$(".btn_diskey_pass_submit").click(function(){
		if(confirm("실명인증 후 등록이 가능합니다.\n실명인증을 하시겠습니까?")){
			$("#requestUrl").val(window.location.pathname);
			$("#listFrm").attr("target", "_self");
			$("#listFrm").attr("action", "/front/auth/authCheck.do");
			$("#listFrm").submit();
			return;
		} else {
			return;
		}
	});
	
	// "답변하기 (.btn_reply)" (2018.07.11(수))
	$(".btn_reply").click(function(){
		$("#mode").val("R");
		$("#writeFrm").attr("target", "_self");
		$("#writeFrm").attr("action", boardContentsWriteUrl);
		$("#writeFrm").submit();
	});
	
	// "수정하기 (.btn_modify)" (2018.07.11(수))
	$(".btn_modify").click(function(){
		$("#writeFrm").attr("target", "_self");
		$("#writeFrm").attr("action", boardContentsWriteUrl);
		$("#writeFrm").submit();
	});
	
	// "게시물 삭제하기 (.btn_cancel)" (2018.07.11(수))
	$(".btn_cancel").click(function(){
		if (confirm('게시물을 삭제하시겠습니까?')) {			
			$.ajax({
				type: "POST",
				url: deleteBoardContentsUrl,
				data :jQuery("#writeFrm").serialize(),
				dataType: 'json',
				success:function(data){
					alert(data.message);
					if(data.success == "true") {					
						$("#writeFrm").attr("target", "_self");
						$("#writeFrm").attr("action", boardContentsListPageUrl);
						$("#writeFrm").submit();
					}
				}
			});
	    }
	});
	
	// 등록/수정하기
	$(".btn_edit_submit").click(function(){
		if($("#board_id").val()=="20057"){
			/*
			if($("input:radio[name=chkYn]:checked").val()=="N"){
				alert("개인정보 활용에 동의해주세요");
				return;
			}
			 */
			//$("input[name=regMemNm]").val(replaceAt($("input[name=regMemNm]").val(),1,"*"));
			if($("input[name=etc2]").val().substring(0,2)=="01"){
				alert("휴대전화번호는 입력하실수 없습니다.");
				return;
			}
		}
		
		if($("#board_id").val() == "20082"){
			
			var isCellphone = false;
			
			if(($("input[name=etc7]").val().substr(0,3) == "010") || 
					($("input[name=etc7]").val().substr(0,3) == "016") ||
					($("input[name=etc7]").val().substr(0,3) == "017") || 
					($("input[name=etc7]").val().substr(0,3) == "018") ||
					($("input[name=etc7]").val().substr(0,3) == "019")){
				isCellphone = true;
			}
			
			if(($("input[name=etc11]").val().substr(0,3) == "010") || 
					($("input[name=etc11]").val().substr(0,3) == "016") ||
					($("input[name=etc11]").val().substr(0,3) == "017") || 
					($("input[name=etc11]").val().substr(0,3) == "018") ||
					($("input[name=etc11]").val().substr(0,3) == "019")){
				isCellphone = true;
			}
			
			if(isCellphone){
				alert("개인 휴대전화는 입력하실수 없습니다.");
				return;
			}
			
			var temp_number = $("input[name=etc3]").val().toString();
			temp_number = temp_number.replace(/[^0-9]/g,'');
			temp_number = temp_number.substr(0,10);
			temp_number = temp_number.replace(/([0-9]{3})([0-9]{2})([0-9]{5})/,"$1-$2-$3");
			if(temp_number.length == 12){
				$("input[name=etc3]").val(temp_number);
			}
			else{
				alert("사업자 등록번호를 정확히 입력해주세요");
				return;
			}
			
			temp_number = $("input[name=etc7]").val().toString();
			temp_number = temp_number.replace(/[^0-9]/g,'');
			if(temp_number.length == 11){
				temp_number = temp_number.replace(/([0-9]{3})([0-9]{4})([0-9]{4})/,"$1-$2-$3");
			}
			else if((temp_number.length == 10) && (temp_number.substr(0,2) != "02")){
				temp_number = temp_number.replace(/([0-9]{3})([0-9]{3})([0-9]{4})/,"$1-$2-$3");
			}
			else if((temp_number.length == 10) && (temp_number.substr(0,2) == "02")){
				temp_number = temp_number.replace(/([0-9]{2})([0-9]{4})([0-9]{4})/,"$1-$2-$3");
			}
			if(temp_number.length == 8){
				temp_number = temp_number.replace(/([0-9]{2})([0-9]{3})([0-9]{4})/,"$1-$2-$3");
			}
			$("input[name=etc7]").val(temp_number);
			
			temp_number = $("input[name=etc8]").val().toString();
			temp_number = temp_number.replace(/[^0-9]/g,'');
			if(temp_number.length == 11){
				temp_number = temp_number.replace(/([0-9]{3})([0-9]{4})([0-9]{4})/,"$1-$2-$3");
			}
			else if((temp_number.length == 10) && (temp_number.substr(0,2) != "02")){
				temp_number = temp_number.replace(/([0-9]{3})([0-9]{3})([0-9]{4})/,"$1-$2-$3");
			}
			else if((temp_number.length == 10) && (temp_number.substr(0,2) == "02")){
				temp_number = temp_number.replace(/([0-9]{2})([0-9]{4})([0-9]{4})/,"$1-$2-$3");
			}
			if(temp_number.length == 8){
				temp_number = temp_number.replace(/([0-9]{2})([0-9]{3})([0-9]{4})/,"$1-$2-$3");
			}
			$("input[name=etc8]").val(temp_number);
			
			temp_number = $("input[name=etc11]").val().toString();
			temp_number = temp_number.replace(/[^0-9]/g,'');
			if(temp_number.length == 11){
				temp_number = temp_number.replace(/([0-9]{3})([0-9]{4})([0-9]{4})/,"$1-$2-$3");
			}
			else if((temp_number.length == 10) && (temp_number.substr(0,2) != "02")){
				temp_number = temp_number.replace(/([0-9]{3})([0-9]{3})([0-9]{4})/,"$1-$2-$3");
			}
			else if((temp_number.length == 10) && (temp_number.substr(0,2) == "02")){
				temp_number = temp_number.replace(/([0-9]{2})([0-9]{4})([0-9]{4})/,"$1-$2-$3");
			}
			if(temp_number.length == 8){
				temp_number = temp_number.replace(/([0-9]{2})([0-9]{3})([0-9]{4})/,"$1-$2-$3");
			}
			$("input[name=etc11]").val(temp_number);
			if ($("#attached_file").val() != "" && !$("#attached_file").val().toLowerCase().match(/\.(hwp|pdf)$/)){
			alert("확장자가 hwp|pdf 파일만 업로드가 가능합니다.");
			return;
		}

		}
		
		var url = "";
		var resultTextValue = "false";
		
		
		
		if ( $("#writeFrm").parsley().validate() ){
			// 로그인 여부 확인하기
			var sid = memId;
			if($("#mode").val() != "E"){
				if(sid == ""){
					// 개인정보 동의 여부 확인
					if($("#phone2").val() != undefined && $("#phone3").val() != undefined){
						if(!$("#agreement").is(":checked")){
							alert("개인정보 동의가 필요합니다.");
							return;
						}
					}
				}
			}
			
		   if($("#mode").val() == "E"){
			   url = updateBoardContentsUrl;
		   }else if($("#mode").val() == "R"){
			   url = insertBoardContentsReplyUrl;
		   }else{
			   url = insertBoardContentsUrl;
		   }
		   
		   //	비밀번호 검사 - 모태펀드 상담신청 / 질의응답 / 고객제안 - 2021.02.08 추가
		   if ( $("#board_id").val() == "20057" || $("#board_id").val() == "51" || $("#board_id").val() == "20062") {
			   var rValue = $('input[name="openYn"]:checked').val();
			   var pValue = $('input[name="password"]').val();
			   if ( rValue == "N" ) {
				   if ( ($.trim(pValue) == "") ) {
					   alert("공개여부를 '비공개'로 설정한 경우 비밀번호가 필요합니다.");
					   $('input[name="password"]').val("");
					   $('input[name="password"]').focus();
					   return false;
				   }
			   }
		   }

		   // 데이터를 등록 처리해준다.
		   $("#writeFrm").ajaxSubmit({
				success: function(responseText, statusText){
					if(responseText.success == "true"){
						resultTextValue = "true";
						alert(responseText.message);
						$("#writeFrm").attr("target", "_self");
						$("#writeFrm").attr("action", listUrl);
						$("#writeFrm").submit();
						//sand();
						$("#writeFrm").ajaxSubmit({
							success: function(responseText, statusText){
								//alert(responseText.message);
								if(responseText.success == "true"){
								}
							},
							dataType: "json",
							url: emaileUrl
					    });
						
						//list();
						
						$("#writeFrm").attr("target", "_self");
						$("#writeFrm").attr("action ", listUrl);
					    $("#writeFrm").submit();
					}else{
						alert(responseText.message);
					}
					
					// 첨부파일 업로드 실패시 로직 추가 (첨부파일 업로드 제한)
					if(responseText.success == "false") {
						if(responseText.isUpload == "false") {
							alert(responseText.message);
							return;
						}
					}
				},
				dataType: "json",
				url: url
		    });
		   
	   }
	});
	
	// "목록 페이지로 가기 (.btn_list_submit)" (2018.07.13(금))
	$(".list2").click(function(){
		$("#writeFrm").attr("target", "_self");
		$("#writeFrm").attr("action", boardContentsListPageUrl);
		$("#writeFrm").submit();
	});
	
	// "목록 페이지로 가기 (.btn_list_submit)" (2018.07.11(수))
	$(".btn_list_submit").click(function(){
		$("#writeFrm").attr("target", "_self");
		$("#writeFrm").attr("action", boardContentsListPageUrl);
		$("#writeFrm").submit();
	});
	
	// "목록 페이지로 가기 (.btn_list)" (2018.07.12(목))
	$(".btn_list").click(function(){
		$("#writeFrm").attr("target", "_self");
		$("#writeFrm").attr("action", boardContentsListPageUrl);
		$("#writeFrm").submit();
	});
	
	// "목록 페이지로 가기 (.btn_list_cancel_submit)" (2018.07.11(수))	- 2021.05.12 "취소"로 변경, 경고문구 출력 추가 
	$(".btn_list_cancel_submit").click(function(){
		if (confirm("작성을 취소하시겠습니까?\n\n작성된 내용은 저장되지 않으며 완전히 삭제됩니다.")) {
			$("#writeFrm").attr("target", "_self");
			$("#writeFrm").attr("action", listUrl);
			$("#writeFrm").submit();
		}
	});
	
	// "전송버튼 (#saveBtn)" (2018.07.11(수))
    $("#saveBtn").click(function() {
    	chk = "N";
        if (!$.trim($('#pass').val())) {
            alert('비밀번호를 입력해주세요');
            $('#pass').focus();
            return;
        }
        
        $.ajax({
            type: 'post',
            url: chkBoardPassUrl,
            dataType: 'json',
            data: $('#writeFrm').serialize(),
            success: function(data) {
                if (data.success == 'true') {
                	chk = "Y";
                	
                	if(rtValue == "V") {
                		//contentsView();
                		$("#chkpass").val(chk);
                		$("#writeFrm").attr("target", "_self");
                    	$("#writeFrm").attr("action", boardContentsViewUrl);
                    	$("#writeFrm").submit();              		
                	} else {
	                    if($("#mode").val() == "E") {
	                    	//contentsEdit();
	                    	
	                    	$("#chkpass").val(chk);
	                    	$("#writeFrm").attr("target", "_self");
	                    	$("#writeFrm").attr("action", boardContentsWriteUrl);
	                    	$("#writeFrm").submit();
	                    } else {
	                    	//contentsDelete();
	                    	if(chk != "Y"){
	                    		alert("잘못된 접근입니다.");
	                    	}
	                        var url = deleteBoardContentsUrl;
	                    	if (confirm('게시물을 삭제하시겠습니까?')) {
	                    		$.ajax({
	                    			type: "POST",
	                    			url: url,
	                    			data :jQuery("#writeFrm").serialize(),
	                    			dataType: 'json',
	                    			success:function(data){
	                    				alert(data.message);
	                    				if(data.success == "true"){
	                    					//list();	                    					
	                    					$("#writeFrm").attr("target", "_self");
	                    					$("#writeFrm").attr("action", boardContentsListPageUrl);
	                    					$("#writeFrm").submit();
	                    				}
	                    			}
	                    		});
	                        }
	                    }
	                }
                } else {
                    alert('비밀번호가 일치하지 않습니다');
                    $('#pass').val('').focus();
                }
            }
        });
    });
	
});