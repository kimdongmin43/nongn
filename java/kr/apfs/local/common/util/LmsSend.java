package kr.apfs.local.common.util;

import java.io.*;
import java.net.*;
import java.util.*;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

/**
 * <p>Title: 서울시 SMS전송 시스템 SMS전송 외부연동 Helper</p>
 * <p>Description: 서울시 SMS전송 시스템의 외부연동은 HTTP로 개발되어 있습니다. HTTP호출을
 * 통해 메세지를 전송할 수 없는 경우나 개발상 편의를 위해 이 Helper클래스를 사용할 수 있습니다.
   * 배포된 페키지에는 SmsSend.class 와 SmsSend.properties가 포함이 되어 있습니다. SmsSend.properties
 * 는 서울시 SMS전송 시스템과의 연동에 필요한 설정을 가지고 있습니다.
 * <br>
 * 이 라이브러리를 사용하기 위해서는 우선 서울시 SMS전송 시스템 담당자로 부터 아이디를
 * 발급받아야 합니다.  이 인증 정보는 SmsSend.properties에서 Default.ID 와 Default.PW를
 * 통해 설정을 할 수 있으며 setId , setPw 메소드를 통해서도 설정할 수 있습니다.
 * </p>
 * <p>Copyright: Copyright (C) 2004</p>
 * <p>Company: N/A</p>
 * @author N/A
 * @version 2006.08.04.31 - for JDK1.3
 */

public class LmsSend  implements SmsSendInterface { 

  public static final String VERSION = "2006.08.04.31";
  private static final Log logger = LogFactory.getLog(LmsSend.class);
  /**
   * 초기상태 = 0
   */
  public static final int NEEDS_INIT = 0;
  /**
   * 인증실패 = -10
   */
  public static final int AUTH_ERROR = -10;
  /**
   * 데이터 오류 = -20 ( 폰번호 오류 , 메세지 길이 1000byte 초과 , 예약 시간이 3개월 이후일 때 등 )
   **/
  public static final int DATA_ERROR = -20;
  /**
   * 통신오류 = -30 ( http 통신 오류 , tcp/ip 오류 , 네트워크 장애 등 )
   */
  public static final int COMM_ERROR = -30;

  private static String defaultID = "youthhope";
  private static String defaultPW = "hope6578";
  private static int defaultConnectionTimeout = 5000;
  private static int defaultIOTimeout = 5000;
  private static int defaultPort = 80;
  private static String defaultHost = "115.84.164.23";
  private static String defaultPage = "/SMS/ext_lms_send.do";
  private static boolean debug = false;

  private long result = NEEDS_INIT;
  private Exception lastException = null;
  private String id = defaultID;
  private String pw = defaultPW;
  private String sender;
  private String receiver;
  private String msg;
  private String reserve;
  private String subject;
  private String host = defaultHost;
  private int port = defaultPort;
  private int IOTimeout = defaultIOTimeout;
  private int connectionTimeout = defaultConnectionTimeout;
  private String receiverName;

  static {
    try {
      ResourceBundle rb = ResourceBundle.getBundle(LmsSend.class.getName());
      try {
        defaultID = (String)ConfigUtil.getProperty("sms.id");
      }catch (NullPointerException e) {
      	logger.error("NullPointerException error===", e);
      }
      try {
        defaultPW = (String)ConfigUtil.getProperty("sms.pw");
      }catch (NullPointerException e) {
        	logger.error("NullPointerException error===", e);
        }
      try {
        defaultHost = (String)ConfigUtil.getProperty("sms.host");
      }catch (NullPointerException e) {
        	logger.error("NullPointerException error===", e);
        }
      try {
        defaultPage = (String)ConfigUtil.getProperty("sms.lms_page");
      }catch (NullPointerException e) {
        	logger.error("NullPointerException error===", e);
        }
      try {
        defaultPort = StringUtil.nvl(ConfigUtil.getProperty("sms.port"),80);
      }catch (NullPointerException e) {
        	logger.error("NullPointerException error===", e);
        }
      try {
        defaultIOTimeout = StringUtil.nvl(ConfigUtil.getProperty("sms.iotimeout"),5000);
      }catch (NullPointerException e) {
        	logger.error("NullPointerException error===", e);
        }
      try {
        defaultConnectionTimeout = StringUtil.nvl(ConfigUtil.getProperty("sms.connectiontimeout"),5000);
      }catch (NullPointerException e) {
        	logger.error("NullPointerException error===", e);
        }
      try {
        debug = false;
      }catch (NullPointerException e) {
        	logger.error("NullPointerException error===", e);
        }
    }catch (NullPointerException e) {
      	logger.error("NullPointerException error===", e);
      }
  }

  /**
   * 인스턴스 생성 후 마지막 발생한 Exception 반환. 대부분 에러코드가 COMM_ERROR(-30)
   * 일 때 lastException을 사용할 수 있음.  발생한 Exception이 없다면 null을 반환.
   * @return 마지막 발생한 Exception.
   */
  public Exception getLastException() {
    return lastException;
  }

  private static void log(Object o) {
    if (debug) {
      if (o instanceof Throwable) {
        Throwable exception = (Throwable) o;
        java.io.CharArrayWriter cw = new java.io.CharArrayWriter();
        java.io.PrintWriter pw = new java.io.PrintWriter(cw, true);
        exception.printStackTrace(pw);
        o = cw.toString();
      }
      //System.out.println(    new Date() + " : " +    LmsSend.class.getName() + " : " +       o        );
    }
  }

  /**
   * 생성자. 이 생성자를 사용할 경우 receiver , msg 를 각 set 메소드를 호출하여
   * 데이터를 세팅해야 함.
   */
  public LmsSend() {
    //this(null, null, null);
  }

  /**
   * 생성자
   * @param receiver 수신자번호 ()
   * @param msg 메세지 (1000byte 이내)
   */
  public LmsSend(String receiver, String subject , String msg) {
    this(receiver, subject , msg, null);
  }

  /**
   * 생성자
   * @param receiver 수신자번호 (. 11자리 이내)
   * @param msg 메세지 (1000byte 이내)
   * @param sender 송신자번호 (. 11자리 이내)
   */
  public LmsSend(String receiver, String subject , String msg, String sender) {
    this(receiver, subject , msg, sender, null);
  }

  /**
   * 생성자
   * @param receiver 수신자번호 (. 11자리 이내)
   * @param msg 메세지 (1000byte 이내)
   * @param sender 송신자번호 (. 11자리 이내) 사용하지 않으면 null로 입력
   * @param reserve 예약일시분(yyyyMMddHHmm 포멧) 예약기능을 사용하지 않으면 null로 입력
   */
  public LmsSend(String receiver, String subject , String msg, String sender,
                 String reserve) {
    setReceiver(receiver);
    setSubject(subject);
    setMsg(msg);
    setSender(sender);
    setReserve(reserve);

    setId(defaultID);
    setPw(defaultPW);
    setConnectionTimeout(defaultConnectionTimeout);
    setIOTimeout(defaultIOTimeout);
    setPort(defaultPort);
    setHost(defaultHost);
  }



  /**
   * 메세지 전송
   * @param receiver 수신자번호 (. 11자리 이내)
   * @param msg 메세지 (1000byte 이내)
   * @return 성공시 전송요청 일련번호 (양수), 오류 시 -10,-20,-30(음수)
   */
  public long sendMessage(String receiver, String msg, String sender ) {
    setReceiver(receiver);
    setSender(sender);
    setMsg(msg);
    setSubject("");
    return send();
  }

  /**
   * 메세지 전송
   * @param receiver 수신자번호 (. 11자리 이내)
   * @param msg 메세지 (1000byte 이내)
   * @param sender 송신자번호 (. 11자리 이내) 사용하지 않으면 null로 입력
   * @return 성공시 전송요청 일련번호 (양수), 오류 시 -10,-20,-30(음수)
   */
  public long sendMessage(String receiver, String subject , String msg, String sender) {
    setReceiver(receiver);
    setSubject(subject);
    setMsg(msg);
    setSender(sender);
    return send();
  }

  /**
   * 메세지 전송
   * @param receiver 수신자번호 (. 11자리 이내)
   * @param msg 메세지 (1000byte 이내)
   * @param sender 송신자번호 (. 11자리 이내) 사용하지 않으면 null로 입력
   * @param reserve 예약일시분(yyyyMMddHHmm 포멧) 예약기능을 사용하지 않으면 null로 입력
   * @return 성공시 전송요청 일련번호 (양수), 오류 시 -10,-20,-30(음수)
   */
  public long sendMessage(String receiver, String subject , String msg, String sender,
                          String reserve) {
    setReceiver(receiver);
    setSubject(subject);
    setMsg(msg);
    setSender(sender);
    setReserve(reserve);
    return send();
  }

  /**
   * 메세지 전송. 이미 set 메소드를 사용하여 세팅한 정보를 전송함. 같은 정보로
   * 중복 호출 시 이전 처리된 상태값을 반환함.
   * @return 성공시 전송요청 일련번호 (양수), 오류 시 -10,-20,-30(음수)
   */
  public long send() {
    if (result != NEEDS_INIT) {
      return result;
    }
    // check authorization
    if (id == null || id.equals("") || pw == null || pw.equals("")) {
      return AUTH_ERROR;
    }

    // check required fields
    if (receiver == null || msg == null) {
      return DATA_ERROR;
    }

    // check receiver
    if (receiver.length() < 10) {
      return DATA_ERROR;
    }

    // check receiver
    try {
      Integer.parseInt(receiver);
    }catch (NullPointerException e) {
    	logger.error("NullPointerException error===", e);
    	return DATA_ERROR;
    }

    // check sender
    if (sender != null) {
      if (sender.length() > 11) {
        return DATA_ERROR;
      }
      try {
        Long.parseLong(sender);
      }catch (NullPointerException e) {
      	logger.error("NullPointerException error===", e);
      	return DATA_ERROR;
      }
    }

    // check subject
    if (subject.getBytes().length > 50) {
      return DATA_ERROR;
    }

    // check msg
    if (msg.getBytes().length > 1000) {
      return DATA_ERROR;
    }

    if (reserve != null && !reserve.equals("")) {
      int reserveLength = reserve.getBytes().length;
      if (reserveLength != 12) {
        return DATA_ERROR;
      } else {
        try {
          Calendar cal = Calendar.getInstance();
          cal.add(Calendar.MONTH, 3);
          long max = cal.getTimeInMillis();
          cal.set(Integer.parseInt(reserve.substring(0, 4)), // yyyy
                  Integer.parseInt(reserve.substring(4, 6)) - 1, // mm
                  Integer.parseInt(reserve.substring(6, 8)), // dd
                  Integer.parseInt(reserve.substring(8, 10)), // hh
                  Integer.parseInt(reserve.substring(10, 12)), // mi
                  00);
          long res = cal.getTimeInMillis();
          if (res > max) {
            return DATA_ERROR;
          }
        }catch (NullPointerException e) {
        	logger.error("NullPointerException error===", e);
        	return DATA_ERROR;
        }
      }
    }
    return executeLmsSendHttp(this);
  }

  private static long executeLmsSendHttp(LmsSend lms) {
    Socket socket = null;
    BufferedReader in = null;
    OutputStream out = null;
    StringBuffer response = new StringBuffer();
    try {
      socket = new Socket(lms.host, lms.port);

      in = new BufferedReader(new InputStreamReader(socket.getInputStream()));
      out = new BufferedOutputStream(socket.getOutputStream());

      StringBuffer request = new StringBuffer();

      request.append("GET ").append(defaultPage);

      request.append("?id=").append(
        URLEncoder.encode(lms.id != null ? lms.id : ""));
      request.append("&pw=").append(
        URLEncoder.encode(lms.pw != null ? lms.pw : ""));
      request.append("&receiver=").append(
        lms.receiver != null ? lms.receiver : "");
      request.append("&receivername=").append(
        URLEncoder.encode(lms.receiverName == null ? "" : lms.receiverName));
	  request.append("&subject=").append(URLEncoder.encode(lms.subject , "EUC-KR"));
      request.append("&msg=").append(URLEncoder.encode(lms.msg , "EUC-KR"));
      request.append("&sender=").append(lms.sender != null ? lms.sender : "");
      request.append("&reserve=").append(lms.reserve != null ? lms.reserve : "");

      request.append(" HTTP/1.0").
        append("\r\n");
      request.append("Accept:*/*").append("\r\n");
      request.append("Accept-Language:").append("ko").append("\r\n");
      request.append("User-Agent:").append(
        "service.cityhall.connector.SmsSend@").append(VERSION).
        append("\r\n");
      request.append("Connection:").append("close").append("\r\n");
      request.append("Host:").append(lms.host +
                                     (lms.port != 80 ? ":" + lms.port : "")).
        append("\r\n");
      request.append("\r\n");
      log("--REQUEST-------------------------------------------\r\n" + request);

      out.write(request.toString().getBytes());
      out.flush();

      String line = in.readLine();
      if (!line.startsWith("HTTP/")) {
        throw new IOException("HTTP response expected [http protocol missing]");
      }

      int i0;
      int i1;

      log("--RESPONSE------------------------------------------\r\n" + line);
      i0 = line.indexOf(' ');
      line = line.substring(i0).trim();

      i0 = line.indexOf(' ');
      if (i0 < 0) {
        i0 = line.length();
      }
      line = line.substring(i0).trim();

      /*
            // http response message
            if (!line.equals("")) {
              httpResponseMessage = line;
            } else {
              httpResponseMessage = "";
            }
       */while (true) {
        line = in.readLine();
        log(line);
        if (line == null) {
          break;
        } else if (!line.equals("")) {
          break;
        }
      }

      if (line != null) {
        response.append(line).append("\r\n");
        while ( (line = in.readLine()) != null) {
          log(line);
          response.append(line).append("\r\n");
        }

        String buffer = response.toString().trim();
        int offset = buffer.indexOf("\r\n\r\n");
        if (offset > 0) {
          buffer = buffer.substring(offset).trim();
        }
        return lms.result = Long.parseLong(buffer.trim());
      } else {
        throw new IOException("HTTP response expected [empty response]");
      }
    }catch (IOException e) {
    	logger.error("IOException error===", e);
    	lms.lastException = (Exception) e;
        log(e);
        return lms.result = COMM_ERROR;
    } catch (NullPointerException e) {
    	logger.error("NullPointerException error===", e);
    	lms.lastException = (Exception) e;
        log(e);
        return lms.result = COMM_ERROR;
    }finally {
      try {
        if (in != null) {
          in.close();
        }
      }catch (IOException e) {
      	logger.error("IOException error===", e);
      } catch (NullPointerException e) {
      	logger.error("NullPointerException error===", e);
      }
      try {
        if (out != null) {
          out.close();
        }
      }catch (IOException e) {
      	logger.error("IOException error===", e);
      } catch (NullPointerException e) {
      	logger.error("NullPointerException error===", e);
      }
      try {
        if (socket != null) {
          socket.shutdownInput();
        }
      }catch (IOException e) {
      	logger.error("IOException error===", e);
      } catch (NullPointerException e) {
      	logger.error("NullPointerException error===", e);
      }
      try {
        if (socket != null) {
          socket.shutdownOutput();
        }
      }catch (IOException e) {
      	logger.error("IOException error===", e);
      } catch (NullPointerException e) {
      	logger.error("NullPointerException error===", e);
      }
      try {
        if (socket != null) {
          socket.close();
        }
      }catch (IOException e) {
      	logger.error("IOException error===", e);
      } catch (NullPointerException e) {
      	logger.error("NullPointerException error===", e);
      }
    }
  }

  /**
   * 서울시 SMS전송 시스템 인증 아이디
   * @return 서울시 SMS전송 시스템 인증 아이디
   */
  public String getId() {
    return id;
  }

  /**
   * 서울시 SMS전송 시스템 인증 아이디
   * @param id 인증 아이디
   */
  public void setId(String id) {
    result = NEEDS_INIT;
    this.id = id;
  }

  /**
   * 서울시 SMS전송 시스템 인증 비밀번호
   * @return pw 인증 비밀번호
   */
  public String getPw() {
    return pw;
  }

  /**
   * 서울시 SMS전송 시스템 인증 비밀번호 세팅
   * @param pw 서울시 SMS전송 시스템 담당자로 부터 발급받은 인증 비밀번호
   */
  public void setPw(String pw) {
    result = NEEDS_INIT;
    this.pw = pw;
  }

  /**
   * 송신자 전화번호
   * @return 송신자 전화번호. 설정되어 있지 않으면 null반환
   */
  public String getSender() {
    return sender;
  }

  /**
   * 송신자 전화번호 세팅
   * @param sender 송신자 전화번호
   */
  public void setSender(String sender) {
    // 2006-08-04 micron
    // remove any '-'
    if( sender != null ){
      sender = replace( sender , "-" , "" );
    }
    result = NEEDS_INIT;
    this.sender = sender;
  }

  /**
   * 수신자 전화번호
   * @return 수신자 전화번호. 설정되어 있지 않으면 null반환
   */
  public String getReceiver() {
    return receiver;
  }

  /**
   * 수신자 전화번호 세팅
   * @param receiver 수신자 전화번호 11자리 이내.
   */
  public void setReceiver(String receiver) {
    // 2006-08-04 micron
    // null check + remove any '-'
    if( receiver == null ){
      throw new NullPointerException("receiver");
    }else{
      receiver = replace( receiver , "-" , "" );
    }
    result = NEEDS_INIT;
    this.receiver = receiver;
  }

  /**
   * 메세지 반환
   * @return 메세지 반환. 설정되어 있지 않으면 null반환
   */
  public String getMsg() {
    return msg;
  }

  /**
   * 메세지 세팅
   * @param msg 메세지 (1000byte 이내)
   */
  public void setMsg(String msg) {
    result = NEEDS_INIT;
    this.msg = msg;
  }


  /**
   * 메세지 반환
   * @return 메세지 반환. 설정되어 있지 않으면 null반환
   */
  public String getSubject() {
    return subject;
  }

  /**
   * 메세지 세팅
   * @param msg 메세지 (1000byte 이내)
   */
  public void setSubject(String subject) {
    result = NEEDS_INIT;
    this.subject = subject;
  }


  /**
   * 예약시간 반환
   * @return 예약시간. (yyyyMMddHHmm 포멧). 예약시간이 설정되어 있지 않으면 null반환
   */
  public String getReserve() {
    return reserve;
  }

  /**
   * 예약시간 설정
   * @param reserve (yyyyMMddHHmm 포멧)
   */
  public void setReserve(String reserve) {
    result = NEEDS_INIT;
    this.reserve = reserve;
  }

  /**
   * 예약시간 설정
   * @param reserve (예약일시 java.util.Date)
   */
  public void setReserve(Date date) {
    Calendar cal = Calendar.getInstance();
    cal.setTime(date);
    setReserve(
      right("00" + (cal.get(Calendar.YEAR)), 4) +
      right("00" + (cal.get(Calendar.MONTH) + 1), 2) +
      right("00" + (cal.get(Calendar.DATE)), 2) +
      right("00" + (cal.get(Calendar.HOUR_OF_DAY)), 2) +
      right("00" + (cal.get(Calendar.MINUTE)), 2)
      );
  }

  /**
   * 예약시간 설정
   * @param year 년도
   * @param month 월
   * @param date 일
   * @param hour 시 (24시 기준)
   * @param minute 분
   */
  public void setReserve(int year, int month, int date, int hour, int minute) {
    Calendar cal = Calendar.getInstance();
    cal.set(year, month - 1, date, hour, minute, 0);
    setReserve(
      right("0000" + (cal.get(Calendar.YEAR)), 4) +
      right("00" + (cal.get(Calendar.MONTH) + 1), 2) +
      right("00" + (cal.get(Calendar.DATE)), 2) +
      right("00" + (cal.get(Calendar.HOUR_OF_DAY)), 2) +
      right("00" + (cal.get(Calendar.MINUTE)), 2)
      );
  }

  private static String right(String s, int len) {
    if (s.length() < len) {
      return s;
    }
    return s.substring(s.length() - len);
  }

  public String getHost() {
    return host;
  }

  public void setHost(String host) {
    result = NEEDS_INIT;
    this.host = host;
  }

  public int getPort() {
    return port;
  }

  public void setPort(int port) {
    result = NEEDS_INIT;
    this.port = port;
  }

  public int getIOTimeout() {
    return IOTimeout;
  }

  public void setIOTimeout(int IOTimeout) {
    this.IOTimeout = IOTimeout;
  }

  public int getConnectionTimeout() {
    return connectionTimeout;
  }

  public long getResult() {
    return result;
  }

  public String getReceiverName() {
    return receiverName;
  }

  public void setReceiverName(String receiverName) {
    result = NEEDS_INIT;
    this.receiverName = receiverName;
  }

  public void setConnectionTimeout(int connectionTimeout) {
    this.connectionTimeout = connectionTimeout;
  }

  public static void setDefaultID(String id) {
    LmsSend.defaultID = id;
  }

  public static String getDefaultID() {
    return LmsSend.defaultID;
  }

  public static void setDefaultPW(String pw) {
    LmsSend.defaultPW = pw;
  }

  public static String getDefaultPW() {
    return LmsSend.defaultPW;
  }

  public static String getDefaultHost() {
    return defaultHost;
  }

  public static void setDefaultHost(String defaultHost) {
    LmsSend.defaultHost = defaultHost;
  }

  public static int getDefaultPort() {
    return defaultPort;
  }

  public static void setDefaultPort(int defaultPort) {
    LmsSend.defaultPort = defaultPort;
  }

  public static int getDefaultIOTimeout() {
    return defaultIOTimeout;
  }

  public static void setDefaultIOTimeout(int defaultIOTimeout) {
    LmsSend.defaultIOTimeout = defaultIOTimeout;
  }

  public static int getDefaultConnectionTimeout() {
    return defaultConnectionTimeout;
  }

  public static void setDefaultConnectionTimeout(int defaultConnectionTimeout) {
    LmsSend.defaultConnectionTimeout = defaultConnectionTimeout;
  }

  // 2006-08-04 micron
  private static final String replace(Object src_, Object fnd, Object rep) {
  if (src_ == null) {
    return null;
  }
  String line = String.valueOf(src_);
  String oldString = String.valueOf(fnd);
  String newString = String.valueOf(rep);
  int i = 0;
  if ( (i = line.indexOf(oldString, i)) >= 0) {
    char[] line2 = line.toCharArray();
    char[] newString2 = newString.toCharArray();
    int oLength = oldString.length();
    StringBuffer buf = new StringBuffer(line2.length);
    buf.append(line2, 0, i).append(newString2);
    i += oLength;
    int j = i;
    while ( (i = line.indexOf(oldString, i)) > 0) {
      buf.append(line2, j, i - j).append(newString2);
      i += oLength;
      j = i;
    }
    buf.append(line2, j, line2.length - j);
    return buf.toString();
  }
  return line;
}
}
