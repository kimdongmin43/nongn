
// ��ũ�� ��� 2012
function stateScrollObj(param,obj,btn,interval,speed,viewSize,moreSize,dir,data,auto,hover,method,op1,btn2){
	var param = $(param);
	var btn = $(btn);
	var obj = param.find(obj);
	var btn2 = $(btn2);
	
	var elem = 0;
	var objYScale = obj.eq(elem).height()+moreSize;
	var objXScale = obj.eq(elem).width()+moreSize;
	var str;
	var returnNodes;

	var playdir = data;
	var data = data; // 0:default, 1:prev

	/*var play = btn.find("[rel=play]");
	var stop = btn.find("[rel=stop]");*/
	/*var play = btn2.find("[rel=play]");
	var stop = btn2.find("[rel=stop]");*/
	var play = btn2.find("[rel=play]");
	var stop = btn2.find("[rel=stop]");
	
	if(auto == true) stop.hide(); else play.hide();  
	if(op1 == true) obj.not(elem).css({opacity:0}).eq(elem).css({opacity:1});
	
	function movement(){
		if(obj.parent().find(":animated").size()) return false;
		switch(data){
			case 0:
				if(dir == "x"){
					obj.parent().stop(true,true).animate({left:-objXScale},{duration:speed,easing:method,complete:
						function(){
							obj.parent().css("left",0);
							str = obj.eq(elem).detach();
							obj.parent().append(str);
							if(elem == obj.size()-1){
								elem = 0;
							}else{
								elem++;
							}
							objXScale = obj.eq(elem).width()+moreSize;
						}
					});
					if(op1 == true){
						obj.eq(elem).stop(true,true).animate({opacity:0},{duration:speed,easing:method});
						obj.eq(elem).next().stop(true,true).animate({opacity:1},{duration:speed,easing:method});
						//obj.eq(elem).stop(true,true).fadeOut(speed);
						//obj.eq(elem).next().stop(true,true).fadeIn(speed);
						//obj.eq(elem).css({"z-index":"0"});
						//obj.eq(elem).next().css({"z-index":"1"});
					}
				}else{ 
					obj.parent().stop(true,false).animate({top:-objYScale},{duration:speed,easing:method,complete:
						function(){
							obj.parent().css("top",0);
							str = obj.eq(elem).detach();
							obj.parent().append(str);
							if(elem == obj.size()-1){
								elem = 0;
							}else{
								elem++;
							}
							objYScale = obj.eq(elem).height()+moreSize;
						}
					});
				}
			break;
			
			case 1:
				if(dir == "x"){
					if(elem == 0){
						elem = obj.size()-1;
					}else{
						elem--;
					}
					objXScale = obj.eq(elem).width()+moreSize;
					obj.parent().css("left",-objXScale);
					str = obj.eq(elem).detach();
					obj.parent().prepend(str);
					obj.parent().stop(true,false).animate({left:0},{duration:speed,easing:method});
					if(op1 == true){
						obj.eq(elem).stop(true,false).animate({opacity:1},{duration:speed,easing:method});
						obj.eq(elem).next().stop(true,false).animate({opacity:0},{duration:speed,easing:method});
						//obj.eq(elem).stop(true,false).fadeIn(speed);
						//obj.eq(elem).next().stop(true,false).fadeOut(speed);
						//obj.eq(elem).css({"z-index":"1"});
						//obj.eq(elem).next().css({"z-index":"0"});
					}
				}else{
					if(elem == 0){
						elem = obj.size()-1;
					}else{
						elem--;
					}
					objYScale = obj.eq(elem).height()+moreSize;
					obj.parent().css("top",-objYScale);
					str = obj.eq(elem).detach();
					obj.parent().prepend(str);
					obj.parent().stop(true,false).animate({top:0},{duration:speed,easing:method});
				}
			break;
			
			default: alert("warning, 0:default, 1:prev, data:"+data);
		}
	}
	
	function rotate(){
		clearInterval(returnNodes);
		returnNodes = setInterval(function(){
			movement();
		},interval);
	}

	btn.find("a").click(function(){return false;});
	if(obj.size() <= viewSize) return false;
	
	/*btn.find("a[rel=play]").click(function(){
		data = playdir;
		play.hide();
		stop.show();
		rotate();
	});
	
	btn.find("a[rel=stop]").click(function(){
		clearInterval(returnNodes);
		param.find(":animated").stop();
		stop.hide();
		play.show();
	});*/
	
	btn2.find("[rel=play]").click(function(){
		/*data = playdir;
		play.hide();
		stop.show();
		rotate();*/
		clearInterval(returnNodes);
		param.find(":animated").stop();
		/*stop.hide();
		play.show();*/
		stop.show();
		play.hide();
	});
	
	//btn2.find("a[rel=stop]").click(function(){
	btn2.find("[rel=stop]").click(function(){
		/*clearInterval(returnNodes);
		param.find(":animated").stop();
		stop.hide();
		play.show();*/
		//hover = false;
		data = playdir;
		/*play.hide();
		stop.show();*/
		play.show();
		stop.hide();
		rotate();
	});
	
	btn.find("a[rel=prev]").click(function(){
		clearInterval(returnNodes);
		data = 1;
		movement();
		
		// add
		/*stop.hide();
		play.show();*/
	});
	
	btn.find("a[rel=next]").click(function(){
		clearInterval(returnNodes);
		data = 0;
		movement();
		
		// add
		/*stop.hide();
		play.show();*/
	});
	
	
/*	console.log("hover end : " + hover);
	if(hover == true){
//		obj.hover(function(){
//			clearInterval(returnNodes);
//		},function(){
//			rotate();
//		});
		obj.hover(function(){
			clearInterval(returnNodes);
			console.log("aaaaaaaaa");
		},function(){
			rotate();
		});

	}*/
	
	if(auto == true) rotate();
}

/*****************************************
 *-------------------------------���� �ϴܺ��� �Ѹ�
* $.fn.moveContents.defaults = {
*		eventEl : ".link-tab>a",				//Ŭ���̺�Ʈ element
*		conEl : ".link-con>div",				//display ������ element
*		defaultIndex : 0,						//�ʱ� ������ ������ index��
*		addContain : null,						//������ container�� �߰��Ǵ� Ŭ������
*		onClass : "on",							//���缱�õ� ������ eventEl �� �߰��� Ŭ������
*		onImage : false,						//eventEl �̺�Ʈ�߻��� ���� �̹��� on/off ��Ʈ��
*		iconFlag : true,							//��������Ʈ�ѷ� ��¿���
*		iconFlagEvent : "click",				//eventEl �̺�Ʈ
*		btnFlag : false,							//��ư��Ʈ�ѷ� ��¿���
*		btnFlagAll: false,						//��ư��Ʈ�ѷ��� ���� �ݺ����� (false������ ����/������������ ������� ��ư����)
*		btnFlagDisabled : false,			//��ư��Ʈ�ѷ� �׻���
*		btnPrev : ".btn-prev",				//������ư ������
*		btnNext : ".btn-next",					//������ư ������
*		btnPrevOff : "btn-prev-off",		//�̵��� �������� ���� �� ������ư ������ �߰� Ŭ����(btnFlagDisabled true �϶�)
*		btnNextOff : "btn-next-off",			//�̵��� �������� ���� �� ������ư ������ �߰� Ŭ����(btnFlagDisabled true �϶�)
*		autoPlay : false,						//�ڵ���ȯ����
*		delayTimer : 0,							//�ʱ� �ִϸ��̼� �߻��ð�
*		changeTimer : 2000,					//�ڵ���ȯ�ð�
*		controlFlag : false,					//����� ��Ʈ�� ��뿩��
*		btnPlay : ".btn-play",					//�ִϸ��̼� ���۹�ư������
*		btnStop : ".btn-stop",				//�ִϸ��̼� ������ư ������
*		effect : "show",							//����������ȿ��(show / fade / slide)
*		easing : "linear",						//�ִϸ��̼� ȿ��
*		aniTimer : 400,							//easing duration��
*		slideFor : "left",							//slide effect �̵�����(left, right, top, bottom)
*		slideValue : null,						//slide effect �̵���
*		slideView : 1,							//�����̵��������� �������� ������ ����
*		slideRepeat : false,					//slide ������ �ݺ�����
*		circleRatio : 0.8,						//circle�϶� ���� deps��� ����deps ������ ��Һ���
*		circleSide : 20,							//�¿� ���� ������ ������ ����
*		circleOpacity : 0.9,					//���� ������ ����
*		accordionMin : 50,					//effect accordion�϶� close ������ ������
*		accordionMax : null,				//effect accordion�϶� open ������ ������
*		conEvent : "click",						//effect accordion�϶� ������ ���� �̺�Ʈ
*		changeCallBack : null,				//������ ����� ȣ���Լ�
*		conCallBack : null,					//������ ���ý� ȣ���Լ�
*		eventReturn : false					//eventEl Ŭ���� return��(boolean��)
*	};
*****************************************/

(function($) {

    $.fn.moveContents = function(options) {
        return this.each(function() {
            var opts = $.extend({}, $.fn.moveContents.defaults, options || {});
            options = options || {};
            var $cont = $(this); 																		//�̵������� ��ü element
            var $contEventEl = opts.iconFlag ? $cont.find(opts.eventEl) : null; 	//Ŭ���̺�Ʈ element
            var $contEventCon = $cont.find(opts.conEl); 									//���� ���������� element
            var $contConCnt = $contEventCon.length; 										//��������������
            var $contSelIndex = opts.defaultIndex; 											//���缱�õ� �������� index��
            var $contTimer; 																			//�����÷��� �ð�����
            var $btnPrev = $cont.find(opts.btnPrev); 										//������ư
            var $btnNext = $cont.find(opts.btnNext); 										//������ư
            var $btnPlay = $cont.find(opts.btnPlay); 										//�������Ʈ�� �÷��̹�ư
            var $btnStop = $cont.find(opts.btnStop); 										//�������Ʈ�� ������ư
            var $moveMode = true; 																	//�����÷��� slide�� �ڵ����� ����
            var $playMode = true; 																	//����� ��Ʈ�ѷ��� ���� �ִϸ��̼� ����
            var $oldSelIndex; 																			//���õ� ������ ���� ���� index��
            var $iconMode; 																			//������Ŭ���̺�Ʈ�϶��� true

            if (opts.slideValue) {
                var $slideValue = opts.slideValue;
            }
            else {
                if (opts.slideFor == "left" || opts.slideFor == "right") var $slideValue = $contEventCon.eq(0).outerWidth();
                else var $slideValue = $contEventCon.eq(0).outerHeight();
            }

            if (opts.addContain) $cont.addClass(opts.addContain);

            /*********************************************************
            //������������ �����϶� �̺�Ʈ ����(�ϳ��϶��� ������ ��ư �����)
            **********************************************************/
            if ($contConCnt > 1) {

                /* ���÷��� �ʱ�ȭ - effect : slide */
                if (opts.effect == "slide") {
                    $contEventCon.each(function() {
                        var new_position = newPosition($(this));
                        switch (opts.slideFor) {
                            case "right":
                                $(this).css({ "right": new_position });
                                break;

                            case "top":
                                $(this).css({ "top": new_position });
                                break;

                            case "bottom":
                                $(this).css({ "bottom": new_position });
                                break;

                            default:
                                $(this).css({ "left": new_position });
                                break;
                        }

                        if ($contEventEl) $contEventEl.eq($contSelIndex).addClass(opts.onClass);
                    });

                    /* ���÷��� �ʱ�ȭ - effect : circle  */
                } else if (opts.effect == "circle") {
                    $contEventCon.eq(0).addClass("on");
                    var viewSize = opts.circleSide;
                    var $sideDeps = Math.floor(($contConCnt + 2) / 3);

                    $cont.css("width", $contEventCon.eq(0).outerWidth() + (($contConCnt - 1) * viewSize));

                    //��»����� ����
                    var $circle_info = new Array();

                    $circle_info[0] = new Array();
                    $circle_info[0]["width"] = $contEventCon.eq(0).width();
                    $circle_info[0]["height"] = $contEventCon.eq(0).height();
                    $circle_info[0]["left"] = opts.circleSide * $sideDeps;
                    $circle_info[0]["top"] = 0;
                    $circle_info[0]["z-index"] = $contEventCon.eq(0).css("z-index");

                    for (i = 1; i <= $sideDeps; i++) {
                        $circle_info[i] = new Array();
                        $circle_info[i]["width"] = $circle_info[i - 1]["width"] * opts.circleRatio;
                        $circle_info[i]["height"] = $circle_info[i - 1]["height"] * opts.circleRatio;
                        $circle_info[i]["top"] = ($circle_info[0]["height"] - $circle_info[i]["height"]) / 2;
                        $circle_info[i]["left_prev"] = $circle_info[0]["left"] - viewSize * i;
                        $circle_info[i]["left_next"] = $circle_info[0]["left"] + $circle_info[0]["width"] - ($circle_info[i]["width"] - viewSize * i);

                        //���̺� ������ ���λ����� = ����deps ���λ����� * ��Һ���
                        //���̺� ������ ���λ����� = ����deps ���λ����� * ��Һ���
                        //���̺� ������ Top ��ǥ = (�ֻ��������� ���̰� - �ڱ��ڽ� ���̰�) /2
                        //���̺� ���� ������ Left ��ǥ  = ���������� ������ǥ�� - (���� �������� ���� ���λ����� * deps)
                        //���̺� ���� ������ Left ��ǥ  = �ֻ��������� ������ǥ�� + �ֻ��������� ���λ����� - (�ڱ��ڽ� ��ü���λ����� - ���� �������� ���� ���λ�����)
                    }
                    moveAni_circle();

                    $contEventCon.bind("click", function() {
                        $contSelIndex = $contEventCon.index($(this));
                        moveAni_circle();
                    });

                    /* ���÷��� �ʱ�ȭ - effect : accordion */
                } else if (opts.effect == "accordion") {
                    var $accordionMax = opts.accordionMax ? opts.accordionMax : $contEventCon.eq(0).outerWidth();
                    $cont.css("width", ($contConCnt - 1) * opts.accordionMin + $accordionMax);
                    $contEventCon.bind(opts.conEvent, function() {
                        $contSelIndex = $contEventCon.index($(this));
                        moveAni_accordion();
                    });

                    if (opts.autoPlay && opts.conEvent == "mouseover") {
                        $contEventCon.on("hover focus",function() {
                            clearTimeout($contTimer);
                        }, function() {
                            $contTimer = setTimeout(moveIndexPlus, opts.changeTimer);
                        });
                    }
                    moveAni_accordion();

                    /* ���÷��� �ʱ�ȭ - effect : show , fade */
                } else {
                    $cont.each(function() {
                        $contEventCon.hide();
                        $contEventCon.eq($contSelIndex).show();
                        if ($contEventEl) $contEventEl.eq($contSelIndex).addClass(opts.onClass);
                    });
                }

                /* �����ܹ�ư ���÷��� */
                if (opts.iconFlag) displayIcon();

                /* �̵���ư(����,����) ���÷��� �� �̺�Ʈ����*/
                if (opts.btnFlag) {
                    moveContentsBtn();
                    if ($contConCnt > opts.slideView) {
                        $btnNext.bind("click", function() { if (!$(this).hasClass(opts.btnNextOff)) moveIndexPlus(); });
                        $btnPrev.bind("click", function() { if (!$(this).hasClass(opts.btnPrevOff)) moveIndexMinus(); });
                    }
                } else {
                    $btnPrev.hide();
                    $btnNext.hide();
                }

                /* $contEventEl �̺�Ʈ���� */
                if (opts.iconFlag) {
                    $contEventEl.bind(opts.iconFlagEvent, function() {
                        $moveMode = $contEventEl.index($(this)) - $contSelIndex > 0 ? true : false;
                        $iconMode = true;
                        $oldSelIndex = $contSelIndex;
                        $contSelIndex = $contEventEl.index($(this));
                        moveContentsAnimation();
                        return opts.eventReturn;
                    });
                } else {
                    if ($contEventEl) $contEventEl.hide();
                }

                /* �����÷��� �̺�Ʈ ����(������ ������ �����÷��� �Ͻø���) */
                $contEventCon.hover(function() {
                    clearTimeout($contTimer);
                }, function() {
                    if ($playMode && opts.autoPlay) callAnimation();
                });

                /* delayTimer�� ���� �ڵ��ִϸ޽ü� ����*/
                if ($playMode && opts.autoPlay) setTimeout(callAnimation, opts.delayTimer);

                /* �÷��� ��Ʈ�ѷ� ���� */
                if (opts.controlFlag) {
                    $btnPlay.bind("click", function() {
                        $playMode = true;
                        $contTimer = setTimeout(moveIndexPlus, opts.changeTimer);
                    });
                    $btnStop.bind("click", function() {
                        $playMode = false;
                        clearTimeout($contTimer);
                    });
                }

                /* �ݹ��Լ����� */
                if (opts.conCallBack) {
                    $contEventCon.bind("click", function() {
                        $contEventCon.removeClass("sel");
                        $(this).addClass("sel");
                        opts.conCallBack();
                    });
                }
            } else {
                $contEventEl.hide();
            }

            /********************************************************
            //��������������
            ********************************************************/
            function moveIndexPlus() {
                $moveMode = true;
                $oldSelIndex = $contSelIndex;
                $contSelIndex++;
                if ($contSelIndex > $contConCnt - 1) $contSelIndex = 0;
                moveContentsAnimation();
            }

            /*********************************************************
            //��������������
            *********************************************************/
            function moveIndexMinus() {
                $moveMode = false;
                $oldSelIndex = $contSelIndex;
                $contSelIndex--;
                if ($contSelIndex < 0) $contSelIndex = $contConCnt - 1;
                moveContentsAnimation();
            }

            /*********************************************************
            //�����÷��� ȣ�� �Լ�
            *********************************************************/
            function callAnimation() {
                clearTimeout($contTimer);
                $contTimer = setTimeout(moveIndexPlus, opts.changeTimer);
            }

            /*********************************************************
            //�����ܹ�ư ���÷����Լ�
            *********************************************************/
            function displayIcon() {
                $contEventCon.each(function() {
                    if ($contEventCon.index($(this)) != $contSelIndex) {
                        $contEventEl.eq($contEventCon.index($(this))).removeClass(opts.onClass);
                        if (opts.onImage) {
                            $contEventEl.eq($contEventCon.index($(this))).find('img').attr('src', function() { return $(this).attr("src").replace("_on", "_off"); });
                        }
                    } else {
                        $contEventEl.eq($contEventCon.index($(this))).addClass(opts.onClass);
                        if (opts.onImage) {
                            $contEventEl.eq($contEventCon.index($(this))).find('img').attr('src', function() { return $(this).attr("src").replace("_off", "_on"); });
                        };
                    }
                });
            }

            /*********************************************************
            //��ư ���÷��� ���� �Լ�
            *********************************************************/
            function moveContentsBtn() {
                if (opts.btnFlagDisabled) {
                    if ($contSelIndex < 1 && !opts.btnFlagAll) $btnPrev.addClass(opts.btnPrevOff);
                    else $btnPrev.removeClass(opts.btnPrevOff);

                    if ($contSelIndex + opts.slideView >= $contConCnt && !opts.btnFlagAll) $btnNext.addClass(opts.btnNextOff);
                    else $btnNext.removeClass(opts.btnNextOff);
                } else {
                    if ($contSelIndex < 1 && !opts.btnFlagAll) $btnPrev.hide();
                    else $btnPrev.show();

                    if (($contSelIndex >= $contConCnt - opts.slideView) && !opts.btnFlagAll) $btnNext.hide();
                    else $btnNext.show();
                }
            }

            /*********************************************************
            //���õ� index�� ���� �� ��ġ�� ���
            *********************************************************/
            function newPosition(obj) {
                var value = $contEventCon.index(obj) - $contSelIndex;
                if (opts.slideRepeat && !$iconMode) {
                    if ($moveMode) {
                        if (value >= opts.slideView) value = value - $contConCnt;
                        if (value < -1) value = value + $contConCnt;
                    } else {
                        if (value > opts.slideView) value = value - $contConCnt;
                        if (value <= (-1) * ($contConCnt - opts.slideView)) value = value + $contConCnt;
                    }
                }
                value = value * $slideValue;
                return value;
            }

            /*********************************************************
            //Animation - effect : show�϶�
            *********************************************************/
            function moveAni_show() {
                $contEventCon.each(function() {

                    if ($contSelIndex == $contEventCon.index($(this))) $(this).addClass(opts.onClass);
                    else $(this).removeClass(opts.onClass);

                    if ($contEventCon.index($(this)) != $contSelIndex) $(this).hide();
                    else $(this).show();
                });
            }

            /*********************************************************
            //Animation -effect : fade�϶�
            *********************************************************/
            function moveAni_fade() {
                $contEventCon.each(function() {

                    if ($contSelIndex == $contEventCon.index($(this))) $(this).addClass(opts.onClass);
                    else $(this).removeClass(opts.onClass);

                    if ($contEventCon.index($(this)) != $contSelIndex) $(this).fadeOut(opts.aniTimer);
                    else $(this).fadeIn(opts.aniTimer);
                });
            }

            /*********************************************************
            //Animation - effect : slide�϶�
            *********************************************************/
            function moveAni_slide() {

                /* �����̵�ݺ������϶� �ִϸ��̼� ȿ���� ���� ������ġ �缳�� */
                if (opts.slideRepeat) {
                    $contEventCon.each(function() {
                        var value = Number($(this).css(opts.slideFor).replace("px", "")) / $slideValue;
                        if ($moveMode) {
                            if (value < 0) value = value + $contConCnt;
                        }
                        else {
                            if (value > opts.slideView && opts.slideView > 1) value = value - $contConCnt;
                        }
                        value = value * $slideValue;
                        $(this).css(opts.slideFor, value);
                    });
                }

                /* ����ġ���� */
                $contEventCon.each(function() {

                    var new_position = newPosition($(this));

                    if ($contSelIndex == $contEventCon.index($(this))) $(this).addClass(opts.onClass);
                    else $(this).removeClass(opts.onClass);
                    if($(this).hasClass("on")){			//2024 웹 접근성 시작
                    	$(this).children('a').removeAttr('tabindex', '-1');
                    }else{
                    	$(this).children('a').attr('tabindex', '-1');
                    	$(this).removeAttr('class');
                    }									//2024 웹 접근성 끝
                    
                    switch (opts.slideFor) {
                        case "right":
                            $(this).stop().animate({ "right": new_position }, opts.aniTimer, opts.easing);
                            break;

                        case "top":
                            $(this).stop().animate({ "top": new_position }, opts.aniTimer, opts.easing);
                            break;

                        case "bottom":
                            $(this).stop().animate({ "bottom": new_position }, opts.aniTimer, opts.easing);
                            break;

                        default:
                            $(this).stop().animate({ "left": new_position }, opts.aniTimer, opts.easing);
                            break;
                    }
                });
            }

            /*********************************************************
            //Animation - effect : circle�϶�
            *********************************************************/
            function moveAni_circle() {
                $contEventCon.eq($contSelIndex)
					.addClass("on")
					.css("z-index", $circle_info[0]["z-index"])
					.animate({
					    "opacity": 1,
					    "left": $circle_info[0]["left"],
					    "top": $circle_info[0]["top"],
					    "width": $circle_info[0]["width"],
					    "height": $circle_info[0]["height"]
					}, opts.aniTimer, opts.easing);

                for (i = 1; i <= $sideDeps; i++) {
                    prevIndex = $contSelIndex - i;
                    if (prevIndex < 0) prevIndex = prevIndex + $contConCnt;

                    nextIndex = $contSelIndex + i;
                    if (nextIndex >= $contConCnt) nextIndex = nextIndex - $contConCnt;

                    var newIndex = $circle_info[0]["z-index"] - (i * 2);
                    if ($moveMode) {
                        var newIndex_prev = newIndex - 1;
                        var newIndex_next = newIndex - 2;
                    } else {
                        var newIndex_prev = newIndex - 2;
                        var newIndex_next = newIndex - 1;
                    }

                    $contEventCon.eq(prevIndex)
						.removeClass("on")
						.css("z-index", newIndex_prev)
						.animate({
						    "opacity": opts.circleOpacity,
						    "left": $circle_info[i]["left_prev"],
						    "top": $circle_info[i]["top"],
						    "width": $circle_info[i]["width"],
						    "height": $circle_info[i]["height"]
						}, opts.aniTimer, opts.easing);

                    $contEventCon.eq(nextIndex)
						.removeClass("on")
						.css("z-index", newIndex_next)
						.animate({
						    "opacity": opts.circleOpacity,
						    "left": $circle_info[i]["left_next"],
						    "top": $circle_info[i]["top"],
						    "width": $circle_info[i]["width"],
						    "height": $circle_info[i]["height"]
						}, opts.aniTimer, opts.easing);
                }
            }

            /*********************************************************
            //Animation - effect : accordion�϶�
            *********************************************************/
            function moveAni_accordion() {
                $contEventCon.each(function() {
                    var new_position = opts.accordionMin * $contEventCon.index($(this));
                    if ($contSelIndex < $contEventCon.index($(this))) new_position = new_position + ($accordionMax - opts.accordionMin);

                    $(this).stop(true).animate({
                        "left": new_position
                    }, opts.aniTimer, opts.easing);

                    if ($contEventCon.index($(this)) == $contSelIndex) $(this).addClass(opts.onClass);
                    else $(this).removeClass(opts.onClass);
                });
            }

            /*********************************************************
            //������ ���÷��� �Լ�
            *********************************************************/
            function moveContentsAnimation() {

                clearTimeout($contTimer);

                switch (opts.effect) {
                    case "fade":
                        moveAni_fade();
                        break;

                    case "slide":
                        moveAni_slide();
                        break;

                    case "circle":
                        moveAni_circle();
                        break;

                    case "accordion":
                        moveAni_accordion();
                        break;

                    default:
                        moveAni_show();
                        break;
                }

                //�����ܹ�ư �缳��
                if (opts.iconFlag) displayIcon();

                //�̵���ư��� �缳��
                if (opts.btnFlag) moveContentsBtn();

                //�����÷��� �缳��
                if (opts.autoPlay && $playMode) callAnimation();

                //�ݹ��Լ�
                if (opts.changeCallBack) opts.changeCallBack();

                $iconMode = false;
            }
        });
    };

    $.fn.moveContents.defaults = {
        eventEl: ">ul a",
        conEl: ">div",
        defaultIndex: 0,
        addContain: null,
        onClass: "on",
        onImage: false,
        iconFlag: true,
        iconFlagEvent: "click",
        btnFlag: false,
        btnFlagAll: false,
        btnFlagDisabled: false,
        btnPrev: ".btn-prev",
        btnNext: ".btn-next",
        btnPrevOff: "btn-prev-off",
        btnNextOff: "btn-next-off",
        autoPlay: false,
        delayTimer: 0,
        changeTimer: 2000,
        controlFlag: false,
        btnPlay: ".btn-play",
        btnStop: ".btn-stop",
        effect: "show",
        easing: "linear",
        aniTimer: 600,
        slideFor: "left",
        slideValue: null,
        slideView: 1,
        slideRepeat: false,
        circleRatio: 0.8,
        circleSide: 20,
        circleOpacity: 0.9,
        accordionMin: 50,
        accordionMax: null,
        conEvent: "click",
        changeCallBack: null,
        conCallBack: null,
        eventReturn: false
    };

})(jQuery);
