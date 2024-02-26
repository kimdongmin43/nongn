package kr.apfs.local.common.util.email;

import java.io.UnsupportedEncodingException;

import javax.mail.Address;
import javax.mail.MessagingException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

import kr.apfs.local.common.util.ConfigUtil;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.mail.MailException;
import org.springframework.mail.javamail.JavaMailSender;

public class EmailSender {
	
	private static final Log logger = LogFactory.getLog(EmailSender.class);
	
	public void SendEmail(JavaMailSender mailSender, Email email) throws Exception {

		String mailHtml = "";
        MimeMessage msg = mailSender.createMimeMessage();
        try {
        	mailHtml = generateCompleteMessage(email);
        	
            final Address toAddress = new InternetAddress(email.getReceiver());
            final Address fromAddress = new InternetAddress("apfsreport@gmail.com");        	
            msg.setSubject(email.getSubject());
            msg.setText(email.getContent());
            msg.setFrom(fromAddress);
            msg.setRecipients(MimeMessage.RecipientType.TO , InternetAddress.parse(email.getReceiver()));
           
        }catch(MessagingException e) {
            System.out.println("MessagingException");
            //e.printStackTrace();
            logger.error("error===", e);
        }
        
        try {
            mailSender.send(msg);
        }catch(MailException e) {
            System.out.println("MailException발생");
            //e.printStackTrace();
            logger.error("error===", e);
        }
    }
	
	
	/**
	 * 접수완료 html 코드 생성
	 * @param entity
	 * @return
	 * @throws UnsupportedEncodingException
	 */
	private String generateCompleteMessage( Email email) throws UnsupportedEncodingException {

		String html = "<!DOCTYPE html>";
		html += "\n<html>";
		html += "\n<head>";
		html += getHeaderCode(email.getSubject());
		html += "\n</head>";
		html += "\n<body>";
		html += getBodyCode(email.getContent(), null);
		html += getFooterCode(email.getReceiver());
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
