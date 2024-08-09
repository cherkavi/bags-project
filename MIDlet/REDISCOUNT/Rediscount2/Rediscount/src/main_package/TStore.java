/*
 * TStore.java
 *
 * Created on 7 Октябрь 2007 г., 9:12
 *
 * To change this template, choose Tools | Template Manager
 * and open the template in the editor.
 */

package main_package;

import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.DataInputStream;
import java.io.DataOutputStream;
import javax.microedition.rms.InvalidRecordIDException;
import javax.microedition.rms.RecordEnumeration;
import javax.microedition.rms.RecordStore;
import javax.microedition.rms.RecordStoreException;
import javax.microedition.rms.RecordStoreFullException;
import javax.microedition.rms.RecordStoreNotFoundException;
import javax.microedition.rms.RecordStoreNotOpenException;

/**
 *
 * @author root
 */
public class TStore{
    private RecordStore recordStore;
    protected String store_name=new String("");
    /**
     * получение свободного пространства для хранилища данных
     */
    public int get_free_memory(){
        int result=-1;
        try{
            result=this.recordStore.getSizeAvailable();
        }
        catch(Exception e){
            //System.out.println("Store is not open");
        }
        return result;
    }
    /**
     * Получение данных (записи) из хранилища по ее уникальному ID
     */
    public String get_data_by_id(int record_id){
        String result="";
        try{        
            ByteArrayInputStream bais=new ByteArrayInputStream(this.recordStore.getRecord(record_id));
            DataInputStream dis=new DataInputStream(bais);
            result=dis.readUTF();
            //System.out.println("Data from DataStore by number="+record_id+"  Data:"+result);
        }
        catch(Exception e){
            //System.out.println("Error TStore.get_data_by_id:"+e.getMessage());
        }
        return result;
    }
    
    /**
     *  Удаление всех записей по имени
     */
    public static boolean delete_store_by_name(String store_name){
        boolean result=false;
        try{
            javax.microedition.rms.RecordStore.deleteRecordStore(store_name);
            result=true;
        }
        catch(RecordStoreNotFoundException e){
            result=true;
        }
        catch(RecordStoreFullException e){
            result=false;
        }
        catch(RecordStoreException e){
            result=false;
        }
        catch(Exception e){
            result=false;
        }
        return result;
    }
    /**
     * флаг показывает для других частей класса, открыто ли хранилище данных
     */
    protected boolean store_is_open=true;
    /**
     * В качестве аргумента конструктора передаем имя хранилища данных, в котором будем хранить наши данные
     */
    TStore(String store_name){
        this.store_name=store_name;
    }
    /**
     *Открытие хранилища, имя которго было задано, если его нет - создаем
     */
    public boolean openRecordStore(){
        try{
            //RecordStore.deleteRecordStore(this.store_name);
            this.recordStore=RecordStore.openRecordStore(this.store_name,true);
            this.store_is_open=true;
            ////System.out.println("Хранилище открыто");
        }
        catch(javax.microedition.rms.RecordStoreException e){
            ////System.out.println("Не могу открыть хранилище");
            this.store_is_open=false;
        }
        return this.store_is_open;
    }
    /**
     * Открытие хранилища, проверка на существование, и если хранилище только создано - тогда запись в первую ячейку постую строку
     */
    public boolean openRecordStore(String string_for_write){
        this.store_is_open=false;
        try{
            this.recordStore=RecordStore.openRecordStore(this.store_name,false);
            this.store_is_open=true;
        }
        catch( RecordStoreNotFoundException e){
            try{
                this.recordStore=RecordStore.openRecordStore(this.store_name,true);
                this.add_to_store(string_for_write);
                this.store_is_open=true;
            }
            catch(Exception e2){
                //System.out.println("Ошибка при попытке создания нового хранилища");
            }
            //System.out.println("- if the record store could not be found ");
        } 
        catch( RecordStoreFullException e){ 
            //System.out.println("- if the operation cannot be completed because the record store is full ");
        } 
        catch( IllegalArgumentException e){ 
            //System.out.println("- if recordStoreName is invalid ");
        }        
        catch(RecordStoreException e){
            //System.out.println("- if a record store-related exception occurred ");
        }
        
        return this.store_is_open;
    }
    /**
     * Закрытие хранилища
     */
    public boolean closeRecordStore(){
        boolean result=false;
        if(this.store_is_open){
            try{
                this.recordStore.closeRecordStore();
                result=true;
                ////System.out.println("Хранилище закрыто");
            }
            catch(Exception e){
                result=false;
            }
        }
        else {
            result=false;
        }
        return result;
    }
    /**
     * Получение всех записей по данному хранилищу в виде String[]
     */
    public String[] get_list_store(){
        String[] temp_array=null;
        if(this.store_is_open){
            try {
                javax.microedition.rms.RecordEnumeration recordenumeration=this.recordStore.enumerateRecords(null,null,false);
                //recordenumeration.reset();
                //recordenumeration.rebuild();
                temp_array=new String[this.get_store_count()];
                int record_counter=0;
                while(recordenumeration.hasNextElement()){
                    try{
                        ByteArrayInputStream bais=new ByteArrayInputStream(recordenumeration.nextRecord());
                        DataInputStream dis=new DataInputStream(bais);
                        temp_array[record_counter]=dis.readUTF();
                        record_counter++;
                        ////System.out.println("Следующий элемент прочитан "+record_counter);
                    }
                    catch(Exception e){
                        // ошибка считывания текущей записи
                        ////System.out.println("ошибка считывания текущей записи "+e.getMessage());
                    }
                }
            } catch (Exception ex) {
                // ошибка при считывании данных
                //System.out.println("ошибка при считывании данных");
            }
        }
        return temp_array;
    }
    /**
     * Получение количества записей в хранилище
     */
    public int get_store_count(){
        int result=0;
        if(this.store_is_open){
            try{
                result=this.recordStore.getNumRecords();
                ////System.out.println("Всего прочитано записей "+result);
            }        
            catch(Exception e){
                result=0;
            }
        }
        else {
            result=0;
        }
        return result;
    }
    /**
     * Сохраняет строку в формате UTF и возвращает номер записи в хранилище, ее уникальный ID
     */
    public int add_to_store(String source){
        int result=0;
        ByteArrayOutputStream baos=new ByteArrayOutputStream();
        DataOutputStream dos=new DataOutputStream(baos);
        try{
            dos.writeUTF(source);
            result=this.recordStore.addRecord(baos.toByteArray(),0,baos.toByteArray().length);
            ////System.out.println("Запись добавлена к хранилищу");
        }
        catch(Exception e){
            ////System.out.println("Ошибка добавления данных");
            return 0;
        }
        return result;
    }
    
    /**
     * установка значения в RMS (замена значения по заданному номеру - перезапись)
     */
    public boolean set_to_store(int position,String source){
        boolean result=false;
        ByteArrayOutputStream baos=new ByteArrayOutputStream();
        DataOutputStream dos=new DataOutputStream(baos);
        try{
            /*//System.out.println("Попытка изменить данные в хранилище по номеру:"+position+" из возможных позиций: "+this.get_store_count());
            // запись в первую ячейку?
            if(position==1){
                // если записей нет, тогда возможен вариант, когда запись производится впервые - удалить хранилище и добавить данные
                if(this.get_store_count()==0){
                    
                }
                //удаляем данный dataStore и открываем снова
            }
            if(this.get_store_count()>0){
                RecordEnumeration recordenumeration=this.recordStore.enumerateRecords(null,null,false);
                while(recordenumeration.hasNextElement()){
                    //System.out.println(">>>"+recordenumeration.nextRecordId());
                }
                recordenumeration.reset();
                while(recordenumeration.hasNextElement()){
                    //System.out.println("}}}"+recordenumeration.nextRecord());
                }
            }*/
            dos.writeUTF(source);
            this.recordStore.setRecord(position,baos.toByteArray(),0,baos.toByteArray().length);
            //System.out.println("Запись изменена в позиции "+position);
            result=true;
        }
        catch(RecordStoreNotOpenException e){
            //System.out.println("- if the record store is not open");
        } 
        catch(InvalidRecordIDException e){
            //System.out.println("- if the recordId is invalid");
        } 
        catch(RecordStoreException e){
            //System.out.println("- if a general record store exception occurs");
        } 
        catch(ArrayIndexOutOfBoundsException e){
            //System.out.println("- if the record is larger than the buffer supplied");
        }        
        catch(Exception e){
            // в хранилище еще ничего не записано - попытка добавить, а не перезаписать запись
            /*if(e.getMessage()==null){
                try{
                    dos.writeUTF(source);
                    this.recordStore.addRecord(baos.toByteArray(),0,baos.toByteArray().length);
                    result=true;
                    //System.out.println("Запись добавлена в хранилище");
                }
                catch(Exception e2){
                    //System.out.println("не удалось создать запись в хранилище "+e2.getMessage());
                }
            }*/
            //System.out.println("Ошибка изменения данных "+e.getMessage());
        }
        return result;
    }
    /**
     *Удаление из хранилища по уникальному номеру
     */
    public boolean delete_from_store_by_id(int index){
       boolean result=true;
       try{
           if(this.store_is_open){
              javax.microedition.rms.RecordEnumeration recordenumeration=this.recordStore.enumerateRecords(null,null,false);
              while(recordenumeration.hasNextElement()){
                 if(recordenumeration.nextRecordId()==index){
                    try{
                        ////System.out.println("Delete from store by Index="+index);
                        this.recordStore.deleteRecord(index); // запись удалена
                        result=false;// будет изменено на true
                        ////System.out.println("Данные удалены");
                        break;
                    }
                    catch(Exception e){
                        //не удалось удалить запись
                        ////System.out.println("Ошибка удаления записи из хранилища");
                        break;
                    }
                 }
                 else{
                     // continue find RecordID
                 }
              }
           result=!result;
           }
           else {
               // RecordStore is not Open
               result=false;
           }
       }
       catch(Exception e){
           // ошибка при удалении данных
           result=false;
           ////System.out.println("Ошибка удаления данных");
       }
       return result;
    }
    /**
     * Получение ID записи, имея данные, которые были прочитаны из хранилища - для редактирования, когда
     * известны данные, но не известно точное расположение записи
     */
    public int get_recordid_by_recorddata(String source){
        int result=-1;
        if(this.store_is_open){
            try {
                javax.microedition.rms.RecordEnumeration recordenumeration=this.recordStore.enumerateRecords(null,null,false);
                // получение всех индексов для элементов
                int[] index_of_enumeration=new int[this.recordStore.getNumRecords()];
                for(int i=0;i<index_of_enumeration.length;i++){
                    index_of_enumeration[i]=recordenumeration.nextRecordId();
                }
                recordenumeration.reset();
                for(int i=0;i<index_of_enumeration.length;i++){
                    try{
                        ByteArrayInputStream bais=new ByteArrayInputStream(recordenumeration.nextRecord());
                        DataInputStream dis=new DataInputStream(bais);
                        String read_string=dis.readUTF();
                        ////System.out.println(" compare store:"+read_string+" <->   from_screen:"+source);
                        if(read_string.equalsIgnoreCase(source)){
                            ////System.out.println(source+" index of ="+index_of_enumeration[i]);
                            result=index_of_enumeration[i];
                            break;
                        };
                    }
                    catch(Exception e){
                        // ошибка считывания текущей записи
                        ////System.out.println("ошибка считывания текущей записи"+e.getMessage());
                    }
                    
                }
            } catch (Exception ex) {
                // ошибка при считывании данных
                ////System.out.println("ошибка при считывании данных");
            }
        }
        else{
            ////System.out.println(" Store is not open");
        }
        return result;
    }
    /**
     * Получение информации о состоянии хранилища - объекта
     */
    public boolean isOpen(){
        return this.store_is_open;
    }
    /**
     * Получение названия хранилища
     */
    public String get_store_name(){
        return this.store_name;
    }
    /**
     * Установка имени хранилища
     */
    public boolean set_store_name(String new_store_name){
        boolean result=false;
        if(this.store_is_open==true){
            result=false;
        }
        else{
            this.store_name=new_store_name;
            result=true;
        }
        return result;
    }
    /**
     * Удаление из хранилища, используя имя(значение) элемента из этого хранилища
     */
    public boolean delete_from_store_by_name(String name_for_delete){
        boolean result=false;
        int temp_int=this.get_recordid_by_recorddata(name_for_delete);
        if(temp_int>=0){
            //System.out.println("Element deleted "+name_for_delete);
            this.delete_from_store_by_id(temp_int);
            result=true;
        }
        else {
            //System.out.println(" Element not deleted : "+name_for_delete);
            result=false;
        }
    return result;    
    }
            
}
