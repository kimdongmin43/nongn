package kr.apfs.local.site.vo;

import java.io.Serializable;

public class SiteVO implements Serializable {

	/**
	 *
	 */
	private static final long serialVersionUID = 1L;
	private String siteId;
	private String clientId;
	private String chamCd;
	private String siteNm;
	private String siteDesc;
	private String regUserId;
	private String regDt;
	private String updUserId;
	private String updDt;
	private String useYn;
	private String delYn;
	private String sort;
	private String menuLocation;
	private String menuJoin;
	private String addr;
	private String eamil;
	private String tel;
	private String tel_mobile;

	public String getSiteId() {
		return siteId;
	}

	public void setSiteId(String siteId) {
		this.siteId = siteId;
	}

	public String getMenuLocation() {
		return menuLocation;
	}

	public void setMenuLocation(String menuLocation) {
		this.menuLocation = menuLocation;
	}

	public String getMenuJoin() {
		return menuJoin;
	}

	public void setMenuJoin(String menuJoin) {
		this.menuJoin = menuJoin;
	}

	public String getClientId() {
		return clientId;
	}

	public void setClientId(String clientId) {
		this.clientId = clientId;
	}

	public String getChamCd() {
		return chamCd;
	}

	public void setChamCd(String chamCd) {
		this.chamCd = chamCd;
	}

	public String getSiteNm() {
		return siteNm;
	}

	public void setSiteNm(String siteNm) {
		this.siteNm = siteNm;
	}

	public String getSiteDesc() {
		return siteDesc;
	}

	public void setSiteDesc(String siteDesc) {
		this.siteDesc = siteDesc;
	}

	public String getRegUserId() {
		return regUserId;
	}

	public void setRegUserId(String regUserId) {
		this.regUserId = regUserId;
	}

	public String getRegDt() {
		return regDt;
	}

	public void setRegDt(String regDt) {
		this.regDt = regDt;
	}

	public String getUpdUserId() {
		return updUserId;
	}

	public void setUpdUserId(String updUserId) {
		this.updUserId = updUserId;
	}

	public String getUpdDt() {
		return updDt;
	}

	public void setUpdDt(String updDt) {
		this.updDt = updDt;
	}

	public String getUseYn() {
		return useYn;
	}

	public void setUseYn(String useYn) {
		this.useYn = useYn;
	}

	public String getDelYn() {
		return delYn;
	}

	public void setDelYn(String delYn) {
		this.delYn = delYn;
	}

	public String getSort() {
		return sort;
	}

	public void setSort(String sort) {
		this.sort = sort;
	}

	public String getAddr() {
		return addr;
	}

	public void setAddr(String addr) {
		this.addr = addr;
	}

	public String getEamil() {
		return eamil;
	}

	public void setEamil(String eamil) {
		this.eamil = eamil;
	}

	public String getTel() {
		return tel;
	}

	public void setTel(String tel) {
		this.tel = tel;
	}

	public String getTel_mobile() {
		return tel_mobile;
	}

	public void setTel_mobile(String tel_mobile) {
		this.tel_mobile = tel_mobile;
	}

	@Override
	public String toString() {
		return "SiteVO [tel=" + tel + ", tel_mobile=" + tel_mobile + "]";
	}
	
	
}