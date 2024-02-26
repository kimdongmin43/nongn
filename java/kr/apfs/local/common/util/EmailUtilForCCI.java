package  kr.apfs.local.common.util;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.security.InvalidAlgorithmParameterException;
import java.security.InvalidKeyException;
import java.security.NoSuchAlgorithmException;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Properties;

import javax.crypto.BadPaddingException;
import javax.crypto.Cipher;
import javax.crypto.IllegalBlockSizeException;
import javax.crypto.NoSuchPaddingException;
import javax.mail.Address;
import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.stereotype.Component;

/**
 *
 * EmailUtil.java <br>
 * <br>
 * @author xr
 * @since 2018. 1. 16.
 * @version 1.0 <br>
 *
 * <pre>
 * ==========================================================================
 *  SYSTEM            : 농금원
 *  SUB SYSTEM        : 회원관리시스템 ONLINEWEB
 *  PROGRAM NAME      : 이메일 관련 처리
 *  PROGRAM HISTORY   :2018. 01. 16.
 *  ==========================================================================
 * </pre>
 *
 *
 */
@Component
public class EmailUtilForCCI {
	private static final Log logger = LogFactory.getLog(EmailUtilForCCI.class);

	//private final String SMTP_korcham_NET = "smtp.korcham.net";

	/**
	 * 메일 발송 처리
	 * @param toEmail
	 * @param fromEmail
	 * @param message
	 * @throws MessagingException 
	 */
	public void sendEmail(String toEmail, String fromEmail, String fromNm, String title_msg, String msg, String serverUrl){
			String mailHtml = "";
		  Properties p = new Properties();
		  p.put("mail.smtp.host", "smtp.gmail.com");
		  p.put("mail.smtp.port", "465");		//	465   587
		  p.put("mail.smtp.auth", "true");
	      p.put("mail.smtp.ssl.trust", "smtp.gmail.com");
	      p.put("mail.smtp.localhost", "gmail.com");
		  p.put("mail.smtp.debug", "true");
	      p.put("mail.smtp.ssl.enable", "true");
//	      p.put("mail.smtp.starttls.enable", "true");

		try
		{
			mailHtml = generateCompleteMessage(title_msg, msg, fromEmail, serverUrl);

			Authenticator auth = new SMTPAuthenticator();
			Session session = Session.getInstance(p, auth);
			session.setDebug(true); // 메일을 전송할 때 상세한 상황을 콘솔에 출력한다.

			   //session = Session.getDefaultInstance(p);
			MimeMessage msg2 = new MimeMessage(session);
			String message = mailHtml;
			msg2.setSubject(title_msg);
			Address fromAddr = new InternetAddress("apfsreport@gmail.com"); // 보내는 사람의 메일주소
			msg2.setFrom(fromAddr);
			Address toAddr = new InternetAddress(toEmail);  // 받는 사람의 메일주소
			msg2.addRecipient(Message.RecipientType.TO, toAddr);
			msg2.setContent(message, "text/html;charset=UTF-8");
			//System.out.println("Message: " + msg2.getContent());
			Transport.send(msg2);
			//System.out.println("Gmail SMTP서버를 이용한 메일보내기 성공");

		}
		catch (IOException e) {
        	logger.error("IOException error===", e);
        	logger.error("Email Error from : 이메일 발송 중 오류가 발생하였습니다./n");
        } catch (NullPointerException e) {
        	logger.error("NullPointerException error===", e);
        	logger.error("Email Error from : 이메일 발송 중 오류가 발생하였습니다./n");
        }
		catch(MessagingException e){
			logger.error("MessagingException error===", e);
        	logger.error("Email Error from : 이메일 발송 중 오류가 발생하였습니다./n");
		}

		String logtext = "=== 메일 발송 ============" + ", toEmail : " + toEmail + ", fromEmail : " + fromEmail + ", "+msg;

		logger.info("Email info " + logtext);

		//entity.printAll("메일 발송 Entity");
	}
	

//	private static class SMTPAuthenticator extends javax.mail.Authenticator {
//		
//		  public PasswordAuthentication getPasswordAuthentication() {
//			  
//			  Properties props = new Properties();
//			  Cipher cipher = Cipher.getInstance("AES/CBC/PKCS5Padding");
//			  String PasswordAuthentication = null;
//			  String id = null;
//			  String pw = null;
//			  
//			  try{
//				   id = props.getProperty("apfsreport@gmail.com");
//				   pw = props.getProperty("lqippsczhcyejxak");
//				  
//				  byte[] decrypted_pw = cipher.doFinal(pw.getBytes());
//				  pw = new String(decrypted_pw);
//			  }catch(SQLException e){
//				  logger.error(e);
//			  }
//			  return new PasswordAuthentication(id, pw);
//		  }
//	}
	
	
	private static class SMTPAuthenticator extends javax.mail.Authenticator {

		  public PasswordAuthentication getPasswordAuthentication() {
			  
//			  String id = "apfsreport@gmail.com";
//			  String pw = "lqippsczhcyejxak";
			  
			  String id = "aYblMoEbcWIj7C/goF7nit7XRk6DJ3ybU+efgFBRGcw=";
			  String pw = "Z3MlgVs0Jn2BsvcQrjaUvxgpSUllpBrR3qa+tyq9uOs=";
			  
			  try {
				id = CryptoUtil.AES_Decode(id);
				pw = CryptoUtil.AES_Decode(pw);
			} catch (InvalidKeyException e) {
				logger.error("InvalidKeyException error===", e);
			} catch (UnsupportedEncodingException e) {
				logger.error("UnsupportedEncodingException error===", e);
			} catch (NoSuchAlgorithmException e) {
				logger.error("NoSuchAlgorithmException error===", e);
			} catch (NoSuchPaddingException e) {
				logger.error("NoSuchPaddingException error===", e);
			} catch (InvalidAlgorithmParameterException e) {
				logger.error("InvalidAlgorithmParameterException error===", e);
			} catch (IllegalBlockSizeException e) {
				logger.error("IllegalBlockSizeException error===", e);
			} catch (BadPaddingException e) {
				logger.error("BadPaddingException error===", e);
			}
			  
		   return new PasswordAuthentication(id, pw);		//	2021.02.18 - 서버용		2021.07.08
		   
		  }
	}
	
	
	

	
	
	/**
	 * 접수완료 html 코드 생성
	 * @param entity
	 * @return
	 * @throws UnsupportedEncodingException
	 */
	private String generateCompleteMessage( String title_msg, String msg, String fromEmail, String serverUrl) throws UnsupportedEncodingException {

		String html = "<!DOCTYPE html>";
		html += "\n<html>";
		html += "\n<head>";
		html += getHeaderCode(title_msg);
		html += "\n</head>";
		html += "\n<body>";
		html += getBodyCode(msg, serverUrl);
		html += getFooterCode(fromEmail);
		html += "\n</body>";
		html += "\n</html>";

		return html;
	}


	/**
	 * 공통 body html 코드 조회
	 * @param bodyEntity
	 * @param serverUrl
	 * @return
	 * @throws UnsupportedEncodingException
	 */
	private String getBodyCode(String bodyEntity, String serverUrl) throws UnsupportedEncodingException {
		String body = "";

		body += "\n<table><tr><td>";
		body += bodyEntity;
		body += "</td></tr></table>";

		return body;
	}



	/**
	 * 공통 footer html 코드 리턴
	 * @param email
	 * @return
	 */
	private String getFooterCode(String email) {
		String footer = "";

		footer += "\n<table><tr><td></td></tr></table>";
		return footer;
	}



	/**
	 * 공통 hade html 코드 리턴
	 * @param title
	 * @return
	 */
	private String getHeaderCode(String title) {
		String header = "";

		header += "\n<table><tr><td></td></tr></table>";

		return header;
	}
}