package kr.apfs.local.common.util.captcha;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import nl.captcha.Captcha;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class CaptchaController {

	// 페이지 매핑 
	@RequestMapping(value = "/captcha.do", method = RequestMethod.GET) 
	public String Captcha() { 
		return "captcha"; 
	} 
	
	// captcha 이미지 가져오는 메서드 
	@RequestMapping(value = "/captchaImg.do", method = RequestMethod.GET)
	@ResponseBody 
	public void captchaImg(HttpServletRequest req, HttpServletResponse res) throws Exception{ 
		new CaptchaUtil().getImgCaptCha(req, res); 
	} 
	
	// 전달받은 문자열로 음성 가져오는 메서드 
	@RequestMapping(value = "/captchaAudio.do", method = RequestMethod.GET)
	@ResponseBody 
	public void captchaAudio(HttpServletRequest req, HttpServletResponse res) throws Exception{ 
		Captcha captcha = (Captcha) req.getSession().getAttribute(Captcha.NAME); 
		String getAnswer = captcha.getAnswer(); 
		new CaptchaUtil().getAudioCaptCha(req, res, getAnswer); 
	} 
	
	// 사용자가 입력한 보안문자 체크하는 메서드 
	@RequestMapping(value = "/chkAnswer.do", method = RequestMethod.POST)
	@ResponseBody public String chkAnswer(HttpServletRequest req, HttpServletResponse res) { 
		String result = ""; 
		Captcha captcha = (Captcha) req.getSession().getAttribute(Captcha.NAME); 
		String ans = req.getParameter("answer"); 
		
		if(ans!=null && !"".equals(ans)) { 
			if(captcha.isCorrect(ans)) { 
				req.getSession().removeAttribute(Captcha.NAME); 
				result = "200"; 
			} else { 
				result = "300"; 
			} 
		} 
		
		return result; 
	}
}
