/*
 * ComController_shell_StringItem.java
 *
 * Created on 17 Октябрь 2007 г., 12:57
 *
 * To change this template, choose Tools | Template Manager
 * and open the template in the editor.
 */

package main_package;

import javax.microedition.lcdui.Alert;
import javax.microedition.lcdui.Display;
import javax.microedition.lcdui.Displayable;
import javax.microedition.lcdui.StringItem;

/**
 *
 * @author root
 * Класс, который отображает, добавляет, редактирует данные которые были получены из ComListener, или ручного ввода,
 * затем, возможно, отредактированы, сохранены и отображены на StringItem
 * и сохранение этих данных в DataStore (сохраняем в ячейке хранилища под номером 1)
 */
public class ComController_shell_StringItem implements ComListener{
    private StringItem stringitem=null;
    private TStore store=null;
    private int main_record_id=1;// начиются ID в DataStore с 1
    private String string_from_port="";
    public int counter=0;// переменная, на основании которой строки в StringItem имеют определенный номер
    private boolean flag_open=false;
    private ComController comcontroller=null;
    private Display display=null;
    private Displayable parent_displayable=null;
    private String preambule=":<";
    private String postambule=">:";
    private boolean flag_open_recordstore=false;
    private boolean flag_open_com_port=false;
    /** Creates a new instance of ComController_shell_StringItem */
    public ComController_shell_StringItem(Display this_display,Displayable this_parent_displayable,StringItem this_stringitem,String store_name) {
        this.stringitem=this_stringitem;
        this.store=new TStore(store_name);
        this.display=this_display;
        this.parent_displayable=this_parent_displayable;
    }
    /**
     * Открытие данных для чтения из хранилища
     */
    public void open(){
        this.flag_open_recordstore=false;
        this.flag_open_com_port=false;
        try{
            this.store.openRecordStore(" ");
            this.read_data_from_store_and_display_to_StringItem();
            this.flag_open_recordstore=true;
            //System.out.println("Хранилище открыто");
        }
        catch(Exception e){
            //System.out.println("Хранилище не открыто");
        }
        try{
            this.comcontroller=new ComController(this.display,this.parent_displayable,"com0",9600,this);
            this.comcontroller.com_open();
            this.flag_open_com_port=true;
            //System.out.println("COM порт открыт");
        }
        catch(Exception e){
            //System.out.println(" Error in open com port");
        }
        this.flag_open=this.flag_open_recordstore;
    }
    
    /**
     * Проверка на открытые данные
     */
    public boolean isOpen(){
        return flag_open;
    }
    /**
     * Закрытие хранилища с данными
     */
    public void close(){
        if(this.isOpen()){
            if(this.flag_open_recordstore){
                this.store.closeRecordStore();
                this.flag_open_recordstore=false;
                //System.out.println("Хранилище закрыто");
            }
            if(this.flag_open_com_port){
                this.comcontroller.com_close();
                this.flag_open_com_port=false;
                //System.out.println("Порт закрыт");
            }
            this.flag_open=false;
        }
    }
    /**
     * Прочитать данные из хранилища и отобразить эти данные на StringItem
     */
    public void read_data_from_store_and_display_to_StringItem(){
        String temp_string="";
        temp_string=this.store.get_data_by_id(this.main_record_id);
        //System.out.println("Данные прочитанные из хранилища:"+temp_string);
        if((temp_string!=null)&&( !(temp_string.trim().equals("")) )){
            // поиск :< >: в строке
            int index_begin=temp_string.indexOf(this.preambule);
            int index_end=temp_string.indexOf(this.postambule);
            this.counter=Integer.valueOf(temp_string.substring(index_begin+2,index_end)).intValue();
            //System.out.println("Counter:"+this.counter);
        }
        else {
            // данных нет - начальное значение для счетчика
            this.counter=0;
            temp_string="";
            //System.out.println("Нет данных для отображения");
        }
        this.stringitem.setText("\n"+temp_string);
    }
    /**
     * Прочитать данные из хранилища
     */
    public String read_data_from_store(){
        String temp_string="";
        temp_string=this.store.get_data_by_id(this.main_record_id);
        if((temp_string!=null)&&(!(temp_string.trim().equals(""))) ){
            // поиск :< >: в строке
            int index_begin=temp_string.indexOf(this.preambule);
            int index_end=temp_string.indexOf(this.postambule);
            //System.out.println("index begin: "+index_begin+" index_end:"+index_end+" temp_string=["+temp_string+"]");
            this.counter=Integer.valueOf(temp_string.substring(index_begin+2,index_end)).intValue();
            //System.out.println("данные прочитаны "+temp_string+" назначен counter="+this.counter);
        }
        else {
            // данных нет - начальное значение для счетчика
            this.counter=0;
            temp_string="";
            //System.out.println("нет данных для чтения");
        }
        return temp_string;
    }
    /**
     * Записать данные в хранилище
     */
    public void write_data_to_store(String value){
        //System.out.println("Запись данных в хранилище: "+value);
        this.store.set_to_store(this.main_record_id,value);
    }
    /**
     * Добавить данные к хранилищу
     */
    public void add_data_to_store(String value) throws Exception{
        // узнать о свободном месте в хранилище
        if(this.store.get_free_memory()>value.length()){
            // получить данные из хранилища
            // прибавить строку (в начало)
            // записать данные в хранилище
            String temp_string=this.read_data_from_store();
            this.counter++;
            this.write_data_to_store(this.preambule+this.counter+this.postambule+value+"\n"+temp_string);
        }
        else {
            throw new Exception("memory FULL");
        }
    }
    /**
     * удалить запись из данных, которые лежат в хранилище
     * удаляем запись, которая находится выше всех, запись находится между (":<")(":<")?
     */
    public void delete_last_position_from_data(){
        String temp_string=this.read_data_from_store();
        if((temp_string!=null)&&( !(temp_string.trim().equals("")) )){
            int index_begin=temp_string.indexOf(this.preambule);
            int index_end=temp_string.indexOf(this.preambule,index_begin+1);
            if((index_begin>=0)&&(index_end>=0)){
                // записываем данные без начальной строки
                this.write_data_to_store(temp_string.substring(index_end));
            }
            if((index_begin>=0)&&(index_end<0)){
                //строка является единственной для данной записи
                this.write_data_to_store("");
            }
        }
        else {
            //System.out.println("прочитана пустая строка - нет данных для удаления");
        }
    }

    /**
     * удалить запись из данных, которые лежат в хранилище
     * удаляем запись, номер которой находится между (":<"+record_id+">:")(":<")?
     */
    public void delete_number_from_data(int record_id){
        // есть ли данная запись
        String temp_string=this.read_data_from_store();
        String find_string=this.preambule+record_id+this.postambule;
        //System.out.println("find string="+find_string);
        int index_begin=temp_string.indexOf(this.preambule+record_id+this.postambule);
        int index_end=temp_string.indexOf(this.preambule,index_begin+1);
        //System.out.println(" index_begin:"+index_begin+"  index_end:"+index_end);
        if((index_begin>=0)&&(index_end>=0)){
            String head=temp_string.substring(0,index_begin);
            String tail=temp_string.substring(index_end);
            //System.out.println("delete_id_from_data запись найдена удаление \n head:"+head+"\n tail:"+tail);
            this.write_data_to_store(head+tail);
        }
        if((index_begin>=0)&&(index_end<=0)){
            // запись найдена и она единственная в списке
            this.write_data_to_store(temp_string.substring(0,index_begin));
            //System.out.println("delete_id_from_data запись найдена и она единственная в списке");
        }
    }
    public void delete_number_from_data(String record_id){
        try{
            int temp_int=Integer.valueOf(record_id).intValue();
            this.delete_number_from_data(temp_int);
        }
        catch(Exception e){
            //System.out.println("Error in convert String to Integer");
        }
    }
    
    /*
     * Данные которые получены с порта компьютера
     */
    public void data_from_port(String s) {
        // добавить строку к переменной для объекта, в которой хранится часть строки
        this.string_from_port=this.string_from_port+s;
        // проанализировать строку на наличие в ней символа окончания 0x0d
        if(this.string_from_port.indexOf(0x0d)>0){
            try{
                // символ окончания посылки 0x0d найден - добавить данные в хранилище, отобразить на экране
                this.add_data_to_store(this.string_from_port.substring(0,this.string_from_port.indexOf(0x0d)));
                // отображаем символ на экране
                this.read_data_from_store_and_display_to_StringItem();
            }
            catch(Exception e){
                this.display.setCurrent(new Alert(e.getMessage()),this.parent_displayable);
            }
            // проверка на последний символ в строке 0x0d
            if(this.string_from_port.length()==(this.string_from_port.indexOf(0x0d)+1)){
                // символ перевода каретки последний - очистка строки
                this.string_from_port="";
            }
            else {
                // символ перевода строки не последний - есть еще данные
                this.string_from_port=this.string_from_port.substring(this.string_from_port.indexOf(0x0d)+1,this.string_from_port.length()-1);
            }
        }
        
    }
    
}
