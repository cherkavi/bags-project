/*
 * mail.java
 *
 * Created on 8 Октябрь 2007 г., 18:56
 *
 * To change this template, choose Tools | Template Manager
 * and open the template in the editor.
 */

package main_package;

import javax.microedition.io.Connector;
import javax.microedition.io.SocketConnection;
//import javax.microedition.io.StreamConnection;
import javax.microedition.midlet.*;
import javax.microedition.lcdui.*;
import java.util.Enumeration;
import java.util.Vector;
/*import java.io.InputStream;
import java.io.OutputStream;
import java.io.IOException;*/
import java.io.*;

/**
 *
 * @author root
 */
class StringTokenizer implements Enumeration{
    private Vector v=new Vector();
    private int counter=0;
    StringTokenizer(String text,String delimeter){
        int index=0;
        while((index=(text.indexOf(delimeter)))>0){
            v.addElement(text.substring(0,index));
            text=text.substring(index+delimeter.length());
        }
        if(text.trim().length()!=0){
        	v.addElement(text);
        }
    }

    public boolean hasMoreElements() {
        return (counter<v.size());
    }

    public Object nextElement() {
        return v.elementAt(counter++);
    }
    public int countTokens(){
        return v.size();
    }

    public boolean hasMoreTokens() {
        return (counter<v.size());
    }

    public String nextToken() {
        return (String)v.elementAt(counter++);
    }
}

final class Base64 
{ 
    static private final int  BASELENGTH         = 255; 
    static private final int  LOOKUPLENGTH       = 64; 
    static private final int  TWENTYFOURBITGROUP = 24; 
    static private final int  EIGHTBIT           = 8; 
    static private final int  SIXTEENBIT         = 16; 
    static private final int  SIXBIT             = 6; 
    static private final int  FOURBYTE           = 4; 
    static private final int  SIGN               = -128; 
    static private final byte PAD                = (byte) '='; 
    static private byte [] base64Alphabet       = new byte[BASELENGTH]; 
    static private byte [] lookUpBase64Alphabet = new byte[LOOKUPLENGTH]; 
    //static private final Log log = LogSource.getInstance("org.apache.commons.util.Base64"); 

    static 
    { 
        for (int i = 0; i < BASELENGTH; i++ ) 
        { 
            base64Alphabet[i] = -1; 
        } 
        for (int i = 'Z'; i >= 'A'; i--) 
        { 
            base64Alphabet[i] = (byte) (i - 'A'); 
        } 
        for (int i = 'z'; i>= 'a'; i--) 
        { 
            base64Alphabet[i] = (byte) (i - 'a' + 26); 
        } 
        for (int i = '9'; i >= '0'; i--) 
        { 
            base64Alphabet[i] = (byte) (i - '0' + 52); 
        } 

        base64Alphabet['+']  = 62; 
        base64Alphabet['/']  = 63; 

        for (int i = 0; i <= 25; i++ ) 
            lookUpBase64Alphabet[i] = (byte) ('A' + i); 

        for (int i = 26,  j = 0; i <= 51; i++, j++ ) 
            lookUpBase64Alphabet[i] = (byte) ('a'+ j); 

        for (int i = 52,  j = 0; i <= 61; i++, j++ ) 
            lookUpBase64Alphabet[i] = (byte) ('0' + j); 

        lookUpBase64Alphabet[62] = (byte) '+'; 
        lookUpBase64Alphabet[63] = (byte) '/'; 
    } 

    public static boolean isBase64( String isValidString ) 
    { 
        return isArrayByteBase64(isValidString.getBytes()); 
    } 
    public static boolean isBase64( byte octect ) 
    { 
        //shall we ignore white space? JEFF?? 
        return (octect == PAD || base64Alphabet[octect] != -1); 
    } 

    public static boolean isArrayByteBase64( byte[] arrayOctect ) 
    { 
        int length = arrayOctect.length; 
        if (length == 0) 
        { 
            // shouldn't a 0 length array be valid base64 data? 
            // return false; 
            return true; 
        } 
        for (int i=0; i < length; i++) 
        { 
            if ( !Base64.isBase64(arrayOctect[i]) ) 
                return false; 
        } 
        return true; 
    } 
    /** 
     * Encodes hex octects into Base64. 
     * 
     * @param binaryData Array containing binary data to encode. 
     * @return Base64-encoded data. 
     */ 
    public static byte[] encode( byte[] binaryData ) 
    { 
        int      lengthDataBits    = binaryData.length*EIGHTBIT; 
        int      fewerThan24bits   = lengthDataBits%TWENTYFOURBITGROUP; 
        int      numberTriplets    = lengthDataBits/TWENTYFOURBITGROUP; 
        byte     encodedData[]     = null; 


        if (fewerThan24bits != 0) 
        { 
            //data not divisible by 24 bit 
            encodedData = new byte[ (numberTriplets + 1 ) * 4 ]; 
        } 
        else 
        { 
            // 16 or 8 bit 
            encodedData = new byte[ numberTriplets * 4 ]; 
        } 

        byte k = 0, l = 0, b1 = 0, b2 = 0, b3 = 0; 

        int encodedIndex = 0; 
        int dataIndex   = 0; 
        int i           = 0; 
        //log.debug("number of triplets = " + numberTriplets); 
        for ( i = 0; i<numberTriplets; i++ ) 
        { 
            dataIndex = i*3; 
            b1 = binaryData[dataIndex]; 
            b2 = binaryData[dataIndex + 1]; 
            b3 = binaryData[dataIndex + 2]; 

            //log.debug("b1= " + b1 +", b2= " + b2 + ", b3= " + b3); 

            l  = (byte)(b2 & 0x0f); 
            k  = (byte)(b1 & 0x03); 

            encodedIndex = i * 4; 
            byte val1 = ((b1 & SIGN)==0)?(byte)(b1>>2):(byte)((b1)>>2^0xc0); 
            byte val2 = ((b2 & SIGN)==0)?(byte)(b2>>4):(byte)((b2)>>4^0xf0); 
            byte val3 = ((b3 & SIGN)==0)?(byte)(b3>>6):(byte)((b3)>>6^0xfc); 

            encodedData[encodedIndex]   = lookUpBase64Alphabet[ val1 ]; 
            //log.debug( "val2 = " + val2 ); 
            //log.debug( "k4   = " + (k<<4) ); 
            //log.debug(  "vak  = " + (val2 | (k<<4)) ); 
            encodedData[encodedIndex+1] = 
                lookUpBase64Alphabet[ val2 | ( k<<4 )]; 
            encodedData[encodedIndex+2] = 
                lookUpBase64Alphabet[ (l <<2 ) | val3 ]; 
            encodedData[encodedIndex+3] = lookUpBase64Alphabet[ b3 & 0x3f ]; 
        } 

        // form integral number of 6-bit groups 
        dataIndex    = i*3; 
        encodedIndex = i*4; 
        if (fewerThan24bits == EIGHTBIT ) 
        { 
            b1 = binaryData[dataIndex]; 
            k = (byte) ( b1 &0x03 ); 
            //log.debug("b1=" + b1); 
            //log.debug("b1<<2 = " + (b1>>2) ); 
            byte val1 = ((b1 & SIGN)==0)?(byte)(b1>>2):(byte)((b1)>>2^0xc0); 
            encodedData[encodedIndex]     = lookUpBase64Alphabet[ val1 ]; 
            encodedData[encodedIndex + 1] = lookUpBase64Alphabet[ k<<4 ]; 
            encodedData[encodedIndex + 2] = PAD; 
            encodedData[encodedIndex + 3] = PAD; 
        } 
        else if (fewerThan24bits == SIXTEENBIT) 
        { 

            b1 = binaryData[dataIndex]; 
            b2 = binaryData[dataIndex +1 ]; 
            l = (byte) (b2 & 0x0f); 
            k = (byte) (b1 & 0x03); 

            byte val1 = ((b1 & SIGN) == 0)?(byte)(b1>>2):(byte)((b1)>>2^0xc0); 
            byte val2 = ((b2 & SIGN) == 0)?(byte)(b2>>4):(byte)((b2)>>4^0xf0); 

            encodedData[encodedIndex]     = lookUpBase64Alphabet[ val1 ]; 
            encodedData[encodedIndex + 1] = 
                lookUpBase64Alphabet[ val2 | ( k<<4 )]; 
            encodedData[encodedIndex + 2] = lookUpBase64Alphabet[ l<<2 ]; 
            encodedData[encodedIndex + 3] = PAD; 
        } 

        return encodedData; 
    } 
    /** 
     * Decodes Base64 data into octects 
     * 
     * @param binaryData Byte array containing Base64 data 
     * @return Array containing decoded data. 
     */ 
    public static byte[] decode( byte[] base64Data ) 
    { 
        // handle the edge case, so we don't have to worry about it later 
        if(base64Data.length == 0) { return new byte[0]; } 

        int      numberQuadruple    = base64Data.length/FOURBYTE; 
        byte     decodedData[]      = null; 
        byte     b1=0,b2=0,b3=0, b4=0, marker0=0, marker1=0; 

        // Throw away anything not in base64Data 

        int encodedIndex = 0; 
        int dataIndex    = 0; 
        { 
            // this sizes the output array properly - rlw 
            int lastData = base64Data.length; 
            // ignore the '=' padding 
            while (base64Data[lastData-1] == PAD) 
            { 
                if (--lastData == 0) 
                { 
                    return new byte[0]; 
                } 
            } 
            decodedData = new byte[ lastData - numberQuadruple ]; 
        } 

        for (int i = 0; i < numberQuadruple; i++) 
        { 
            dataIndex = i * 4; 
            marker0   = base64Data[dataIndex + 2]; 
            marker1   = base64Data[dataIndex + 3]; 

            b1 = base64Alphabet[base64Data[dataIndex]]; 
            b2 = base64Alphabet[base64Data[dataIndex +1]]; 

            if (marker0 != PAD && marker1 != PAD) 
            { 
                //No PAD e.g 3cQl 
                b3 = base64Alphabet[ marker0 ]; 
                b4 = base64Alphabet[ marker1 ]; 

                decodedData[encodedIndex]   = (byte)(  b1 <<2 | b2>>4 ) ; 
                decodedData[encodedIndex + 1] = 
                    (byte)(((b2 & 0xf)<<4 ) |( (b3>>2) & 0xf) ); 
                decodedData[encodedIndex + 2] = (byte)( b3<<6 | b4 ); 
            } 
            else if (marker0 == PAD) 
            { 
                //Two PAD e.g. 3c[Pad][Pad] 
                decodedData[encodedIndex]   = (byte)(  b1 <<2 | b2>>4 ) ; 
            } 
            else if (marker1 == PAD) 
            { 
                //One PAD e.g. 3cQ[Pad] 
                b3 = base64Alphabet[ marker0 ]; 

                decodedData[encodedIndex]   = (byte)(  b1 <<2 | b2>>4 ); 
                decodedData[encodedIndex + 1] = 
                    (byte)(((b2 & 0xf)<<4 ) |( (b3>>2) & 0xf) ); 
            } 
            encodedIndex += 3; 
        } 
        return decodedData; 
    } 
} 


class messages{
	String Return_path="";
	String Received="";
	String Message_Id="";
	String From="";
	String Bcc="";
	String Date="";
	String Text="";
	messages(String s){
		try{
			this.Return_path=s.substring(0,s.indexOf("Received:"));
			this.Received=s.substring(s.indexOf("Received:"),s.indexOf("Message-Id:"));
			this.Message_Id=s.substring(s.indexOf("Message-Id:"),s.indexOf("From:"));
			this.From=s.substring(s.indexOf("From:"),s.indexOf("Bcc:"));
			this.Bcc=s.substring(s.indexOf("Bcc:"),s.indexOf("Date:"));
			this.Date=s.substring(s.indexOf("Date:"));
			this.Text=this.Date.substring(this.Date.indexOf("\n"),this.Date.length());
			this.Date=this.Date.substring(0,this.Date.indexOf("\n"));
		}
		catch(Exception e){
			//System.out.println("constructor messages Error "+e.getMessage());
		}
	}
	public String getText(){
		return this.Text;
	}
	public String getFrom(){
		return this.From;
	}
	public String getDate(){
		return this.getDate();
	}
	public String toString(){
		return this.Return_path+"\n"+this.Received+"\n"+this.Message_Id+"\n"
		+this.From+"\n"+this.Bcc+"\n"+this.Date+"\n";
	}
}

/*
 *package for boolean value
 */
class boolean_package{
	private boolean value;
	boolean_package(boolean value){
		this.value=value;
	}
	boolean getValue(){
		return this.value;
	}
	void setValue(boolean value){
		this.value=value;
	}
}

class string_package{
    private String value;
    string_package(String s){
        this.value=s;
    }
    String getValue(){
        return this.value;
    }
    void setValue(String value){
        this.value=value;
    }
}

class send_mail implements Runnable{
	private Thread t;
	private SocketConnection s;
        //private StreamConnection s;
	private OutputStream os;
	private InputStream is;
	private boolean_package result_send=new boolean_package(false);
	private String From;
	private String Recipient;
	private String text;
        private String address;
        private int port;
        private String history;
        private String user;
        private String password;
	private synchronized void write_to_stream(OutputStream os,String command) throws IOException{
		byte[] buffer_output=new byte[255];
		buffer_output=command.getBytes();
		////System.out.println("to os:"+command);
		os.write(buffer_output);
		os.flush();
		buffer_output=null;
	}
	private synchronized String read_from_stream(InputStream is) throws IOException{
		byte[] buffer_input=new byte[255];
		String result="";
		String temp_result="";
		int read_count=0;
		//read_count=is.read(buffer_input);
		
		byte read_byte=0; 
		while( (!(read_byte==13))&&(read_count<255)){
                    read_byte=(byte)is.read();
                    buffer_input[++read_count]=read_byte;
                    /*if(read_byte==(-1)){
                        break;
                    }*/
                    //System.out.print((char)read_byte);
                }
		temp_result=new String(buffer_input,0,read_count);
                //System.out.println(temp_result);
		result+=temp_result;
		return result;
	}
	/**
         * проверка результата на положительный или ожидающий действия ответ
         * @param s строка ответа от сервера
         * @throw выбрасывает исключение в случае, когда сообщение больше 400 или больше 500
         */
        private void check_smtp_result(String s) throws Exception{
		boolean result=false;
		s=s.trim();
		if(s.startsWith("2")){
			result=true;
		}
		if(s.startsWith("3")){
			result=true;
		}
		/*if(s.startsWith("4")){
			result=true;
		}*/
		if(result==false){
			throw new Exception(s);
		};
	}
        /**
         * получить цифровое значение ответа от сервера для сравнения на положительные, ожидающие и отрицательные ответы
         * @param s строка ответа от сервера
         * @return возвращает 0 в случае не обнаружение в первых трех символах цифровой последовательности
         */
        private int get_smtp_result(String s){
            int return_value=0;
            try{
                return_value=Integer.parseInt(s.trim().substring(0,3));
            }catch(Exception e){
                
            }
            System.out.println("SMTP result="+return_value);
            return return_value;
        } 

	send_mail(String user,String password,String smtp_address,int port,String From,String Recipient,String text,boolean_package result,string_package trace){	
		try{
			this.From=From;
			this.Recipient=Recipient;
			this.text=text;
                        this.address=smtp_address;
                        this.port=port;
                        this.user=user;
                        this.password=password;
			////System.out.println("begin create Thread");
			this.t=new Thread(this);
			////System.out.println("Run Thread");
			this.t.start();
			////System.out.println("wait Thread");
			this.t.join();
			////System.out.println("get result Thread");
			result.setValue(this.result_send.getValue());
                        trace.setValue(this.history);
		}
		catch(Exception e){
			//System.out.println("Error in init <send mail>"+e.getMessage());
			result.setValue(false);
                        trace.setValue("Send_main.Exception:"+e.getMessage()+this.history);
		}
	}
	public void run(){
		String command;
		String answer;
                String history="";
		try{
			//System.out.println("begin socket init");
                        history="connecting\n";
                        this.s=(SocketConnection)Connector.open("socket://"+address+":"+port,Connector.READ_WRITE);
                        //this.s=(SocketConnection)Connector.open("tcp://"+address+":"+port,Connector.READ_WRITE);
                        history=history+"set Option\n";
                        this.s.setSocketOption(SocketConnection.LINGER, 0);
                        //this.s.setSocketOption(SocketConnection.KEEPALIVE, 1);
                        //this.s.setSocketOption(SocketConnection.RCVBUF, 128);
                        //this.s.setSocketOption(SocketConnection.SNDBUF, 128);
                        //this.s=(StreamConnection)Connector.open("socket://"+address+":"+port,Connector.READ_WRITE);

                        // получение InputStream и OutputStrem из Socket-а
                        //System.out.println("begin get InputStream");
                        history=history+"Open InputStream\n";
                        this.is=s.openInputStream();
                        //this.is=s.getInputStream();
			//System.out.println("begin get OutputStream");
			this.os=s.openOutputStream();
                        //this.os=s.getOutputStream();
                        history=history+"begin dialog:\n";

			// получение приветствия от сервера информации
                        answer=this.read_from_stream(is);
			check_smtp_result(answer);
			//System.out.println(answer);
                        history=history+"\n"+answer+"\n";

                        command="EHLO 127.0.0.1\r\n";
                        //command="EHLO "+s.getLocalAddress()+"\r\n";
                        //command="HELO 127.0.0.1\r\n";
			System.out.println(command);
                        this.write_to_stream(os, command);
			answer=this.read_from_stream(is);
			check_smtp_result(answer);
			//System.out.println(answer);
                        history=history+command+"\n"+answer+"\n";

                        command="AUTH LOGIN\r\n";
			System.out.println(command);
                        this.write_to_stream(os, command);
			answer=this.read_from_stream(is);
			check_smtp_result(answer);
			//System.out.println(answer);
                        history=history+command+"\n"+answer+"\n";

                        // ожидание от сервера запроса ввода имени пользователя 334 VXNlcm5hbWu6
                        while((this.get_smtp_result(answer))!=334){
                            answer=this.read_from_stream(is);
                            check_smtp_result(answer);
                            history=history+command+"\n"+answer+"\n";
                        }
                        //command="dGVjaG5pazdfam9i\r\n";
                        command=(new String(Base64.encode(this.user.getBytes())))+"\r\n";
			System.out.println(command);
                        this.write_to_stream(os, command);
			answer=this.read_from_stream(is);
			check_smtp_result(answer);
			//System.out.println(answer);
                        history=history+command+"\n"+answer+"\n";

                        // ожидание от сервера запроса ввода пароля 334 UGFzc3dvcmQ6
                        while((this.get_smtp_result(answer))!=334){
                            answer=this.read_from_stream(is);
                            check_smtp_result(answer);
                            history=history+command+"\n"+answer+"\n";
                        }

                        //command="c29rb2w3\r\n";
                        command=(new String(Base64.encode(this.password.getBytes())))+"\r\n";
			System.out.println(command);
                        this.write_to_stream(os, command);
			answer=this.read_from_stream(is);
			check_smtp_result(answer);
			//System.out.println(answer);
                        history=history+command+"\n"+answer+"\n";
                        
        
			command="MAIL FROM:<"+From+">\r\n";
			System.out.println(command);
                        this.write_to_stream(os, command);
			answer=this.read_from_stream(is);
			check_smtp_result(answer);
			//System.out.println(answer);
                        history=history+command+"\n"+answer+"\n";

			command="RCPT TO:<"+Recipient+">\r\n";
			System.out.println(command);
                        this.write_to_stream(os, command);
			answer=this.read_from_stream(is);
			check_smtp_result(answer);
			//System.out.println(answer);
                        history=history+command+"\n"+answer+"\n";

			command="DATA\r\n";
			System.out.println(command);
                        this.write_to_stream(os,command);
			answer=this.read_from_stream(is);
			check_smtp_result(answer);
			//System.out.println(answer);
                        history=history+command+"\n"+answer+"\n";

			command=text+"\r\n.\r\n";
                        this.write_to_stream(os,command);
			System.out.println(command);
                        answer=this.read_from_stream(is);
			check_smtp_result(answer);
			//System.out.println(answer);
                        history=history+command+"\n"+answer+"\n";

			/*command="rset\n";
			System.out.println(command);
                        this.write_to_stream(os,command);
			answer=this.read_from_stream(is);
			check_smtp_result(answer);
			//System.out.println(answer);
                        history=history+command+"\n"+answer+"\n";*/

			command="QUIT\r\n";
                        System.out.println(command);
                        this.write_to_stream(os,command);
			answer=this.read_from_stream(is);
			check_smtp_result(answer);
                        history=history+command+"\n"+answer+"\n";

                        ////System.out.println(answer);
                        os.flush();
			is.close();
			os.close();
                        s.close();
			////System.out.println("mail sended");
			this.result_send.setValue(true);		
                        this.history=history;
                    
		}
		catch(Exception e){
                    this.history="run Exception:"+e.getMessage()+"\nHISTORY:"+history;
                    this.result_send.setValue(false);	
                    //System.out.println("Error send mail"+e.getMessage());
			try{
                            if(is!=null){
                                is.close();
                            }
                            if(os!=null){
                                os.close();
                            }
                            if(s!=null){
                                s.close();
                            }
                        }
                        catch(Exception e_inner){
                            //System.out.println("Error in closing stream");
                        }
		}
	}
}

public class mail {
	   private static String convert_char_to_asc(char ch){
		   String result=ch+"";
		   if(ch=='ё')result="yo"+"";
		   if(ch=='є')result="ye"+"";
		   if(ch=='ї')result="yi"+"";
		   if(ch=='А')result="A"+"";
		   if(ch=='Б')result="B"+"";
		   if(ch=='В')result="V"+"";
		   if(ch=='Г')result="G"+"";
		   if(ch=='Д')result="D"+"";
		   if(ch=='Е')result="E"+"";
		   if(ch=='Ж')result="G"+"";
		   if(ch=='З')result="Z"+"";
		   if(ch=='И')result="I"+"";
		   if(ch=='Й')result="Y"+"";
		   if(ch=='К')result="K"+"";
		   if(ch=='Л')result="L"+"";
		   if(ch=='М')result="M"+"";
		   if(ch=='Н')result="N"+"";
		   if(ch=='О')result="O"+"";
		   if(ch=='П')result="P"+"";
		   if(ch=='Р')result="R"+"";
		   if(ch=='С')result="S"+"";
		   if(ch=='Т')result="T"+"";
		   if(ch=='У')result="U"+"";
		   if(ch=='Ф')result="F"+"";
		   if(ch=='Х')result="H"+"";
		   if(ch=='Ц')result="C"+"";
		   if(ch=='Ч')result="CH"+"";
		   if(ch=='Ш')result="SH"+"";
		   if(ch=='Щ')result="SCH"+"";
		   if(ch=='Ъ')result=""+"";
		   if(ch=='Ы')result="Y"+"";
		   if(ch=='Ь')result=""+"";
		   if(ch=='Э')result="E"+"";
		   if(ch=='Ю')result="YU"+"";
		   if(ch=='Я')result="YA"+"";
		   if(ch=='а')result="a"+"";
		   if(ch=='б')result="b"+"";
		   if(ch=='в')result="v"+"";
		   if(ch=='г')result="g"+"";
		   if(ch=='д')result="d"+"";
		   if(ch=='е')result="e"+"";
		   if(ch=='ж')result="g"+"";
		   if(ch=='з')result="z"+"";
		   if(ch=='и')result="i"+"";
		   if(ch=='й')result="y"+"";
		   if(ch=='к')result="k"+"";
		   if(ch=='л')result="l"+"";
		   if(ch=='м')result="m"+"";
		   if(ch=='н')result="n"+"";
		   if(ch=='о')result="o"+"";
		   if(ch=='п')result="p"+"";
		   if(ch=='р')result="r"+"";
		   if(ch=='с')result="s"+"";
		   if(ch=='т')result="t"+"";
		   if(ch=='у')result="u"+"";
		   if(ch=='ф')result="f"+"";
		   if(ch=='х')result="h"+"";
		   if(ch=='ц')result="c"+"";
		   if(ch=='ч')result="ch"+"";
		   if(ch=='ш')result="sh"+"";
		   if(ch=='щ')result="sch"+"";
		   if(ch=='ъ')result=""+"";
		   if(ch=='ы')result="y"+"";
		   if(ch=='ь')result=""+"";
		   if(ch=='э')result="e"+"";
		   if(ch=='ю')result="yu"+"";
		   if(ch=='я')result="ya"+"";
		   if(ch=='Ґ')result="Ga"+"";
		   if(ch=='Ё')result="E"+"";
		   if(ch=='Є')result="E"+"";
		   if(ch=='Ї')result="YI"+"";
		   if(ch=='і')result="yi"+"";
		   if(ch=='ґ')result="ga"+"";
		   if(ch=='Ґ')result="Ga"+"";
		   if(ch=='Ё')result="E"+"";
		   if(ch=='Є')result="E"+"";
		   return result;
	   }
	   public static String convert_string_to_asc_string(String s){
		   String result="";
		   for(int i=0;i<s.length();i++){
			   result=result+convert_char_to_asc(s.charAt(i));
		   }
		   return result;
	   }
    public boolean flag_send_mail=false;
    public String login="technik7job";
    public String password="xxxxx";
    public String smtp="smtp.rambler.ru";
    //public String smtp="smtp.jeans.ua";
    public String address_source="technik7job@rambler.ru";
    public String address_destination="bagsmainserver@rambler.ru";
    
    /** Creates a new instance of mail */
    public mail(String text_for_send,MIDlet this_midlet,Displayable this_form) {
        boolean_package result_send_mail=new boolean_package(false);
        string_package trace=new string_package("");
        
        //new send_mail("technik7_job","xxxxx","smtp.mail.ru", 25, "technik7_job@mail.ru" ,"technik7_job@mail.ru", text_for_send,result_send_mail,trace);
        //new send_mail("bags_client_1","guest_1","smtp.mail.ru",25,"bags_client_1@mail.ru","bags_main_server@mail.ru",text_for_send,result_send_mail,trace);
        new send_mail(login,password,smtp,25,address_source,address_destination,
                      text_for_send,
                      result_send_mail,
                      trace);
        if(result_send_mail.getValue()){
            ////System.out.println("mail sended:\n"+trace.getValue());
            //System.out.println("mail sended:\n");
            //Alert temp_alert=new Alert("Mail","sended",null,AlertType.INFO);
            //temp_alert.setTimeout(Alert.FOREVER);
            //Display display=Display.getDisplay(this_midlet);
            //display.setCurrent(temp_alert,this_form);
            this.flag_send_mail=true;
        }
        else{
            // error send mail
            //System.out.println("mail not send:\n");
            //Alert temp_alert=new Alert("Mail","ERROR sended mail "+trace.getValue(),null,AlertType.INFO);
            //temp_alert.setTimeout(Alert.FOREVER);
            //Display display=Display.getDisplay(this_midlet);
            //display.setCurrent(temp_alert,this_form);
            this.flag_send_mail=false;
        }

    }
    /**
     * @param text_for_send  текст для отправки
     * @param this_midlet ссылка на MIDlet 
     * @param this_form ссылка на Displayable
     * @param string_package оболочка для сохранения данных
     */
    public mail(String text_for_send,MIDlet this_midlet,Displayable this_form,string_package trace) {
        boolean_package result_send_mail=new boolean_package(false);
        
        //new send_mail("technik7_job","xxxxx","smtp.mail.ru", 25, "technik7_job@mail.ru" ,"technik7_job@mail.ru", text_for_send,result_send_mail,trace);
        //new send_mail("bags_client_1","guest_1","smtp.mail.ru",25,"bags_client_1@mail.ru","bags_main_server@mail.ru",text_for_send,result_send_mail,trace);
        new send_mail(login,password,smtp,25,address_source,address_destination,
                      text_for_send,
                      result_send_mail,
                      trace);
        if(result_send_mail.getValue()){
            ////System.out.println("mail sended:\n"+trace.getValue());
            //System.out.println("mail sended:\n");
            //Alert temp_alert=new Alert("Mail","sended",null,AlertType.INFO);
            //temp_alert.setTimeout(Alert.FOREVER);
            //Display display=Display.getDisplay(this_midlet);
            //display.setCurrent(temp_alert,this_form);
            this.flag_send_mail=true;
        }
        else{
            // error send mail
            //System.out.println("mail not send:\n");
            //Alert temp_alert=new Alert("Mail","ERROR sended mail "+trace.getValue(),null,AlertType.INFO);
            //temp_alert.setTimeout(Alert.FOREVER);
            //Display display=Display.getDisplay(this_midlet);
            //display.setCurrent(temp_alert,this_form);
            this.flag_send_mail=false;
        }

    }
    
}
