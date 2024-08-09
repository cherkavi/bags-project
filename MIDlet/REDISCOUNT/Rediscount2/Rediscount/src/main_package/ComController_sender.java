/*
 * ComController_sender.java
 *
 * Created on 19 березня 2008, 7:21
 *
 * To change this template, choose Tools | Template Manager
 * and open the template in the editor.
 */

package main_package;

import javax.microedition.io.*;
import java.io.*;
import javax.microedition.lcdui.*;

/**
 * Служи для отправки данных в COM порт
 */
public class ComController_sender implements Runnable{
    private CommConnection com=null;
    private InputStream com_inputstream=null;
    private OutputStream com_outputstream=null;
    private volatile boolean flag_run=false;
    private Displayable parent_display=null;
    private Display display=null;
    private String com_port_name=null;
    private Thread main=null;
    private int baudrate=9600;
    private String message_for_send;
    /** флаг, который указывает на положительную передачу данных в порт*/
    public boolean flag_do_work=false;
    /** Creates a new instance of ComController_sender 
     * @param this_display
     * @param this_paren_display
     * @param port_name
     * @param this_baudrate
     * @param for_send_to_com
     */
    public ComController_sender (
                                Display this_display,
                                Displayable this_parent_display,
                                String port_name,
                                int this_baudrate,
                                String for_send_to_com
                                ) {
        
        this.display=this_display;
        this.parent_display=this_parent_display;
        this.com_port_name=port_name;
        this.baudrate=this_baudrate;
        this.message_for_send=new String(for_send_to_com);
        System.out.println("установка экрана как текущего");
    }
    /**  отправка данных в порт */
    public boolean send(){
        boolean return_value=false;
        try{
            this.flag_do_work=false;
            this.main=new Thread(this);
            this.main.start();
            this.main.join();
            return_value=this.flag_do_work;
        }catch(Exception e){
            return_value=false;
        }
        return return_value;
    }
    /**  рабочий метод, который отправляет данных*/
    public void run() {
        try{
            this.flag_run=true;
            // открыть порт
            this.com_open();
            // записать данных
            this.com_outputstream.write("[BEGIN]".getBytes());
            this.com_outputstream.flush();
            if(this.message_for_send!=null){
                int step=20;
                byte[] array_of_byte=this.message_for_send.getBytes();
                int max_counter=this.message_for_send.length();
                //this.com_outputstream.write( ((String)("length array:"+max_counter)).getBytes());
                // первый байт не передаем - передает сразу целый блок, а потом начинает передавать по элементам
                for(int counter=1;counter<max_counter;counter++){
                    this.com_outputstream.write(array_of_byte,counter,1);
                    //this.com_outputstream.write( ((String)("\n "+counter+"/"+max_counter+"\n")).getBytes());
                    // обязательная задержка - иначе не передает весь пакет
                    Thread.sleep(1);
                }
                //this.com_outputstream.write(this.message_for_send.getBytes());
            }
            this.com_outputstream.write("[END]".getBytes());

            this.flag_do_work=true;
        }catch(Exception e){
            this.flag_do_work=false;
        }
        finally{
            // закрыть поток
            this.com_close();
        }
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
            }
            catch(Exception e){
                //this.StringItem_data.setText(this.StringItem_data.getText()+"\n Init Error:"+e.getMessage());
                //System.out.println("Error in open com port");
                //this.show_alert(this.com_port_name+"("+this.baudrate+") port open Error",e.getMessage(),AlertType.ERROR,1500);
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
        try{
            if(this.com_inputstream!=null){
                com_inputstream.close();
            }
        }
        catch(Exception e){
        };
        try{
            if(this.com_outputstream!=null){
                this.com_outputstream.flush();
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
   }; 
    
}
