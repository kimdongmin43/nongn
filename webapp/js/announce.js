function initDate(){
	$('.datepicker').each(function(){
	    $(this).datepicker({
			  format: "yyyy-mm-dd",
			  language: "kr",
			  keyboardNavigation: false,
			  forceParse: false,
			  autoclose: true,
			  todayHighlight: true,
			  showOn: "button",
			  buttonImage:"/images/back/icon/icon_calendar.png",
			  buttonImageOnly:true,
			  changeMonth: true,
	          changeYear: true,
	          showButtonPanel:false
			 });
	});
}

function delTableRow(objId){
	$("#"+objId+" > tbody >  tr").remove();
}

function createActSubmit(objId, seq){
     var str = "";
     
     for(var i = 1; i <= seq;i++){
	            str +='<tr>';
				str +='  <td class="first">'+i+'차<input type="hidden" id="act_seq" name="act_seq" value="'+i+'" /></td>';
				str +='  <td class="last alignl">';
				str +='    <input type="text" id="submit_stadt_'+i+'" name="submit_stadt_'+i+'" class="in_wp100 datepicker" readonly value="">';
				str +='    <label for="submit_stadt_hour_'+i+'" class="hidden">시간입력</label>';
				str +='    <select class="in_wp80" id="submit_stadt_hour_'+i+'" name="submit_stadt_hour_'+i+'">';
				str +='      <option value="00">00</option><option value="01">01</option><option value="02">02</option><option value="03">03</option><option value="04">04</option><option value="05">05</option>';
				str +='      <option value="06">06</option><option value="07">07</option><option value="08">08</option><option value="09">09</option><option value="10">10</option>';
				str +='      <option value="11">11</option><option value="12">12</option><option value="13">13</option><option value="14">14</option><option value="15">15</option>';
				str +='      <option value="16">16</option><option value="17">17</option><option value="18">18</option><option value="19">19</option><option value="20">20</option>';
				str +='      <option value="21">21</option><option value="22">22</option><option value="23">23</option>';
				str +='    </select>';
				str +='    <label for="submit_stadt_min_'+i+'" class="hidden">분입력</label>';
				str +='    <select class="in_wp80" id="submit_stadt_min_'+i+'" name="submit_stadt_min_'+i+'">';
				str +='                      <option value="00" >00</option><option value="01" >01</option><option value="02" >02</option><option value="03" >03</option><option value="04" >04</option><option value="05" >05</option>';
				str +='                      <option value="06" >06</option><option value="07" >07</option><option value="08" >08</option><option value="09" >09</option><option value="10" >10</option><option value="11" >11</option>';
				str +='                      <option value="12" >12</option><option value="13" >13</option><option value="14" >14</option><option value="15" >15</option><option value="16" >16</option><option value="17" >17</option>';
				str +='                      <option value="18" >18</option><option value="19" >19</option><option value="20" >20</option><option value="21" >21</option><option value="22" >22</option><option value="23" >23</option>';
				str +='                      <option value="24" >24</option><option value="25" >25</option><option value="26" >26</option><option value="27" >27</option><option value="28" >28</option><option value="29" >29</option>';
				str +='                      <option value="30" >30</option><option value="31" >31</option><option value="32" >32</option><option value="33" >33</option><option value="34" >34</option><option value="35" >35</option>';
				str +='                      <option value="36" >36</option><option value="37" >37</option><option value="38" >38</option><option value="39" >39</option><option value="40" >40</option><option value="41" >41</option>';
				str +='                      <option value="42" >42</option><option value="43" >43</option><option value="44" >44</option><option value="45" >45</option><option value="46" >46</option><option value="47" >47</option>';
				str +='                      <option value="48" >48</option><option value="49" >49</option><option value="50" >50</option><option value="51" >51</option><option value="52" >52</option><option value="53" >53</option>';
				str +='                      <option value="54" >54</option><option value="55" >55</option><option value="56" >56</option><option value="57" >57</option><option value="58" >58</option><option value="59" >59</option>';
				str +='    </select>';
				str +='    &nbsp;~&nbsp;';
				str +='    <input type="text" id="submit_enddt_'+i+'" name="submit_enddt_'+i+'" class="in_wp100 datepicker" readonly value="">';
				str +='    <label for="submit_enddt_hour_'+i+'" class="hidden">시간입력</label>';
				str +='    <select class="in_wp80" id="submit_enddt_hour_'+i+'" name="submit_enddt_hour_'+i+'">';
				str +='      <option value="00">00</option><option value="01">01</option><option value="02">02</option><option value="03">03</option><option value="04">04</option><option value="05">05</option>';
				str +='      <option value="06">06</option><option value="07">07</option><option value="08">08</option><option value="09">09</option><option value="10">10</option>';
				str +='      <option value="11">11</option><option value="12">12</option><option value="13">13</option><option value="14">14</option><option value="15">15</option>';
				str +='      <option value="16">16</option><option value="17">17</option><option value="18">18</option><option value="19">19</option><option value="20">20</option>';
				str +='      <option value="21">21</option><option value="22">22</option><option value="23">23</option>';
				str +='    </select>';
				str +='    <label for="submit_enddt_min_'+i+'" class="hidden">분입력</label>';
				str +='    <select class="in_wp80" id="submit_enddt_min_'+i+'" name="submit_enddt_min_'+i+'">';
				str +='                     <option value="00" >00</option><option value="01" >01</option><option value="02" >02</option><option value="03" >03</option><option value="04" >04</option><option value="05" >05</option>';
				str +='                      <option value="06" >06</option><option value="07" >07</option><option value="08" >08</option><option value="09" >09</option><option value="10" >10</option><option value="11" >11</option>';
				str +='                      <option value="12" >12</option><option value="13" >13</option><option value="14" >14</option><option value="15" >15</option><option value="16" >16</option><option value="17" >17</option>';
				str +='                      <option value="18" >18</option><option value="19" >19</option><option value="20" >20</option><option value="21" >21</option><option value="22" >22</option><option value="23" >23</option>';
				str +='                      <option value="24" >24</option><option value="25" >25</option><option value="26" >26</option><option value="27" >27</option><option value="28" >28</option><option value="29" >29</option>';
				str +='                      <option value="30" >30</option><option value="31" >31</option><option value="32" >32</option><option value="33" >33</option><option value="34" >34</option><option value="35" >35</option>';
				str +='                      <option value="36" >36</option><option value="37" >37</option><option value="38" >38</option><option value="39" >39</option><option value="40" >40</option><option value="41" >41</option>';
				str +='                      <option value="42" >42</option><option value="43" >43</option><option value="44" >44</option><option value="45" >45</option><option value="46" >46</option><option value="47" >47</option>';
				str +='                      <option value="48" >48</option><option value="49" >49</option><option value="50" >50</option><option value="51" >51</option><option value="52" >52</option><option value="53" >53</option>';
				str +='                      <option value="54" >54</option><option value="55" >55</option><option value="56" >56</option><option value="57" >57</option><option value="58" >58</option><option value="59" >59</option>';
				str +='    </select>';
				str +='  </td>';
				str +='</tr>';
       }
     
     $("#"+objId).append(str);
}				

function evalstdInsert(){
	   var stdGb = $("#std_gb").val();
	   var notworkPeriod = $("#notwork_period").val();
	   var familyCnt = 4;
	   
	   // 건강보험료 값 체크
	   for(var i =1; i <= stdGb; i++){
		   if($("#point_"+i).val() == ""){
			   alert("건강보험료 점수를 입력해주십시요");
			   return;
		   }
		   
		   if($("#insurancefrom_"+i).val() == "" || $("#insuranceto_"+i).val() == ""){
			   alert("월별 직장보험료를 입력해주십시요");
			   return;
		   }
		   
		   if($("#regionfrom_"+i).val() == "" || $("#regionto_"+i).val() == ""){
			   alert("월별 지역보험료를 입력해주십시요");
			   return;
		   }
	   }
	   // 미취업기간 값 체크
	   for(var i =1; i <= notworkPeriod; i++){
		   if($("#notworkpoint_"+i).val() == ""){
			   alert("미취업기간 점수를 입력해주십시요");
			   return;
		   }
		   
		   if($("#notworkfrom_"+i).val() > $("#notworkto_"+i).val()){
			   alert("미취업기간 범위를 정확히 입력해주십시요");
			   return;
		   }
	   }
	   // 부양가족 수 값 체크
	   for(var i =1; i <= familyCnt; i++){
		   if($("#family_"+i).val() == ""){
			   alert("가족수 점수를 입력해주십시요");
			   return;
		   }
	   }
}

function createInsurance(objId, seq){
     var str = "";
     
     for(var i = 1; i <= seq;i++){
    	 str += '<tr>';
    	 str += '  <td class="first">'+i+'</td>';
    	 str += '  <td>';
    	 str += '    <label class="hidden" for="inspoint_'+i+'">점수 입력창</label>';
    	 str += '    <input type="text" class="in_w80 onlynum" id="inspoint_'+i+'" name="inspoint_'+i+'" value="0" />';
    	 str += '  </td>';
    	 str += '  <td class="alignl">';
    	 if(i != 1){
    	 str += '    <input type="text" class="in_wp100 onlynum" id="insurancefrom_'+i+'"  name="insurancefrom_'+i+'" value="0" />';
    	 str += '    <label class="hidden" for="insurancefrom_'+i+'">월별 직장보험료 구간 초과 입력</label>';
    	 str += '    <span>초과</span>';
    	 str += '    <span class="marginr10 marginl10">~</span>';
    	 }
    	 if(i != seq){
    	 str += '    <input type="text" class="in_wp100 onlynum" id="insuranceto_'+i+'" name="insuranceto_'+i+'" value="0" />';
    	 str += '    <label class="hidden" for="insuranceto_'+i+'">월별 직장보험료 구간 이하 입력</label>';
    	 str += '    <span>이하</span>';
    	 }
    	 str += '  </td>';
    	 str += '  <td class="last alignl">';
    	 if(i != 1){
    	 str += '    <input type="text" class="in_wp100 onlynum" id="regionfrom_'+i+'" name="regionfrom_'+i+'"  value="0" />';
    	 str += '    <label class="hidden" for="regionfrom_'+i+'">월별 지역보험료 구간 초과 입력</label>';
    	 str += '    <span>초과</span>';
    	 str += '    <span class="marginr10 marginl10">~</span>';
    	  }
    	 if(i != seq){
    	 str += '    <input type="text" class="in_wp100 onlynum" id="regionto_'+i+'" name="regionto_'+i+'"  value="0" />';
    	 str += '    <label class="hidden" for="regionto_'+i+'">월별 지역보험료 구간 이하 입력</label>';
    	 str += '    <span>이하</span>';
    	 }
    	 str += '  </td>';
    	 str += '</tr>';
       }
     
     $("#"+objId).append(str);
}

function createNotwork(objId, seq){
     var str = "";
     
     for(var i = 1; i <= seq;i++){
    	 str += '<tr>';
    	 str += '  <td class="first">'+i+'</td>';
    	 str += '  <td>';
    	 str += '    <label class="hidden" for="notworkpoint_'+i+'">점수 입력창</label>';
    	 str += '    <input type="text" class="in_w80 onlynum" id="notworkpoint_'+i+'" name="notworkpoint_'+i+'" value="0" />';
    	 str += '  </td>';
    	 str += '  <td class="last">';
    	 if(i != seq){
    	 str += '    <label for="notworkfrom_'+i+'" class="hidden">미취업기간 설정</label>';
    	 str += '    <select class="in_wp100" id="notworkfrom_'+i+'" name="notworkfrom_'+i+'" >';
    	 str +='         <option value="1" >1</option><option value="2" >2</option><option value="3" >3</option><option value="4" >4</option><option value="5" >5</option>';
    	 str +='         <option value="6" >6</option><option value="7" >7</option><option value="8" >8</option><option value="9" >9</option><option value="10" >10</option><option value="11" >11</option>';
    	 str +='         <option value="12" >12</option><option value="13" >13</option><option value="14" >14</option><option value="15" >15</option><option value="16" >16</option><option value="17" >17</option>';
    	 str +='         <option value="18" >18</option><option value="19" >19</option><option value="20" >20</option><option value="21" >21</option><option value="22" >22</option><option value="23" >23</option>';
    	 str +='         <option value="24" >24</option><option value="25" >25</option><option value="26" >26</option><option value="27" >27</option><option value="28" >28</option><option value="29" >29</option>';
    	 str +='         <option value="30" >30</option><option value="31" >31</option><option value="32" >32</option><option value="33" >33</option><option value="34" >34</option><option value="35" >35</option>';
    	 str +='         <option value="36" >36</option>';
    	 str += '    </select>';
    	 str += '    <span>초과</span>';
    	 str += '    <span class="marginr10 marginl10">~</span>';
    	 }
    	 if(i != 1){
    	 str += '    <label for="notworkto_'+i+'" class="hidden">미취업기간 설정</label>';
    	 str += '    <select class="in_wp100" id="notworkto_'+i+'"  name="notworkto_'+i+'" value="${row.eval_to}" >';
    	 str +='         <option value="1" >1</option><option value="2" >2</option><option value="3" >3</option><option value="4" >4</option><option value="5" >5</option>';
    	 str +='         <option value="6" >6</option><option value="7" >7</option><option value="8" >8</option><option value="9" >9</option><option value="10" >10</option><option value="11" >11</option>';
    	 str +='         <option value="12" >12</option><option value="13" >13</option><option value="14" >14</option><option value="15" >15</option><option value="16" >16</option><option value="17" >17</option>';
    	 str +='         <option value="18" >18</option><option value="19" >19</option><option value="20" >20</option><option value="21" >21</option><option value="22" >22</option><option value="23" >23</option>';
    	 str +='         <option value="24" >24</option><option value="25" >25</option><option value="26" >26</option><option value="27" >27</option><option value="28" >28</option><option value="29" >29</option>';
    	 str +='         <option value="30" >30</option><option value="31" >31</option><option value="32" >32</option><option value="33" >33</option><option value="34" >34</option><option value="35" >35</option>';
    	 str +='         <option value="36" >36</option>';
    	 str += '    </select>';
    	 str += '    <span>이하</span>';
    	 }
    	 str += '  </td>';
    	 str += '</tr>';
       }
     
     $("#"+objId).append(str);
}	