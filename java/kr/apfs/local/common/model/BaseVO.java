package kr.apfs.local.common.model;

import java.io.Serializable;
import java.util.List;

import org.apache.commons.lang.builder.EqualsBuilder;
import org.apache.commons.lang.builder.HashCodeBuilder;
import org.apache.commons.lang.builder.ToStringBuilder;
import org.apache.commons.lang.builder.ToStringStyle;

/**
 * @Class Name : BaseVO.java
 * @Description : 클래스 설명을 기술합니다.
 * @author jangcw
 * @since 2015. 05. 10.
 * @version 1.0
 * @see
 *
 * @Modification Information
 *
 *               <pre>
 *    수정일         수정자              수정내용
 *  ===========    =========    ===========================
 *  2015. 05. 10.    jangcw      최초 생성
 * </pre>
 */

public class BaseVO implements Serializable {
	public String created_by;
	public String created_by_nm;
	public String created_dttm;
	public String modify_by;
	public String modify_by_nm;
	public String modify_dttm;
	public int total_cnt;
	public int rnum;
	public List list;

	private Integer miv_pageSize;
	private Integer miv_pageNo;

	private String sord;
	private String sidx;

	/**
     *
     */
	private static final long serialVersionUID = 5964387415789635560L;

	@Override
	public String toString() {
		try {
			// return ToStringBuilder.reflectionToString(this,
			// ToStringStyle.MULTI_LINE_STYLE);
			return ToStringBuilder.reflectionToString(this,
					ToStringStyle.MULTI_LINE_STYLE);
		}catch (NullPointerException e) {
			return "";
        }
	}

	/**
	 * equals
	 */
	@Override
	public boolean equals(Object o) {
		return EqualsBuilder.reflectionEquals(this, o);
	}

	/**
	 * hashCode
	 */
	@Override
	public int hashCode() {
		return HashCodeBuilder.reflectionHashCode(this);
	}

	public String getCreated_by() {
		return created_by;
	}

	public void setCreated_by(String created_by) {
		this.created_by = created_by;
	}

	public String getCreated_dttm() {
		return created_dttm;
	}

	public void setCreated_dttm(String created_dttm) {
		this.created_dttm = created_dttm;
	}

	public String getModify_by() {
		return modify_by;
	}

	public void setModify_by(String modify_by) {
		this.modify_by = modify_by;
	}

	public String getModify_by_nm() {
		return modify_by_nm;
	}

	public void setModify_by_nm(String modify_by_nm) {
		this.modify_by_nm = modify_by_nm;
	}

	public String getModify_dttm() {
		return modify_dttm;
	}

	public void setModify_dttm(String modify_dttm) {
		this.modify_dttm = modify_dttm;
	}

	public int getTotal_cnt() {
		return total_cnt;
	}

	public void setTotal_cnt(int total_cnt) {
		this.total_cnt = total_cnt;
	}

	public int getRnum() {
		return rnum;
	}

	public void setRnum(int rnum) {
		this.rnum = rnum;
	}

	public List getList() {
		return list;
	}

	public void setList(List list) {
		this.list = list;
	}

	public String getCreated_by_nm() {
		return created_by_nm;
	}

	public void setCreated_by_nm(String created_by_nm) {
		this.created_by_nm = created_by_nm;
	}

	public Integer getMiv_pageSize() {
		return miv_pageSize;
	}

	public void setMiv_pageSize(Integer miv_pageSize) {
		this.miv_pageSize = miv_pageSize;
	}

	public Integer getMiv_pageNo() {
		return miv_pageNo;
	}

	public void setMiv_pageNo(Integer miv_pageNo) {
		this.miv_pageNo = miv_pageNo;
	}

	public String getSord() {
		return sord;
	}

	public void setSord(String sord) {
		this.sord = sord;
	}

	public String getSidx() {
		return sidx;
	}

	public void setSidx(String sidx) {
		this.sidx = sidx;
	}

}
