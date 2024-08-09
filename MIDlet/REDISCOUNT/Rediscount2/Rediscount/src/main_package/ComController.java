/*
 * ComController.java
 *
 * Created on 9 Октябрь 2007 г., 7:24
 *
 * To change this template, choose Tools | Template Manager
 * and open the template in the editor.
 */

package main_package;

import javax.microedition.io.*;
import java.io.*;
import javax.microedition.lcdui.Alert;
import javax.microedition.lcdui.AlertType;
import javax.microedition.lcdui.Display;
import javax.microedition.lcdui.Displayable;
import javax.microedition.lcdui.Form;
import javax.microedition.midlet.MIDlet;

/**
 *
 * @author root
 * Класс, который берет данные из порта, выдает предупреждения и сообщения об ошибках,
 * и данные передает в интерфейс ComListener
 */
public class ComController implements Runnable{
    private CommConnection com=null;
    private InputStream com_inputstream=null;
    private OutputStream com_outputstream=null;
    private volatile boolean flag_run=false;
    private Displayable parent_display=null;
    private Display display=null;
    private String com_port_name=null;
    private Thread main=null;
    private ComListener com_listener;
    private int baudrate=9600;
    /**
     *  конструктор для класса чтения данных из порта в который мы передаем:
     *  Display - окно, на котором нужно будет отображать информацию
     *  родительское окно, на основании которого будут отображаться сообщения (родительское окно для модального окна)
     *  имя порта 
     *  скорость по которой будем соединяться
     *  объект, класс которого реализует интерфейс ComListener
     */
    public ComController(Display this_display,Displayable this_parent_display,String port_name,int this_baudrate,ComListener this_com_listener) {
        this.display=this_display;
        this.parent_display=this_parent_display;
        this.com_port_name=port_name;
        this.baudrate=this_baudrate;
        this.com_listener=this_com_listener;        
    }
    
    /*
     * Открытие порта, и запуск отдельной нити для отслеживания данных и вызова ComListener при считывании данных из порта
     */
    public void com_open() throws Exception{
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
                //System.out.println("Error in open com port");
                this.show_alert(this.com_port_name+"("+this.baudrate+") port open Error",e.getMessage(),AlertType.ERROR,1500);
                throw new Exception("Error in open com port");
            }
        }
    }
    /*
     * Закрытие порта, для того чтобы при последующей инициализации можно было бы открыть и проинициализировать порт
     */
    synchronized public void com_close() {
        this.flag_run=false;
        //Thread.yield();
        //Thread.yield();
        // ожидание завершения
        try {
            this.main.join();
        } catch (InterruptedException ex) {
            ex.printStackTrace();
        }
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
    /*
     * Показать модальное окно-сообщение на основании
     * родительского окна, заголовка, текста, типа сообщения и времени его отображения
     */
    public void show_alert(String title, String text,AlertType alerttype,int milisecond){
        Alert temp_alert=null;
        temp_alert=new Alert(title,text,null,alerttype);
        if(milisecond>0){
            temp_alert.setTimeout(milisecond);
        }
        
        this.display.setCurrent(temp_alert,this.parent_display);
   } 
    /*
     * Остановка нити потока, который был запущен для слушания порта
     */
    synchronized public void stop(){
        this.flag_run=false;
        Thread.yield();
        //this.show_alert("COM listener","stop read from COM",AlertType.INFO,1500);
    }
    /*
     * тело исполняющей нити потока, которая слушает порт и вызывает интерфейс ComListener
     */
    public void run() {
        int error_counter=0;
        while(this.flag_run==true){
            try{
                if(this.com_inputstream.available()>0){
                    byte[] temp_byte=new byte[com_inputstream.available()];
                    this.com_inputstream.read(temp_byte);
                    //this.com_listener.data_from_port(temp_byte.toString());
                    this.com_listener.data_from_port(new String(temp_byte));
                }
            }
            catch(Exception e){
                // error in read from port
                error_counter++;
                if(error_counter==10){
                    this.show_alert("COM port ERROR read",e.getMessage(),AlertType.ERROR,1500);
                    break;
                }
            }
        }
        //this.show_alert("COM port CLOSE","end run com listener",AlertType.INFO,1500);
    }
    
}
