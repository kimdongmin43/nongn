package kr.apfs.local.common.util.captcha;

import java.awt.Color;
import java.awt.Font;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import nl.captcha.Captcha;
import nl.captcha.audio.AudioCaptcha;
import nl.captcha.audio.producer.VoiceProducer;
import nl.captcha.backgrounds.GradiatedBackgroundProducer;
import nl.captcha.servlet.CaptchaServletUtil;
import nl.captcha.text.producer.NumbersAnswerProducer;
import nl.captcha.text.renderer.DefaultWordRenderer;

/**
 * 보안 문자 이미지 생성, 음성 처리 후 반환 기능
 * @author 농금원 정보화팀 강철구
 * @since 2020.10.16
 * @version 1.0
 * @see <pre>
 *  == 개정이력(Modification Information) ==
 *
 *   수정일      			수정자           		수정내용
 *  -------    		--------    ---------------------------
 *  2020.10.16		강철구          		 최초 생성
 *
 * </pre>
 */


public class CaptchaUtil {
	private static int width = 150; /*보안문자 이미지 가로크기*/ 
	private static int height = 60; /*보안문자 이미지 세로크기*/ 
	
	/*CaptCha Image 생성*/ 
	public void getImgCaptCha(HttpServletRequest req, HttpServletResponse res) { 
		/*폰트 및 컬러 설정*/ 
		List<Font> fontList = new ArrayList<Font>(); 
		fontList.add(new Font("", Font.HANGING_BASELINE, 40)); 
		fontList.add(new Font("Courier", Font.ITALIC, 40)); 
		fontList.add(new Font("", Font.PLAIN, 40)); 
		List<Color> colorList = new ArrayList<Color>(); 
		colorList.add(Color.BLACK); 
		Captcha captcha = new Captcha.Builder(width, height) // .addText() 또는 아래와 같이 정의 : 6자리 숫자와 폰트 및 컬러 설정 						 
							.addText(new NumbersAnswerProducer(6), new DefaultWordRenderer(colorList, fontList))
							.addNoise().addBorder() 
							.addBackground(new GradiatedBackgroundProducer()) 
							.build(); 
		/*JSP에서 Captcha 객체에 접근할 수 있도록 session에 저장*/ 
		req.getSession().setAttribute(Captcha.NAME, captcha); 
		CaptchaServletUtil.writeImage(res, captcha.getImage()); 
	} 
	
	/*CaptCha Audio 생성*/ 
	public void getAudioCaptCha(HttpServletRequest req, HttpServletResponse res, String answer) throws IOException { 
		HttpSession session = req.getSession(); 
		
		Captcha captcha = (Captcha) session.getAttribute(Captcha.NAME); 
		String getAnswer = answer; 
		
		if(getAnswer == null || getAnswer.equals("")) getAnswer = captcha.getAnswer(); 
		
		VoiceProducer vProd = new SetKorVoiceProducer(); //한글 음성을 생성해주는 객체 생성	<-- 영어음성일 경우 제거할 것 2020.10.16
		
		AudioCaptcha audiocaptcha = new AudioCaptcha.Builder() 
										.addAnswer(new SetTextProducer(getAnswer)) 
										.addNoise() /*잡음 추가*/ 
										.addVoice(vProd) //한글음성생성자를 AudioCaptcha에 적용     <-- 영어음성일 경우 제거할 것  2020.10.16
										.build(); 
		CaptchaServletUtil.writeAudio(res, audiocaptcha.getChallenge()); 
	} 
}
