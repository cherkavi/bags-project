/*
 * ComController.java
 *
 * Created on 9 ќкт€брь 2007 г., 7:24
 *
 * To change this template, choose Tools | Template Manager
 * and open the template in the editor.
 */

package get_data_from_com;

import javax.microedition.io.*;
import java.io.*;
import javax.microedition.lcdui.Alert;
import javax.microedition.lcdui.AlertType;
import javax.microedition.lcdui.Display;
import javax.microedition.lcdui.Form;
import javax.microedition.midlet.MIDlet;

/**
 *
 * @author root
 */
public class ComController implements Runnable{
    private CommConnection com=null;
    private InputStream com_inputstream=null;
    private OutputStream com_outputstream=null;
    private volatile boolean flag_run=false;
    private MIDlet midlet=null;
    private Form form=null;
    private String com_port_name=null;
    private Thread main=null;
    private ComListener com_listener;
    private int baudrate=9600;
    /** конструктор дл€ класса чтени€ данных из порта */
    public ComController(MIDlet this_midlet,Form this_form,String port_name,int this_baudrate,ComListener this_com_listener) {
        this.midlet=this_midlet;
        this.form=this_form;
        this.com_port_name=port_name;
        this.com_listener=this_com_listener;
        this.baudrate=this_baudrate;
    }
    
    public void com_open(){
        if(this.com==null){
            try{
                this.com=(CommConnection)Connector.open("comm:"+this.com_port_name+";baudrate="+baudrate);
                this.com_inputstream=this.com.openInputStream();
                this.com_outputstream=this.com.openOutputStream();
                main=new Thread(this);
                this.flag_run=true;
                main.start();
            }
            catch(Exception e){
                //this.StringItem_data.setText(this.StringItem_data.getText()+"\n Init Error:"+e.getMessage());
                System.out.println("Error in open com port");
                this.show_alert(this.midlet,this.form,this.com_port_name+"("+this.baudrate+") port open Error",e.getMessage(),AlertType.ERROR,1500);
            }
        }
    }
    synchronized public void com_close() {
        this.flag_run=false;
        Thread.yield();
        Thread.yield();
        try{
            if(this.com_inputstream!=null){
                com_inputstream.close();
            }
        }
        catch(Exception e){
        };
        try{
            if(this.com_outputstream!=null){
                this.com_outputstream.close();
            }
        }
        catch(Exception e){
        };
        try{
            if(this.com!=null){
                this.com.close();
            }
        }
        catch(Exception e){
        };
        System.gc();
    }
    public void show_alert(MIDlet current_midlet, Form current_form,String title, String text,AlertType alerttype,int milisecond){
        Alert temp_alert=null;
        temp_alert=new Alert(title,text,null,alerttype);
        if(milisecond>0){
            temp_alert.setTimeout(milisecond);
        }
        Display display=Display.getDisplay(current_midlet);
        display.setCurrent(temp_alert,current_form);
   } 
    synchronized public void stop(){
        this.flag_run=false;
        Thread.yield();
        this.show_alert(this.midlet,this.form,"COM listener","stop read from COM",AlertType.INFO,1500);
    }
    public void run() {
        int error_counter=0;
        while(this.flag_run==true){
            try{
                if(this.com_inputstream.available()>0){
                    byte[] temp_byte=new byte[com_inputstream.available()];
                    this.com_inputstream.read(temp_byte);
                    this.com_listener.data_from_port(new String(temp_byte));
                }
            }
            catch(Exception e){
                // error in read from port
                error_counter++;
                if(error_counter==10){
                    this.show_alert(this.midlet,this.form,"COM port ERROR read",e.getMessage(),AlertType.ERROR,1500);
                    break;
                }
            }
        }
        this.com_close();
        this.show_alert(this.midlet,this.form,"COM port CLOSE","end run com listener",AlertType.INFO,1500);
    }
    
}
