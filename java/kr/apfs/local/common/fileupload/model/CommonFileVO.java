package kr.apfs.local.common.fileupload.model;

import org.apache.ibatis.type.Alias;

import kr.apfs.local.common.model.BaseVO;

@Alias("CommonFileVO")
public class CommonFileVO extends BaseVO {
	private String file_id;
	private String file_nm;
	private String file_type;
	private long file_size;
	private String origin_file_nm;
	private String group_id;
	private String file_path;
	private String use_yn;
	private String s_user_no;
	
	public String getFile_id() {
		return file_id;
	}
	public void setFile_id(String file_id) {
		this.file_id = file_id;
	}
	public String getFile_nm() {
		return file_nm;
	}
	public void setFile_nm(String file_nm) {
		this.file_nm = file_nm;
	}
	public String getFile_type() {
		return file_type;
	}
	public void setFile_type(String file_type) {
		this.file_type = file_type;
	}
	public long getFile_size() {
		return file_size;
	}
	public void setFile_size(long file_size) {
		this.file_size = file_size;
	}
	public String getOrigin_file_nm() {
		return origin_file_nm;
	}
	public void setOrigin_file_nm(String origin_file_nm) {
		this.origin_file_nm = origin_file_nm;
	}
	public String getGroup_id() {
		return group_id;
	}
	public void setGroup_id(String group_id) {
		this.group_id = group_id;
	}
	public String getFile_path() {
		return file_path;
	}
	public void setFile_path(String file_path) {
		this.file_path = file_path;
	}
	public String getUse_yn() {
		return use_yn;
	}
	public void setUse_yn(String use_yn) {
		this.use_yn = use_yn;
	}
	public String getS_user_no() {
		return s_user_no;
	}
	public void setS_user_no(String s_user_id) {
		this.s_user_no = s_user_id;
	}
	
}
