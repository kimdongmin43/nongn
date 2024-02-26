package kr.apfs.local.user.model;

import java.io.Serializable;

public class UserAuthVO implements Serializable {
	/**
	 *
	 */
	private static final long serialVersionUID = 1L;
	private String userId = null;
	private String userCd = "";
	private String userCdNm = null;
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getUserCd() {
		return userCd;
	}
	public void setUserCd(String userCd) {
		this.userCd = userCd;
	}
	public String getUserCdNm() {
		return userCdNm;
	}
	public void setUserCdNm(String userCdNm) {
		this.userCdNm = userCdNm;
	}

}
