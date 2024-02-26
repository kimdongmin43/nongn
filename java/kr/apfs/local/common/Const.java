package kr.apfs.local.common;
/**
 *
 * @author h2y
 *
 */
public final class Const {
	/**
	 *
	 */
	private Const() {
	}
	/**
	 * 세션키 - 유저정보.
	 * user - 관리자
	 * member - 농금원 회원 (로그인 세션)
	 */
	public static final String SESSION_MAIN		= "MAIN";
	public static final String SESSION_BANNER	= "BANNER";
	public static final String SESSION_MENU	= "MENU";
	public static final String SESSION_USER 		= "USER";
	public static final String SESSION_USER_AUTH 	= "USER_AUTH";
	public static final String SESSION_SITE 		= "SITE";
	public static final String SESSION_MEMBER 		= "MEMBER";
	public static final String SESSION_MEMBER_AUTH 	= "MEMEBER_AUTH";
	public static final String SESSION_MOBILE_YN 	= "*mobileYn";
	public static final String SESSION_STIE_CD		= "*siteCd";
	public static final String SESSION_MENU_ID		= "*menuId";
	//-------------------------------------------------------------------------
	/**
	 * 처음.
	 */
	public static final String MODE_INIT = "INIT";
	/**
	 * 조회.
	 */
	public static final String MODE_SEARCH = "SEARCH";
	/**
	 * 선택.
	 */
	public static final String MODE_SELECT = "SELECT";
	/**
	 * 설계.
	 */
	public static final String MODE_DESIGN = "DESIGN";
	/**
	 * 신규.
	 */
	public static final String MODE_NEW = "NEW";
	/**
	 * 등록.
	 */
	public static final String MODE_INSERT = "INSERT";
	/**
	 * 수정.
	 */
	public static final String MODE_UPDATE = "UPDATE";
	/**
	 * 삭제.
	 */
	public static final String MODE_DELETE = "DELETE";
	/**
	 * 저장.
	 */
	public static final String MODE_SAVE = "SAVE";
	/**
	 * 생성.
	 */
	public static final String MODE_GENERATE = "GENERATE";
	/**
	 * 자가승인.
	 */
	public static final String MODE_AUTOAPPROVAL = "AUTOAPPROVAL";
	/**
	 * 복사.
	 */
	public static final String MODE_COPY = "COPY";
	/**
	 * 템플릿으로저장.
	 */
	public static final String MODE_TEMPLATECOPY = "TEMPLATECOPY";
	/**
	 *
	 */
	public static final String MODE_CHECK = "CHECK";

	public static final String MODE_REQUEST = "REQUEST";
	/**
	 * 새로고침.
	 */
	public static final String MODE_REFRESH = "REFRESH";
	//-------------------------------------------------------------------------
	/**
	 * 계획 .
	 */
	public static final String MODE_SUB_PLAN = "PLAN";
	/**
	 * 계획(간트차트) .
	 */
	public static final String MODE_SUB_PLANGANTT = "PLANGANTT";
	/**
	 * 캠페인.
	 */
	public static final String MODE_SUB_CAMP = "CAMP";
	/**
	 * 캠페인분류.
	 */
	public static final String MODE_SUB_CAMPCATE = "CAMPCATE";
	/**
	 * 캠페인복사.
	 */
	public static final String MODE_SUB_CAMPCOPY = "CAMPCOPY";
	/**
	 * 템플릿복사.
	 */
	public static final String MODE_SUB_TEMPLATECOPY = "TEMPLATECOPY";
	/**
	 * 캠페인요약.
	 */
	public static final String MODE_SUB_CAMPSUMMARY = "CAMPSUMMARY";
	/**
	 * 캠페인STEP.
	 */
	public static final String MODE_SUB_CAMPSTEP = "CAMPSTEP";
	/**
	 * 캠페인설계.
	 */
	public static final String MODE_SUB_CAMPDESIGN = "CAMPDESIGN";
	/**
	 * 메인정보.
	 */
	public static final String MODE_SUB_MAININFO = "MAININFO";
	/**
	 * 메뉴리스트.
	 */
	public static final String MODE_SUB_MENULIST = "MENULIST";
	/**
	 * 프로그램정보.
	 */
	public static final String MODE_SUB_PROGRAM = "PROGRAM";
	/**
	 * 비즈니스쿼리.
	 */
	public static final String MODE_SUB_BUSINESS = "BUSINESS";
	/**
	 * 비즈니스쿼리프롬프트데이터참조.
	 */
	public static final String MODE_SUB_PROMPT_REF = "PROMPT_REF";
	/**
	 * 메타.
	 */
	public static final String MODE_SUB_META = "META";
	/**
	 * 테이블.
	 */
	public static final String MODE_SUB_TABLE = "TABLE";
	public static final String MODE_SUB_TABLELIST = "TABLELIST";
	public static final String MODE_SUB_DBMSTABLE = "DBMSTABLE";
	public static final String MODE_SUB_TABLETYPE = "TABLETYPE";
	/**
	 * 컬럼.
	 */
	public static final String MODE_SUB_COLUMN = "COLUMN";
	/**
	 * 필드.
	 */
	public static final String MODE_SUB_FIELD = "FIELD";
	/**
	 * 프롬프트.
	 */
	public static final String MODE_SUB_PROMPT = "PROMPT";
	/**
	 * 레이아웃.
	 */
	public static final String MODE_SUB_LAYOUT = "LAYOUT";
	/**
	 * 스케쥴.
	 */
	public static final String MODE_SUB_SCHEDULE = "SCHEDULE";
	/**
	 * 카테고리.
	 */
	public static final String MODE_SUB_CATEGORY = "CATEGORY";
	/**
	 * 고객접촉제어.
	 */
	public static final String MODE_SUB_CUSTOMERCONTACT = "CUSTOMERCONTACT";
	/**
	 * 일별반응추이(그래프).
	 */
	public static final String MODE_SUB_DAYRESPGRAPH = "DAYRESPGRAPH";

	public static final String MODE_SUB_DBMSTREE = "DBMSTREE";

	public static final String MODE_SUB_METATABLE = "METATABLE";

	public static final String MODE_SUB_DBMSID = "DBMSID";

	public static final String MODE_SUB_SCHEMA = "SCHEMA";

	/**
	 * Cell3노드.
	 */
	public static final String MODE_SUB_NODECELL3 = "NODECELL3";
	/**
	 * 오퍼.
	 */
	public static final String MODE_SUB_OFFER = "OFFER";
	/**
	 * Channel2노드.
	 */
	public static final String MODE_SUB_NODECHANNEL2 = "NODECHANNEL2";
	/**
	 * 컨텐츠.
	 */
	public static final String MODE_SUB_CONTENTS = "CONTENTS";
	/**
	 * 채널.
	 */
	public static final String MODE_SUB_CHANNEL = "CHANNEL";
	/**
	 * 비교값도우미.
	 */
	public static final String MODE_SUB_PROMPTHELPER = "PROMPTHELPER";

	public static final String MODE_SUB_MONITORING = "MONITORING";
	public static final String MODE_SUB_ANALYSIS = "ANALYSIS";

	public static final String MODE_SUB_EMPLIST = "EMPLIST";
	public static final String MODE_SUB_DEPT = "DEPT";

	public static final String MODE_SUB_NOTICE = "NOTICE";
	//-------------------------------------------------------------------------
	/**
	 * 구분코드 메뉴.
	 */
	public static final String CODE_GUBUN_MENU = "MENU";
	/**
	 * 구분코드 프로그램.
	 */
	public static final String CODE_GUBUN_MENU_PROGRAM = "MENU_PROGRAM";
	/**
	 * 구분코드 연산자.
	 */
	public static final String CODE_GUBUN_COMP_OPER = "COMP_OPER";
	/**
	 * 구분코드캠페인유형.
	 */
	public static final String CODE_GUBUN_CAMP_TYPE = "CAMP_TYPE";
	/**
	 * 구분코드캠페인PROCESS_STEP.
	 */
	public static final String CODE_GUBUN_CAMP_PROCESS_STEPS =
			"CAMP_PROCESS_STEPS";
	/**
	 * 구분코드 디멘전리스트.
	 */
	public static final String CODE_GUBUN_DIMENSION_LIST =
			"DIMENSION_LIST";
	/**
	 * 캠페인 옵션.
	 */
	public static final String CODE_GUBUN_CAMP_ACTION = "CAMP_ACTION";
	/**
	 * 캠페인상세정보탭.
	 */
	public static final String CODE_GUBUN_CAMP_DETAIL_TAB = "CAMP_DETAIL_TAB";
	/**
	 * 채널타입.
	 */
	public static final String CODE_GUBUN_CHANNEL_TYPE = "CHANNEL_TYPE";
	//-------------------------------------------------------------------------
	/**
	 * 기획.
	 */
	public static final String CSTS_WRITE_K = "001";
	/**
	 * 승인요청.
	 */
	public static final String CSTS_APR_REQ_K = "002";
	/**
	 * 승인반려.
	 */
	public static final String CSTS_APR_REJ_K = "004";
	/**
	 * 요청취소.
	 */
	public static final String CSTS_CAN_K = "005";
	/**
	 * 실행대기.
	 */
	public static final String CSTS_RUN_WAIT_K = "006";
	/**
	 * 실행.
	 */
	public static final String CSTS_RUN_K = "007";
	/**
	 * 완료.
	 */
	public static final String CSTS_END_K = "008";
	/**
	 * 조기종료.
	 */
	public static final String CSTS_STOP_K = "009";
	/**
	 * 템플릿.
	 */
	public static final String CSTS_TEMP_K = "010";
	/**
	 *
	 */
	public static final String CSTS_WRITE_V = "기획";
	/**
	 *
	 */
	public static final String CSTS_APR_REQ_V = "승인요청";
	/**
	 *
	 */
	public static final String CSTS_APR_REJ_V = "승인반려";
	/**
	 *
	 */
	public static final String CSTS_CAN_V = "승인요청취소";
	/**
	 *
	 */
	public static final String CSTS_RUN_WAIT_V = "승인/실행대기";
	/**
	 *
	 */
	public static final String CSTS_RUN_V = "실행";
	/**
	 *
	 */
	public static final String CSTS_END_V = "완료";
	/**
	 *
	 */
	public static final String CSTS_STOP_V = "조기종료";
	/**
	 *
	 */
	public static final String CSTS_TEMP_V = "템플릿";
	//-------------------------------------------------------------------------
	/**
	 * 캠페인유형 일반.
	 */
	public static final String CAMP_TYPE_CO_K = "CO";
	/**
	 * 캠페인유형 워크플로우.
	 */
	public static final String CAMP_TYPE_CW_K = "CW";
	//-------------------------------------------------------------------------
	/**
	 * 카테고리-캠페인분류.
	 */
	public static final String CATEGORY_CCT = "CCT";
	//-------------------------------------------------------------------------
	/**
	 * 기획.
	 */
	public static final String CAMP_PROCESS_STEPS_PLANNING = "PLANNING";
	/**
	 * 설계.
	 */
	public static final String CAMP_PROCESS_STEPS_TARGETING = "TARGETING";
	/**
	 * 워크플로우.
	 */
	public static final String CAMP_PROCESS_STEPS_WORKFLOW = "WORKFLOW";
	/**
	 * 사전ROI.
	 */
	public static final String CAMP_PROCESS_STEPS_ROI = "ROI";
	/**
	 * 승인요청.
	 */
	public static final String CAMP_PROCESS_STEPS_APPROVAL_REQ = "APPROVAL_REQ";
	/**
	 * 승인.
	 */
	public static final String CAMP_PROCESS_STEPS_APPROVAL = "APPROVAL";
	/**
	 * 취소.
	 */
	public static final String CAMP_PROCESS_STEPS_CANCLE = "CANCLE";
	/**
	 * 반려.
	 */
	public static final String CAMP_PROCESS_STEPS_RETURN = "RETURN";

	public static final String CAMP_PROCESS_STEPS_MONITORING = "MONITORING";

	public static final String CAMP_PROCESS_STEPS_ANALYSIS = "ANALYSIS";
	/**
	 * 실행(이력생성).
	 */
	public static final String CAMP_PROCESS_STEPS_EXEC_CAMP_HIS =
			"EXEC_CAMP_HIS";
	/**
	 * 실행(채널전송).
	 */
	public static final String CAMP_PROCESS_STEPS_EXEC_CHNL_TRNS =
			"EXEC_CHNL_TRNS";
	/**
	 * 실행중.
	 */
	public static final String CAMP_PROCESS_STEPS_STATUS_RUNNING = "R";
	/**
	 * 실패.
	 */
	public static final String CAMP_PROCESS_STEPS_STATUS_FAIL = "F";
	/**
	 * 성공.
	 */
	public static final String CAMP_PROCESS_STEPS_STATUS_SUCCESS = "S";


	//-------------------------------------------------------------------------
	/**
	 * 승인요청.
	 */
	public static final String APPROVAL_REQUEST = "R";
	/**
	 * 1차승인.
	 */
	public static final String APPROVAL_COMPLETE1 = "1";
	/**
	 * 2차승인.
	 */
	public static final String APPROVAL_COMPLETE2 = "2";
	/**
	 * 최종승인.
	 */
	public static final String APPROVAL_COMPLETE = "D";
	/**
	 * 반려.
	 */
	public static final String APPROVAL_RETURN = "B";
	/**
	 * 요청취소.
	 */
	public static final String APPROVAL_CANCEL = "C";
	/**
	 * 자가승인.
	 */
	public static final String APPROVAL_AUTO = "A";
	//-------------------------------------------------------------------------
	/**
	 * DM.
	 */
	public static final String CHANNEL_TYPE_CD_DM = "003";
}
