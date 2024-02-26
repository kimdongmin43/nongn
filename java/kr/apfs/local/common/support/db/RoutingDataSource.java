package kr.apfs.local.common.support.db;

	import java.util.Map;

	import javax.sql.DataSource;

	import org.apache.commons.dbcp.BasicDataSource;

	public class RoutingDataSource {

		public static DataSource createDataSource( Map<String,Object> dbInfo) {
			BasicDataSource ds = new BasicDataSource();
			ds.setDriverClassName((String)dbInfo.get("_driverClassName"));
			ds.setUrl((String)dbInfo.get("_url"));
			ds.setUsername((String)dbInfo.get("_usrName"));
			ds.setPassword((String)dbInfo.get("_password"));
			ds.setAccessToUnderlyingConnectionAllowed(true);
			return ds;
		}
	}

