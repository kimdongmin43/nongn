package kr.apfs.local.common.support.db;

import java.io.IOException;
import java.io.InputStreamReader;
import java.io.Reader;
import java.util.HashMap;
import java.util.Hashtable;
import java.util.List;
import java.util.Map;

import javax.sql.DataSource;

import org.apache.ibatis.builder.xml.XMLMapperBuilder;
import org.apache.ibatis.mapping.BoundSql;
import org.apache.ibatis.mapping.Environment;
import org.apache.ibatis.mapping.ParameterMapping;
import org.apache.ibatis.parsing.XNode;
import org.apache.ibatis.session.Configuration;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;
import org.apache.ibatis.transaction.TransactionFactory;
import org.apache.ibatis.transaction.jdbc.JdbcTransactionFactory;
import org.apache.ibatis.type.TypeAliasRegistry;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;


import org.springframework.context.ApplicationContext;
import org.springframework.core.io.Resource;

import kr.apfs.local.common.support.ApplicationContextProvider;

public class BuildSqlSessionFactory {
	
	private static final Logger logger = LogManager.getLogger(BuildSqlSessionFactory.class);
	
	static final Hashtable<String,Object> ds = new Hashtable<String,Object>();
	public static String dds_name;
	//private static javax.sql.DataSource ods	=	null;
	
    public static SqlSession  getSqlSession(Map<String,Object> dbInfo) throws Exception{
        
    	
    	if("".equals((String)dbInfo.get("_env")) || null == (String)dbInfo.get("_env") ){
    		dbInfo.put("_env", "environment");
    	}
        
    	DataSource dataSource = BuildSqlSessionFactory.getDataSource(dbInfo);

    	TransactionFactory trxFactory = new JdbcTransactionFactory();
        Environment env = new Environment((String)dbInfo.get("_env"), trxFactory, dataSource);
        Configuration config = new Configuration(env);
        TypeAliasRegistry aliases = config.getTypeAliasRegistry();
        
        config.setCallSettersOnNulls(true);
        
        aliases.registerAlias("caseMap",org.apache.commons.collections.map.CaseInsensitiveMap.class);
        
        ApplicationContext applicationContext = ApplicationContextProvider.getApplicationContext();
        Resource[] mapperLocations = applicationContext.getResources("classpath:sqlmaps/oracle/dynamic*SQL.xml");
       
        if (mapperLocations != null) {
            Map<String, XNode> sqlFragments = new HashMap<String, XNode>();
            for (Resource mapperLocation : mapperLocations) {
                try {
                    Reader reader = new InputStreamReader(mapperLocation.getInputStream());
                    @SuppressWarnings("deprecation")
					XMLMapperBuilder xmlMapperBuilder = new XMLMapperBuilder(reader, config, mapperLocation
                            .toString(), sqlFragments);
                    xmlMapperBuilder.parse();
                }
                catch (IOException e) {
                	logger.error("IOException error===", e);
                	throw new Exception("Failed to parse mapping resource: " + mapperLocation, e);
                } catch (NullPointerException e) {
                	logger.error("NullPointerException error===", e);
                	throw new Exception("Failed to parse mapping resource: " + mapperLocation, e);
                }catch (Exception ex) {
                    throw new Exception("Failed to parse mapping resource: " + mapperLocation, ex);
                }
            }
        }
        
        SqlSessionFactory factory = new SqlSessionFactoryBuilder().build(config);
        SqlSession sqlsession = factory.openSession();
		
        return sqlsession;
    }

    /**
     * Returns a DataSource object.
     *
     * @return a DataSource.
     */
    public static  DataSource getDataSource(Map<String,Object> dbInfo) {
    	
    	javax.sql.DataSource ods = null;
    	
    	try {
			synchronized(ds) {
				dds_name				=	(String)dbInfo.get("_dbmsId");
				ods						=	(DataSource)ds.get(dds_name);
				if(ods == null) {
					DataSource ods_		=	RoutingDataSource.createDataSource(dbInfo); //   
					ds.put(dds_name,ods_);
					ods  =ods_;
					logger.info("New DBConnection Object Created");
				}
			}
		}catch (NullPointerException e) {
        	logger.error("NullPointerException error===", e);
        	logger.error(e.getMessage(),e);
		}
    	return  ods;
    }
    
    /**
     * DataSource 초기화 
     * 
     * 
     */
    public static  void initDataSource(String dbInfo) {
    	synchronized(ds) {
    		if(ds.containsKey(dbInfo)){
    			ds.remove(dbInfo);
    		}
    	}
    	
    }
    
    
    
    /**
     * 쿼리아이디와 변수 인자값 객체를 전달받아 쿼리문을 만들어 준다 
     * @param sqlSession
     * @param queryId
     * @param sqlParam
     * @return
     */
    @SuppressWarnings("unchecked")
	public static String getQuery(SqlSession sqlSession, String queryId , Object sqlParam){

    	BoundSql boundSql = sqlSession.getConfiguration().getMappedStatement(queryId).getSqlSource().getBoundSql(sqlParam);
    	String query1 = boundSql.getSql();
    	Object paramObj = boundSql.getParameterObject();
    	if(paramObj != null){              // 파라미터가 아무것도 없을 경우
    		List<ParameterMapping> paramMapping = boundSql.getParameterMappings();
    		for(ParameterMapping mapping : paramMapping){
    			String propValue = mapping.getProperty();       
    			//query1=query1.replaceFirst("\\?", "#{"+propValue+"}");
    			query1=query1.replaceFirst("\\?", "'"+(String)((HashMap<String,Object>) paramObj).get(propValue)+"'");
    		}
    	}
    	return query1; 
    }

    /**
     * 바인딩 처리가 안된 쿼리를 보여준다
     * @param sqlSession
     * @param queryId
     * @param sqlParam
     * @return
     */
    public static String getQueryWidthOutBinding(SqlSession sqlSession, String queryId , Object sqlParam){
    	return sqlSession.getConfiguration().getMappedStatement(queryId).getSqlSource().getBoundSql(sqlParam).getSql();

    }

}