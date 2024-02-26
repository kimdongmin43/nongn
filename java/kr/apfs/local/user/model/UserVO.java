package kr.apfs.local.user.model;

import java.util.List;

import kr.apfs.local.login.model.Role;

import org.springframework.security.core.userdetails.UserDetails;

/**
 * @author jangcw
 * 사용자관리 VO
 */
public class UserVO implements UserDetails {

	private String userId;
	private String userCd;
	private String userCdNm;
	private String userNm;
	private String loginId;
	private String password;
	private String passwordDt;
	private String email;
	private String tel;
	private String mobile;
	private String deptNm;
	private String note;
	private String regUserId;
	private String regDt;
	private String updUserId;
	private String updDt;
	private String useYn;
	private String useYnNm;
	private String delYn;
	private String delYnNm;
	private String sort;
	private String siteId;
	private String siteNm;
	private String locId;
	private String agreeDt;
	private String todayLogCnt;
	private List<Role> authorities;

	private String mobile_1;
	private String mobile_2;
	private String mobile_3;

	private String tel_1;
	private String tel_2;
	private String tel_3;

	private String email_1;
	private String email_2;

	public String getAgreeDt() {
		return agreeDt;
	}
	public void setAgreeDt(String agreeDt) {
		this.agreeDt = agreeDt;
	}
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
	public String getUserNm() {
		return userNm;
	}
	public void setUserNm(String userNm) {
		this.userNm = userNm;
	}
	public String getLoginId() {
		return loginId;
	}
	public void setLoginId(String loginId) {
		this.loginId = loginId;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getPasswordDt() {
		return passwordDt;
	}
	public void setPasswordDt(String passwordDt) {
		this.passwordDt = passwordDt;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getTel() {
		return tel;
	}
	public void setTel(String tel) {
		this.tel = tel;
	}
	public String getMobile() {
		return mobile;
	}
	public void setMobile(String mobile) {
		this.mobile = mobile;
	}
	public String getDeptNm() {
		return deptNm;
	}
	public void setDeptNm(String deptNm) {
		this.deptNm = deptNm;
	}
	public String getNote() {
		return note;
	}
	public void setNote(String note) {
		this.note = note;
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
	public String getUseYnNm() {
		return useYnNm;
	}
	public void setUseYnNm(String useYnNm) {
		this.useYnNm = useYnNm;
	}
	public String getDelYn() {
		return delYn;
	}
	public void setDelYn(String delYn) {
		this.delYn = delYn;
	}
	public String getDelYnNm() {
		return delYnNm;
	}
	public void setDelYnNm(String delYnNm) {
		this.delYnNm = delYnNm;
	}
	public String getSort() {
		return sort;
	}
	public void setSort(String sort) {
		this.sort = sort;
	}
	public String getSiteId() {
		return siteId;
	}
	public void setSiteId(String siteId) {
		this.siteId = siteId;
	}
	public String getSiteNm() {
		return siteNm;
	}
	public void setSiteNm(String siteNm) {
		this.siteNm = siteNm;
	}
	public String getLocId() {
		return locId;
	}
	public void setLocId(String locId) {
		this.locId = locId;
	}
	public String getTodayLogCnt() {
		return todayLogCnt;
	}
	public void setTodayLogCnt(String todayLogCnt) {
		this.todayLogCnt = todayLogCnt;
	}

	@Override
	public String getUsername() {

		return userNm;
	}
	@Override
	public boolean isAccountNonExpired() {

		return false;
	}
	@Override
	public boolean isAccountNonLocked() {

		return true;
	}
	@Override
	public boolean isCredentialsNonExpired() {

		return false;
	}
	@Override
	public boolean isEnabled() {

		return false;
	}
	@Override
	public final List<Role> getAuthorities() {
		return authorities;
	}
	public final void setAuthorities(final List<Role> list) {
		this.authorities = list;
	}
	public String getMobile_1() {
		return mobile_1;
	}
	public void setMobile_1(String mobile_1) {
		this.mobile_1 = mobile_1;
	}
	public String getMobile_2() {
		return mobile_2;
	}
	public void setMobile_2(String mobile_2) {
		this.mobile_2 = mobile_2;
	}
	public String getMobile_3() {
		return mobile_3;
	}
	public void setMobile_3(String mobile_3) {
		this.mobile_3 = mobile_3;
	}
	public String getTel_1() {
		return tel_1;
	}
	public void setTel_1(String tel_1) {
		this.tel_1 = tel_1;
	}
	public String getTel_2() {
		return tel_2;
	}
	public void setTel_2(String tel_2) {
		this.tel_2 = tel_2;
	}
	public String getTel_3() {
		return tel_3;
	}
	public void setTel_3(String tel_3) {
		this.tel_3 = tel_3;
	}
	public String getEmail_1() {
		return email_1;
	}
	public void setEmail_1(String email_1) {
		this.email_1 = email_1;
	}
	public String getEmail_2() {
		return email_2;
	}
	public void setEmail_2(String email_2) {
		this.email_2 = email_2;
	}

}