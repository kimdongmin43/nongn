function searchMap(){
var width = 918,
    height = 700,
    initialScale = 5500,
    initialX = -11900,
    initialY = 4050,
    centered,
    labels;

var projection = d3.geo.mercator()
    .scale(initialScale)
    .translate([initialX, initialY]);

var path = d3.geo.path()
    .projection(projection);

var zoom = d3.behavior.zoom()
    .translate(projection.translate())
    .scale(projection.scale())
    .scaleExtent([height/0.15, 35 * height])
    .on("zoom", zoom)
    ;

var svg = d3.select("#maparea").append("svg")
    .attr("width", width)
    .attr("height", height)
    .attr('id', 'map');

var states = svg.append("g")
    .attr("id", "states")
    .call(zoom);

//Define quantize scale to sort data values into buckets of color
var color = d3.scale.linear()
	.domain([0,1])
    .range([
        "rgb(237,248,233)",
        "rgb(0,109,44)"
//		"rgb(255,232,232)",
//		"rgb(255,0,0)"
//			$("#minColor").val(),
//			$("#maxColor").val()
        ]);
        //Colors taken from colorbrewer.js, included in the D3 download
        //domain은 선형이지만 치역이 5개로 매핑됨.
        //domain은 데이터에서 min, max로 추출한다.

var tooltip = d3.select('#maparea')
.append('div')
.attr('class', 'tooltip');

var rTable = tooltip
.append('div')
.attr('class', 'rTable');

var rTableRow = rTable
.append('div')
.attr('class', 'rTableRow');

rTableRow.append('div')
.attr('class', 'nam')
.html("지자체명");
rTableRow.append('div')
.attr('class', 'label');

//rTableRow = rTable
//.append('div')
//.attr('class', 'rTableRow');
//
//rTableRow.append('div')
//.attr('class', 'nam')
//.html("비율");
//rTableRow.append('div')
//.attr('class', 'ratio');

rTableRow = rTable
.append('div')
.attr('class', 'rTableRow');
rTableRow.append('div')
.attr('class', 'nam')
.html("위험보험료");
rTableRow.append('div')
.attr('class', 'label1');

rTableRow = rTable
.append('div')
.attr('class', 'rTableRow');
rTableRow.append('div')
.attr('class', 'nam')
.html("가입금액");
rTableRow.append('div')
.attr('class', 'label2');

rTableRow = rTable
.append('div')
.attr('class', 'rTableRow');
rTableRow.append('div')
.attr('class', 'nam')
.html("지급금액");
rTableRow.append('div')
.attr('class', 'label3');

rTableRow = rTable
.append('div')
.attr('class', 'rTableRow');
rTableRow.append('div')
.attr('class', 'nam')
.html("보험금지급건수");
rTableRow.append('div')
.attr('class', 'label4');

rTableRow = rTable
.append('div')
.attr('class', 'rTableRow');
rTableRow.append('div')
.attr('class', 'nam')
.html("인원");
rTableRow.append('div')
.attr('class', 'label5');


states.append("rect")
    .attr("class", "background")
    .attr("width", width)
    .attr("height", height);


	d3.json("/js/map/korea.json", function(json) {
		  states.selectAll("path")
		      .data(json.features)
		      .enter().append("path")
		      .attr("d", path)
		      .attr("id", function(d) { return 'path-'+d.id; })
		      .style("fill", function(d,i) {return color(insu[d.id]["비율"]);})
		      .style("visibility", function(d){return d.id < 100 ? "visible" : "hidden"})
		      .on("click", click)
		      ;

		  states.selectAll("path").on('mouseover', function(d) {
			  tooltip.select('.label').html(insu[d.id]["시군구"]);
//			  tooltip.select('.ratio').html(insu[d.id]["비율"]);
			  tooltip.select('.label1').html(insu[d.id]["위험보험료"]);
			  tooltip.select('.label2').html(insu[d.id]["가입금액"]);
			  tooltip.select('.label3').html(insu[d.id]["지급금액"]);
			  tooltip.select('.label4').html(insu[d.id]["보험금지급건수"]);
			  tooltip.select('.label5').html(insu[d.id]["인원"]);
			  tooltip.style('display', 'block');
			})
			;

			states.selectAll("path").on('mouseout', function(d) {
				tooltip.style('display', 'none');
			})
			;


		  /*
		  labels = states.selectAll("text")
		    .data(json.features)
		    .enter().append("text")
		      .attr("transform", labelsTransform)
		      .attr("id", function(d) { return 'label-'+d.id; })
		      .attr('text-anchor', 'middle')
		      .attr("dy", ".35em")
		      .on("click", click)
		      .text(function(d) { return d.properties.name; });
		  */
		});




function click(d) {
	//console.log('>' + d.id);
	return;
  var x, y, k;

  if (d /*&& centered !== d*/ && d.id < 100) {
    var centroid = path.centroid(d);
    x = centroid[0];
    y = centroid[1];
    k = 4;
    centered = d;
  } else {
    x = width / 2;
    y = height / 2;
    k = 1;
    centered = null;
  }

  states.selectAll("path")
      .classed("active", centered && function(d) { return d === centered; });

  /*
  if (centered) {
	  var pid = d.id;

	  states.selectAll("path")
	  	.attr("d", path)
	  	.style("visibility", function(d){return pid == parseInt(d.id/100) || d.id < 100 ? "visible" : "hidden"})
	  	;
  } else {
	  states.selectAll("path")
	  	.attr("d", path)
	  	.style("visibility", function(d){return d.id < 100 ? "visible" : "hidden"})
	  	;
  }
  */
  states.transition()
      .duration(5000)
      .attr("transform", "translate(" + width / 2 + "," + height / 2 + ")scale(" + k + ")translate(" + -x + "," + -y + ")")
      .style("stroke-width", 1.5 / k + "px");
}

function zoom() {
    projection.translate(d3.event.translate).scale(d3.event.scale);

    states.selectAll("path").attr("d", path);

    if (zoom.scale() > 20000) {
	  states.selectAll("path")
	  	.attr("d", path)
	  	.style("visibility", function(d){return d.id >= 100 ? "visible" : "hidden"})
	  	;
    } else {
	  states.selectAll("path")
	  	.attr("d", path)
	  	.style("visibility", function(d){return d.id < 100 ? "visible" : "hidden"})
	  	;
    }

    //labels.attr("transform", labelsTransform);
}

function labelsTransform(d) {
  // 경기도가 서울특별시와 겹쳐서 예외 처리
  if (d.id == 8) {
    var arr = path.centroid(d);
    arr[1] += (d3.event && d3.event.scale) ? (d3.event.scale / height + 20) : (initialScale / height + 20);

    return "translate(" + arr + ")";
  } else {
    return "translate(" + path.centroid(d) + ")";
  }
}



// 버튼
/*
$('#radio').buttonset();
$('#zoomin').button({
  text: false,
  icons: {
    primary: "ui-icon-plus"
  }
}).click(function() {
  var arr = projection.translate(),
      scale = projection.scale();

  arr[0] = arr[0] * 1.2;
  arr[1] = arr[1] * 1.2;
  scale = scale * 1.2;

  projection.translate(arr).scale(scale);
  states.selectAll("path").attr("d", path);

  labels.attr("transform", labelsTransform);
});
$('#zoomout').button({
  text: false,
  icons: {
    primary: "ui-icon-minus"
  }
}).click(function() {
  var arr = projection.translate(),
      arr2 = projection.translate(),
      scale = projection.scale();

  arr[0] = arr[0] * 0.8;
  arr[1] = arr[1] * 0.8;
  scale = scale * 0.8;

  projection.translate(arr).scale(scale);
  states.selectAll("path").attr("d", path);

  labels.attr("transform", labelsTransform);
});

// 지명표시
$('#radio').find('input').on('click', function() {
  if (this.value == 'on') {
    labels.style('display', 'block');
  } else if (this.value == 'off') {
    labels.style('display', 'none');
  }
});
*/
}

var insu = {
		"50":{"시군구":"제주특별자치도","비율":0}
        ,"48":{"시군구":"경상남도","비율":0}
        ,"47":{"시군구":"경상북도","비율":0}
        ,"46":{"시군구":"전라남도","비율":0}
        ,"45":{"시군구":"전라북도","비율":0}
        ,"44":{"시군구":"충청남도","비율":0}
        ,"43":{"시군구":"충청북도","비율":0}
        ,"42":{"시군구":"강원도","비율":0}
        ,"41":{"시군구":"경기도","비율":0}
        ,"36":{"시군구":"세종특별자치시","비율":0}
        ,"31":{"시군구":"울산광역시","비율":0}
        ,"30":{"시군구":"대전광역시","비율":0}
        ,"29":{"시군구":"광주광역시","비율":0}
        ,"28":{"시군구":"인천광역시","비율":0}
        ,"27":{"시군구":"대구광역시","비율":0}
        ,"26":{"시군구":"부산광역시","비율":0}
        ,"11":{"시군구":"서울특별시","비율":0}
        ,"50130":{"시군구":"서귀포시","비율":0}
        ,"50110":{"시군구":"제주시","비율":0}
        ,"48890":{"시군구":"합천군","비율":0}
        ,"48880":{"시군구":"거창군","비율":0}
        ,"48870":{"시군구":"함양군","비율":0}
        ,"48860":{"시군구":"산청군","비율":0}
        ,"48850":{"시군구":"하동군","비율":0}
        ,"48840":{"시군구":"남해군","비율":0}
        ,"48820":{"시군구":"고성군","비율":0}
        ,"48740":{"시군구":"창녕군","비율":0}
        ,"48730":{"시군구":"함안군","비율":0}
        ,"48720":{"시군구":"의령군","비율":0}
        ,"48129":{"시군구":"창원시진해구","비율":0}
        ,"48127":{"시군구":"창원시마산회원구","비율":0}
        ,"48125":{"시군구":"창원시마산합포구","비율":0}
        ,"48123":{"시군구":"창원시성산구","비율":0}
        ,"48121":{"시군구":"창원시의창구","비율":0}
        ,"48330":{"시군구":"양산시","비율":0}
        ,"48310":{"시군구":"거제시","비율":0}
        ,"48270":{"시군구":"밀양시","비율":0}
        ,"48250":{"시군구":"김해시","비율":0}
        ,"48240":{"시군구":"사천시","비율":0}
        ,"48220":{"시군구":"통영시","비율":0}
        ,"48170":{"시군구":"진주시","비율":0}
        ,"47940":{"시군구":"울릉군","비율":0}
        ,"47930":{"시군구":"울진군","비율":0}
        ,"47920":{"시군구":"봉화군","비율":0}
        ,"47900":{"시군구":"예천군","비율":0}
        ,"47850":{"시군구":"칠곡군","비율":0}
        ,"47840":{"시군구":"성주군","비율":0}
        ,"47830":{"시군구":"고령군","비율":0}
        ,"47820":{"시군구":"청도군","비율":0}
        ,"47770":{"시군구":"영덕군","비율":0}
        ,"47760":{"시군구":"영양군","비율":0}
        ,"47750":{"시군구":"청송군","비율":0}
        ,"47730":{"시군구":"의성군","비율":0}
        ,"47720":{"시군구":"군위군","비율":0}
        ,"47290":{"시군구":"경산시","비율":0}
        ,"47280":{"시군구":"문경시","비율":0}
        ,"47250":{"시군구":"상주시","비율":0}
        ,"47230":{"시군구":"영천시","비율":0}
        ,"47210":{"시군구":"영주시","비율":0}
        ,"47190":{"시군구":"구미시","비율":0}
        ,"47170":{"시군구":"안동시","비율":0}
        ,"47150":{"시군구":"김천시","비율":0}
        ,"47130":{"시군구":"경주시","비율":0}
        ,"47113":{"시군구":"포항시북구","비율":0}
        ,"47111":{"시군구":"포항시남구","비율":0}
        ,"46910":{"시군구":"신안군","비율":0}
        ,"46900":{"시군구":"진도군","비율":0}
        ,"46890":{"시군구":"완도군","비율":0}
        ,"46880":{"시군구":"장성군","비율":0}
        ,"46870":{"시군구":"영광군","비율":0}
        ,"46860":{"시군구":"함평군","비율":0}
        ,"46840":{"시군구":"무안군","비율":0}
        ,"46830":{"시군구":"영암군","비율":0}
        ,"46820":{"시군구":"해남군","비율":0}
        ,"46810":{"시군구":"강진군","비율":0}
        ,"46800":{"시군구":"장흥군","비율":0}
        ,"46790":{"시군구":"화순군","비율":0}
        ,"46780":{"시군구":"보성군","비율":0}
        ,"46770":{"시군구":"고흥군","비율":0}
        ,"46730":{"시군구":"구례군","비율":0}
        ,"46720":{"시군구":"곡성군","비율":0}
        ,"46710":{"시군구":"담양군","비율":0}
        ,"46230":{"시군구":"광양시","비율":0}
        ,"46170":{"시군구":"나주시","비율":0}
        ,"46150":{"시군구":"순천시","비율":0}
        ,"46130":{"시군구":"여수시","비율":0}
        ,"46110":{"시군구":"목포시","비율":0}
        ,"45800":{"시군구":"부안군","비율":0}
        ,"45790":{"시군구":"고창군","비율":0}
        ,"45770":{"시군구":"순창군","비율":0}
        ,"45750":{"시군구":"임실군","비율":0}
        ,"45740":{"시군구":"장수군","비율":0}
        ,"45730":{"시군구":"무주군","비율":0}
        ,"45720":{"시군구":"진안군","비율":0}
        ,"45710":{"시군구":"완주군","비율":0}
        ,"45210":{"시군구":"김제시","비율":0}
        ,"45190":{"시군구":"남원시","비율":0}
        ,"45180":{"시군구":"정읍시","비율":0}
        ,"45140":{"시군구":"익산시","비율":0}
        ,"45130":{"시군구":"군산시","비율":0}
        ,"45113":{"시군구":"전주시덕진구","비율":0}
        ,"45111":{"시군구":"전주시완산구","비율":0}
        ,"44825":{"시군구":"태안군","비율":0}
        ,"44810":{"시군구":"예산군","비율":0}
        ,"44800":{"시군구":"홍성군","비율":0}
        ,"44790":{"시군구":"청양군","비율":0}
        ,"44770":{"시군구":"서천군","비율":0}
        ,"44760":{"시군구":"부여군","비율":0}
        ,"44710":{"시군구":"금산군","비율":0}
        ,"44270":{"시군구":"당진시","비율":0}
        ,"44250":{"시군구":"계룡시","비율":0}
        ,"44230":{"시군구":"논산시","비율":0}
        ,"44210":{"시군구":"서산시","비율":0}
        ,"44200":{"시군구":"아산시","비율":0}
        ,"44180":{"시군구":"보령시","비율":0}
        ,"44150":{"시군구":"공주시","비율":0}
        ,"44133":{"시군구":"천안시서북구","비율":0}
        ,"44131":{"시군구":"천안시동남구","비율":0}
        ,"43745":{"시군구":"증평군","비율":0}
        ,"43800":{"시군구":"단양군","비율":0}
        ,"43770":{"시군구":"음성군","비율":0}
        ,"43760":{"시군구":"괴산군","비율":0}
        ,"43750":{"시군구":"진천군","비율":0}
        ,"43740":{"시군구":"영동군","비율":0}
        ,"43730":{"시군구":"옥천군","비율":0}
        ,"43720":{"시군구":"보은군","비율":0}
        ,"43150":{"시군구":"제천시","비율":0}
        ,"43130":{"시군구":"충주시","비율":0}
        ,"43113":{"시군구":"청주시흥덕구","비율":0}
        ,"43111":{"시군구":"청주시상당구","비율":0}
        ,"42830":{"시군구":"양양군","비율":0}
        ,"48820":{"시군구":"고성군","비율":0}
        ,"42810":{"시군구":"인제군","비율":0}
        ,"42800":{"시군구":"양구군","비율":0}
        ,"42790":{"시군구":"화천군","비율":0}
        ,"42780":{"시군구":"철원군","비율":0}
        ,"42770":{"시군구":"정선군","비율":0}
        ,"42760":{"시군구":"평창군","비율":0}
        ,"42750":{"시군구":"영월군","비율":0}
        ,"42730":{"시군구":"횡성군","비율":0}
        ,"42720":{"시군구":"홍천군","비율":0}
        ,"42230":{"시군구":"삼척시","비율":0}
        ,"42210":{"시군구":"속초시","비율":0}
        ,"42190":{"시군구":"태백시","비율":0}
        ,"42170":{"시군구":"동해시","비율":0}
        ,"42150":{"시군구":"강릉시","비율":0}
        ,"42130":{"시군구":"원주시","비율":0}
        ,"42110":{"시군구":"춘천시","비율":0}
        ,"41830":{"시군구":"양평군","비율":0}
        ,"41820":{"시군구":"가평군","비율":0}
        ,"41800":{"시군구":"연천군","비율":0}
        ,"41670":{"시군구":"여주시","비율":0}
        ,"41650":{"시군구":"포천시","비율":0}
        ,"41630":{"시군구":"양주시","비율":0}
        ,"41610":{"시군구":"광주시","비율":0}
        ,"41590":{"시군구":"화성시","비율":0}
        ,"41570":{"시군구":"김포시","비율":0}
        ,"41550":{"시군구":"안성시","비율":0}
        ,"41500":{"시군구":"이천시","비율":0}
        ,"41480":{"시군구":"파주시","비율":0}
        ,"41465":{"시군구":"용인시수지구","비율":0}
        ,"41463":{"시군구":"용인시기흥구","비율":0}
        ,"41461":{"시군구":"용인시처인구","비율":0}
        ,"41450":{"시군구":"하남시","비율":0}
        ,"41430":{"시군구":"의왕시","비율":0}
        ,"41410":{"시군구":"군포시","비율":0}
        ,"41390":{"시군구":"시흥시","비율":0}
        ,"41370":{"시군구":"오산시","비율":0}
        ,"41360":{"시군구":"남양주시","비율":0}
        ,"41310":{"시군구":"구리시","비율":0}
        ,"41290":{"시군구":"과천시","비율":0}
        ,"41287":{"시군구":"고양시일산서구","비율":0}
        ,"41285":{"시군구":"고양시일산동구","비율":0}
        ,"41281":{"시군구":"고양시덕양구","비율":0}
        ,"41273":{"시군구":"안산시단원구","비율":0}
        ,"41271":{"시군구":"안산시상록구","비율":0}
        ,"41250":{"시군구":"동두천시","비율":0}
        ,"41220":{"시군구":"평택시","비율":0}
        ,"41210":{"시군구":"광명시","비율":0}
        ,"41199":{"시군구":"부천시오정구","비율":0}
        ,"41197":{"시군구":"부천시소사구","비율":0}
        ,"41195":{"시군구":"부천시원미구","비율":0}
        ,"41173":{"시군구":"안양시동안구","비율":0}
        ,"41171":{"시군구":"안양시만안구","비율":0}
        ,"41150":{"시군구":"의정부시","비율":0}
        ,"41135":{"시군구":"성남시분당구","비율":0}
        ,"41133":{"시군구":"성남시중원구","비율":0}
        ,"41131":{"시군구":"성남시수정구","비율":0}
        ,"41117":{"시군구":"수원시영통구","비율":0}
        ,"41115":{"시군구":"수원시팔달구","비율":0}
        ,"41113":{"시군구":"수원시권선구","비율":0}
        ,"41111":{"시군구":"수원시장안구","비율":0}
        ,"36110":{"시군구":"세종시","비율":0}
        ,"31710":{"시군구":"울주군","비율":0}
        ,"31200":{"시군구":"북구","비율":0}
        ,"31170":{"시군구":"동구","비율":0}
        ,"31140":{"시군구":"남구","비율":0}
        ,"31110":{"시군구":"중구","비율":0}
        ,"30230":{"시군구":"대덕구","비율":0}
        ,"30200":{"시군구":"유성구","비율":0}
        ,"30170":{"시군구":"서구","비율":0}
        ,"30140":{"시군구":"중구","비율":0}
        ,"30110":{"시군구":"동구","비율":0}
        ,"29200":{"시군구":"광산구","비율":0}
        ,"29170":{"시군구":"북구","비율":0}
        ,"29155":{"시군구":"남구","비율":0}
        ,"29140":{"시군구":"서구","비율":0}
        ,"29110":{"시군구":"동구","비율":0}
        ,"28720":{"시군구":"옹진군","비율":0}
        ,"28710":{"시군구":"강화군","비율":0}
        ,"28260":{"시군구":"서구","비율":0}
        ,"28245":{"시군구":"계양구","비율":0}
        ,"28237":{"시군구":"부평구","비율":0}
        ,"28200":{"시군구":"남동구","비율":0}
        ,"28185":{"시군구":"연수구","비율":0}
        ,"28170":{"시군구":"남구","비율":0}
        ,"28140":{"시군구":"동구","비율":0}
        ,"28110":{"시군구":"중구","비율":0}
        ,"27710":{"시군구":"달성군","비율":0}
        ,"27290":{"시군구":"달서구","비율":0}
        ,"27260":{"시군구":"수성구","비율":0}
        ,"27230":{"시군구":"북구","비율":0}
        ,"27200":{"시군구":"남구","비율":0}
        ,"27170":{"시군구":"서구","비율":0}
        ,"27140":{"시군구":"동구","비율":0}
        ,"27110":{"시군구":"중구","비율":0}
        ,"26710":{"시군구":"기장군","비율":0}
        ,"26530":{"시군구":"사상구","비율":0}
        ,"26500":{"시군구":"수영구","비율":0}
        ,"26470":{"시군구":"연제구","비율":0}
        ,"26440":{"시군구":"강서구","비율":0}
        ,"26410":{"시군구":"금정구","비율":0}
        ,"26380":{"시군구":"사하구","비율":0}
        ,"26350":{"시군구":"해운대구","비율":0}
        ,"26320":{"시군구":"북구","비율":0}
        ,"26290":{"시군구":"남구","비율":0}
        ,"26260":{"시군구":"동래구","비율":0}
        ,"26230":{"시군구":"부산진구","비율":0}
        ,"26200":{"시군구":"영도구","비율":0}
        ,"26170":{"시군구":"동구","비율":0}
        ,"26140":{"시군구":"서구","비율":0}
        ,"26110":{"시군구":"중구","비율":0}
        ,"11740":{"시군구":"강동구","비율":0}
        ,"11710":{"시군구":"송파구","비율":0}
        ,"11680":{"시군구":"강남구","비율":0}
        ,"11650":{"시군구":"서초구","비율":0}
        ,"11620":{"시군구":"관악구","비율":0}
        ,"11590":{"시군구":"동작구","비율":0}
        ,"11560":{"시군구":"영등포구","비율":0}
        ,"11545":{"시군구":"금천구","비율":0}
        ,"11530":{"시군구":"구로구","비율":0}
        ,"11500":{"시군구":"강서구","비율":0}
        ,"11470":{"시군구":"양천구","비율":0}
        ,"11440":{"시군구":"마포구","비율":0}
        ,"11410":{"시군구":"서대문구","비율":0}
        ,"11380":{"시군구":"은평구","비율":0}
        ,"11350":{"시군구":"노원구","비율":0}
        ,"11320":{"시군구":"도봉구","비율":0}
        ,"11305":{"시군구":"강북구","비율":0}
        ,"11290":{"시군구":"성북구","비율":0}
        ,"11260":{"시군구":"중랑구","비율":0}
        ,"11230":{"시군구":"동대문구","비율":0}
        ,"11215":{"시군구":"광진구","비율":0}
        ,"11200":{"시군구":"성동구","비율":0}
        ,"11170":{"시군구":"용산구","비율":0}
        ,"11140":{"시군구":"중구","비율":0}
        ,"11110":{"시군구":"종로구","비율":0}
};