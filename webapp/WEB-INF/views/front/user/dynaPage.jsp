<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="/WEB-INF/tlds/taglib.tld" prefix="g" %>
						<!-- search_area -->	
					<div class="search_area">
		            	<dl class="search_box">
		                	<dt class="title">
		                		<label for="select_category">카테고리</label>
		                	</dt>
		                    <dd class="box">		                    		
								<select class="in_wp100" id="select_category">
									<option value="">전체</option>
								</select>
		                    </dd>
		                </dl>
		                <dl class="search_box">
		                	<dt class="title">검색어</dt>
		                    <dd class="box">		  
		                    	<label for="select_search_word" class="hidden">검색어 분류 선택</label>                  		
								<select class="in_wp100" id="select_search_word">
									<option value="">전체</option>
								</select>
								<label for="input_search_word" class="hidden">검색어 입력창</label>									
								<input type="text" class="in_w50" id="input_search_word" />
								<div class="search_btn_area">
									<button class="btn sch" title="조회">
				                        <span>조회</span>
				                    </button>
				                    <!-- <button class="btn clear" title="초기화">
				                        <span>초기화</span>
				                    </button> -->
			                    </div>
		                    </dd>
		                </dl>
		            </div>
					<!--// search_area -->
					
					<!-- table_count_area -->	
					<div class="table_count_area">
		                <div class="count_area float_left">
		                    <strong>100</strong>건
		                </div>
                        <div class="float_right">
                        	<label for="select_num" class="hidden">출력 구분 선택</label>
                            <select id="select_num" class="in_wp80">
                                <option value="">제목</option>
                            </select>
                        </div>
		            </div>
		            <!--// table_count_area -->
		            
		          	<!--// list_table_area -->  
		            <div class="list_table_area">
		                <table class="list fixed">
		                    <caption>상담 리스트 화면</caption>
		                    <colgroup>
		                        <col style="width: ;">
		                        <col style="width: ;">
		                        <col style="width: 250px;">
		                        <col style="width: ;">
		                        <col style="width: ;">
		                        <col style="width: ;">
		                        <col style="width: ;">
		                        <col style="width: ;">
		                        <col style="width: ;">
		                        <col style="width: ;">
		                        <col style="width: ;">
		                        <col style="width: ;">
		                        <col style="width: ;">
		                        <col style="width: ;">
		                        <col style="width: ;">
		                    </colgroup>
		                    <thead>
		                    <tr>
		                        <th scope="col" class="first">번호</th>
		                        <th scope="col">카테고리</th>
		                        <th scope="col">제목</th>
		                        <th scope="col">첨부파일</th>
		                        <th scope="col">작성자</th>
		                        <th scope="col">이메일</th>
		                        <th scope="col">작성일</th>
		                        <th scope="col">IP</th>
		                        <th scope="col">URL</th>
		                        <th scope="col">출처</th>
		                        <th scope="col">내용</th>
		                        <th scope="col">썸네일</th>
		                        <th scope="col">추천</th>
		                        <th scope="col">만족도</th>
		                        <th scope="col" class="last">조회수</th>
		                    </tr>
		                    </thead>
		                    <tbody>
		                    <tr>
		                        <td class="first">
		                        	<img src="/images/front/icon/table_txt_icon01.png" alt="공지" />
		                        </td>
		                        <td>카테고리</td>
		                        <td class="alignl">
		                        	<a href="#none" title="제목입니다. 상세페이지로 이동">
		                                제목입니다.
		                            </a>
		                            <span class="re_count">[<strong>10</strong>]</span>
		                            <img src="/images/front/icon/icon_lock.png" alt="비밀글" />
		                        </td>
		                        <td>
		                        	<a href="#none" title="해당파일 다운로드">
		                        		<img src="/images/front/icon/icon_file.png" alt="첨부파일" />
		                        	</a>
		                        </td>
		                        <td>관리자</td>
		                        <td>
		                        	<a href="mailto:abc@naver.com">abc@naver.com</a>
		                        </td>
		                        <td>2017-01-01</td>
		                        <td>11.12.123.11</td>
		                        <td class="alignl">
		                        	<a href="http://www.naver.com" target="_blank">www.naver.com</a>
		                        </td>
		                        <td>서울시청</td>
		                        <td class="alignl">내용이 출력됩니다.내용이 출력됩니다.</td>
		                        <td>
		                        	<img src="/images/front/common/no_img.png" alt="썸네일" />
		                        </td>
		                        <td>00</td>
		                        <td>4.0</td>
		                        <td class="last">123</td>
							</tr>
							<tr>
		                        <td class="first">9</td>
		                        <td>카테고리</td>
		                        <td class="alignl">
		                        	<a href="#none" title="제목입니다. 상세페이지로 이동">
		                                제목입니다.
		                            </a>
		                            <span class="re_count">[<strong>10</strong>]</span>
		                            <img src="/images/front/icon/table_txt_icon02.png" alt="답변완료" />
		                        </td>
		                        <td></td>
		                        <td>관리자</td>
		                        <td></td>
		                        <td>2017-01-01</td>
		                        <td></td>
		                        <td class="alignl"></td>
		                        <td></td>
		                        <td class="alignl"></td>
		                        <td></td>
		                        <td></td>
		                        <td></td>
		                        <td class="last"></td>
							</tr>
							<tr>
		                        <td class="first">9</td>
		                        <td>카테고리</td>
		                        <td class="alignl">
		                        	<a href="#none" title="제목입니다. 상세페이지로 이동">
		                                제목입니다.
		                            </a>
		                        </td>
		                        <td></td>
		                        <td>관리자</td>
		                        <td></td>
		                        <td>2017-01-01</td>
		                        <td></td>
		                        <td class="alignl"></td>
		                        <td></td>
		                        <td class="alignl"></td>
		                        <td></td>
		                        <td></td>
		                        <td></td>
		                        <td class="last"></td>
							</tr>
							<tr>
		                        <td colspan="15" class="first last">조회된 내용이 없습니다.</td>
		                    </tr>
		                    </tbody>
		                </table>
		            </div>
		            <!--// list_table_area -->  
		            <!-- button_area -->
		            <div class="button_area">
		            	<div class="float_right">
		            		<button class="btn save" title="등록">
		            			<span>등록</span>
		            		</button>
		            	</div>
		            </div>
		            <!--// button_area -->
		            <!-- paging_area -->
		            <div class="paging_area">
						<a href="#none" class="stimg" title="맨처음 페이지로 이동"><img src="/images/front/common/btn_paging_first.png" alt="맨처음 페이지로 이동" /></a>
						<a href="#none" class="stimg" title="전 페이지로 이동"><img src="/images/front/common/btn_paging_prev.png" alt="전 페이지로 이동" /></a>
						<strong>1</strong>
						<a href="#none">2</a>
						<a href="#none">3</a>
						<a href="#none">4</a>
						<a href="#none">5</a>
						<a href="#none">6</a>
						<a href="#none">7</a>
						<a href="#none">8</a>
						<a href="#none">9</a>
						<a href="#none">10</a>
						<a href="#none" class="stimg" title="다음 페이지로 이동"><img src="/images/front/common/btn_paging_next.png" alt="다음 페이지로 이동" /></a>
						<a href="#none" class="stimg" title="맨마지막 페이지로 이동"><img src="/images/front/common/btn_paging_last.png" alt="맨마지막 페이지로 이동" /></a>
					</div>
		            <!--// paging_area -->
		            
		             <!-- mobile_list -->
		            <div class="mobile_list marginb30">
	                    <ul class="mobile_list">
	                        <li class="announce">
	                            <div class="mobile_list_info">
	                            	<dl class="view">
	                                	<dt class="vdt">
	                                        <span>카테고리</span>
	                                    </dt>
	                                    <dd class="vdd">abc</dd>
	                                </dl>
	                            	<strong class="title">제목이 출력됩니다. 제목이 출력됩니다. 제목이 출력됩니다.[<strong class="color_pointr">00</strong>]<img src="/images/front/icon/icon_lock.png" alt="비밀글" class="marginl5" /></strong>
	                            	<dl class="view">
	                                	<dt class="vdt">
	                                        <span>작성자</span>
	                                    </dt>
	                                    <dd class="vdd">홍길동</dd>
	                                    <dt class="vdt">
	                                        <span>작성일</span>
	                                    </dt>
	                                    <dd class="vdd">YYYY-MM-DD</dd>
									</dl>
									<dl class="view">
										<dt class="vdt">
											<span>첨부파일</span>
										</dt>
										<dd class="vdd">
 											<img src="/images/front/icon/icon_file.png" alt="첨부파일">
										</dd>
									</dl>
	                            </div>
	                        </li>
	                        <li>
	                            <div class="mobile_list_info">
	                            	<dl class="view">
	                                	<dt class="vdt">
	                                        <span>카테고리</span>
	                                    </dt>
	                                    <dd class="vdd">abc</dd>
	                                </dl>
	                            	<strong class="title">제목이 출력됩니다. 제목이 출력됩니다. 제목이 출력됩니다.[<strong class="color_pointr">00</strong>]
	                            		<img src="/images/front/icon/table_txt_icon02.png" alt="답변완료" class="marginl5" />
	                            	</strong>
	                            	
	                            	<dl class="view">
	                                	<dt class="vdt">
	                                        <span>작성자</span>
	                                    </dt>
	                                    <dd class="vdd">홍길동</dd>
	                                    <dt class="vdt">
	                                        <span>작성일</span>
	                                    </dt>
	                                    <dd class="vdd">YYYY-MM-DD</dd>
									</dl>
									<dl class="view">
										<dt class="vdt">
											<span>첨부파일</span>
										</dt>
										<dd class="vdd">
 											<img src="/images/front/icon/icon_file.png" alt="첨부파일">
										</dd>
									</dl>
	                            </div>
	                        </li>
	                    </ul>
	                </div>
		            <!--// mobile_list -->