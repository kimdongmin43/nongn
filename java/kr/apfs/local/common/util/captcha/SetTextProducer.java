package kr.apfs.local.common.util.captcha;

import nl.captcha.text.producer.TextProducer;

/**
 * SimpleCaptcha 클래스에 보안문자 생성 후 반환
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

public class SetTextProducer implements TextProducer {

	private final String str; 
	
	public SetTextProducer(String getAnswer) { 
		this.str = getAnswer; 
	} 
	
	@Override
	public String getText() {
		return this.str; 
	}

}
