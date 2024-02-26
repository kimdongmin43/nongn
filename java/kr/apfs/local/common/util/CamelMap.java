/*
 * Copyright 2008-2009 MOPAS(Ministry of Public Administration and Security).
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
package kr.apfs.local.common.util;

import java.io.BufferedReader;
import java.io.IOException;
import java.sql.Clob;
import java.sql.SQLException;
import java.util.HashMap;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;


/**
 * Camel Case 표기법 변환 처리를 포함하는 Map 확장 클래스
 * <p>
 * <b>NOTE</b>: commons Collections 의 ListOrderedMap 을
 * extends 하고 있으며 Map 의 key 를 입력 시 Camel Case 표기법으로
 * 변경하여 처리하는 Map 의 구현체이다. (iBatis 의 경우 egovMap 으로 결과 조회
 * 시 별도의 alias 없이 DB 칼럼명 그대로 조회하는 것 만으로도 일반적인 VO 의
 * attribute (camel case) 에 대한 resultMap 과 같은 효과를 낼 수
 * 있도록 추가하였음)
 * @author 실행환경 개발팀 우병훈
 * @since 2009.02.06
 * @version 1.0
 * @see <pre>
 *  == 개정이력(Modification Information) ==
 *
 *   수정일      수정자           수정내용
 *  -------    --------    ---------------------------
 *   2009.02.06  우병훈          최초 생성
 *
 * </pre>
 */
public class CamelMap extends HashMap {

    private static final long serialVersionUID = 6723434363565852261L;
    
    private static final Log logger = LogFactory.getLog(CamelMap.class);

    /**
     * key 에 대하여 Camel Case 변환하여 super.put
     * (ListOrderedMap) 을 호출한다.
     * @param key
     *        - '_' 가 포함된 변수명
     * @param value
     *        - 명시된 key 에 대한 값 (변경 없음)
     * @return previous value associated with specified
     *         key, or null if there was no mapping for
     *         key
     */
    @Override
    public Object put(Object key, Object value) {

    	if(value instanceof Clob){
    		try {
				value= clobToString((Clob) value);
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				//e.printStackTrace();
				logger.error("error===", e);
			} catch (IOException e) {
				// TODO Auto-generated catch block
				//e.printStackTrace();
				logger.error("error===", e);
			}
    	}
        return super.put(CamelUtil.convert2CamelCase((String) key), value);
    }

    public static String clobToString(Clob clob) throws SQLException,IOException {

	   if (clob == null) {
		   return "";
	   }

	   StringBuffer strOut = new StringBuffer();

	   String str = "";

	   BufferedReader br = null;	   
	   try{
		   br = new BufferedReader(clob.getCharacterStream());
		   
		   while ((str = br.readLine()) != null) {
		   strOut.append(str);
		   strOut.append(System.getProperty("line.separator"));		   
		   	   
		   }
	   }
	   catch (IOException e) {
       	logger.error("IOException error===", e);
       }
       finally {
       	if (br != null) {
       		try {
       			br.close();
       		} catch (IOException e) {
       			logger.error(e);
       			}
       	}
       }
	   return strOut.toString();
  }

}