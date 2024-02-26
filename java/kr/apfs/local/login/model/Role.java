package kr.apfs.local.login.model;

import java.util.List;

import org.springframework.security.core.GrantedAuthority;
/**
 * 
 * @author h2y
 *
 */
public class Role implements GrantedAuthority {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	/**
	 * 
	 */
	private String name;
	/**
	 * 
	 */
	private List<Privilege> privileges;

	@Override
	public final String getAuthority() {
		// TODO Auto-generated method stub
		return this.name;
	}

	/**
	 * @return the name
	 */
	public final String getName() {
		return name;
	}

	/**
	 * @param value the name to set
	 */
	public final void setName(final String value) {
		this.name = value;
	}

	/**
	 * @return the privileges
	 */
	public final List<Privilege> getPrivileges() {
		return privileges;
	}

	/**
	 * @param list the privileges to set
	 */
	public final void setPrivileges(final List<Privilege> list) {
		this.privileges = list;
	}

}
