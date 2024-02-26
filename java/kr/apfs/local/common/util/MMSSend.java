package kr.apfs.local.common.util;

import java.net.URLEncoder;

import org.apache.commons.httpclient.HttpClient;
import org.apache.commons.httpclient.methods.PostMethod;
import org.apache.commons.httpclient.methods.multipart.MultipartRequestEntity;
import org.apache.commons.httpclient.methods.multipart.Part;
import org.apache.commons.httpclient.methods.multipart.StringPart;
 
public class MMSSend  implements SmsSendInterface { 
	  private  String defaultID = "test";
	  private  String defaultPW = "test";
	  private  int defaultConnectionTimeout = 5000;
	  private  int defaultIOTimeout = 5000;
	  private  int defaultPort = 80;
	  private  String defaultHost = "115.84.164.23";
	  private  String defaultPage = "/SMS/ext_lms_send.do";
	  private  boolean debug = false;
	  private String url = "";
	   public MMSSend(){
			  defaultID = (String)ConfigUtil.getProperty("sms.id");
			  defaultPW = (String)ConfigUtil.getProperty("sms.pw");
			  defaultConnectionTimeout = StringUtil.nvl(ConfigUtil.getProperty("sms.connectiontimeout"),5000);
			  defaultIOTimeout = StringUtil.nvl(ConfigUtil.getProperty("sms.iotimeout"),5000);
			  defaultPort = StringUtil.nvl(ConfigUtil.getProperty("sms.port"),80);
			  defaultHost = (String)ConfigUtil.getProperty("sms.host");
			  defaultPage = (String)ConfigUtil.getProperty("sms.mms_page");
			  url =  "http://" + defaultHost +":"+defaultPort+defaultPage;
	   }
	/**
	 * @param args
	 */
	public long sendMessage(String receiver, String msg, String sender) throws Exception {
	     return sendMessage(sender, receiver, "", msg); 
	}
	/**
	 * @param args
	 */
	public long sendMessage(String sender, String receiver, String subject, String msg) throws Exception {
		
		HttpClient client = new HttpClient();
		client.getHttpConnectionManager().getParams().setConnectionTimeout(defaultConnectionTimeout);
		client.getParams().setParameter("http.protocol.content-charset", "EUC-KR");
		PostMethod post = new PostMethod(url); 

		Part[] parts = { new StringPart("id", defaultID) 
		               , new StringPart("pw", defaultPW) // 패스워드가 test일 경우
		               , new StringPart("sender", sender) // 발신자 번호                         
		               , new StringPart("receiver", receiver) // 수신자 번호
		               , new StringPart("subject", URLEncoder.encode(subject , "EUC-KR")) 
		               , new StringPart("msg", URLEncoder.encode(msg , "EUC-KR")) 
		};  
		
		post.setRequestEntity(new MultipartRequestEntity(parts, post.getParams()));

		long status = client.executeMethod(post);
		
		if (status >= 200 && status <= 299) {
			//System.out.println(post.getResponseBodyAsString().trim());
		}
		
		return status;
	}

}
