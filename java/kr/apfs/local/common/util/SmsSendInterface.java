package kr.apfs.local.common.util;

public interface SmsSendInterface {
	  public long sendMessage(String receiver, String msg, String sender) throws Exception;
}
