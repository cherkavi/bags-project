/*
 * TStore_shell_List.java
 *
 * Created on 16 Октябрь 2007 г., 12:07
 *
 * To change this template, choose Tools | Template Manager
 * and open the template in the editor.
 */

package main_package;

import javax.microedition.lcdui.List;

/**
 * @author root
 * Это класс-обертка для TStore (манипулятора с хранилищем данных),
 * этот класс берет на себя функции отображения на List и манипуляции с данными из DataStore
 * вся информация лежит в хранилище REDISCOUNT и ее вид 
 * DISPLAY:[display_name]STORE:[store_name]
 * DISPLAY:[display_name] - отображаемая на экране
 * STORE:[store_name] - имена хранилищ, в которых лежат переучеты
 */
public class TStore_shell_List {
       private TStore store;
       private List list;
       private String preambule_store_name;
    /** Creates a new instance of TStore_shell_List */
    public TStore_shell_List(List source_list,String store_name) {
       this.preambule_store_name=store_name;
       this.store=new TStore(store_name);
       this.store.openRecordStore();
       this.list=source_list;
       if((this.store!=null)&&(this.list!=null)){
           this.show_elements_on_list();
       }
       
    }
    /*
     * Отобразить на List все элементы, которые мы получили из хранилища данных
     */
    public void show_elements_on_list() {
       // удаляем все элементы
       this.list.deleteAll();
       // добавляем элементы на форму
       String[] temp_list=this.store.get_list_store();
       for(int i=0;i<temp_list.length;i++){
           //System.out.println("прочитан элемент: "+temp_list[i]);
           this.list.append(this.get_display_name(temp_list[i]),null);
       }
    }
    /*
     * Метод, который возвращает из хранилища имя переучета для дальнейшего его отображения (display_name)
     * формат хранилища - DISPLAY:[display_name]STORE:[store_name]
     */
    public String get_display_name(String string) {
        String result="";
        int index_begin=string.indexOf("DISPLAY:[");
        if(index_begin>=0){
            // строка "DISPLAY" найдена, вынимаем данные
           int index_end=string.indexOf("]",index_begin);
           if(index_end>0){
               result=string.substring(index_begin+9,index_end);
           }
           else {
               // нарушение формата строки в хранилище
               //System.out.println("Нарушение формата строки в хранилище");
           }
        }
        else {
            // не найдена строка "DISPLAY:["
            //System.out.println("не найдена строка DISPLAY:[");
        }
        return result;
    }
    /*
     * Метод, который возвращает из хранилища имя сохраненного переучета для манипуляций с хранилищем
     * формат хранилища - DISPLAY:[display_name]STORE:[store_name]
     */

    public String get_store_name(String string) {
        String result="";
        int index_begin=string.indexOf("STORE:[");
        if(index_begin>=0){
            // строка "DISPLAY" найдена, вынимаем данные
           int index_end=string.indexOf("]",index_begin);
           if(index_end>0){
               result=string.substring(index_begin+7,index_end);
           }
           else {
               // нарушение формата строки в хранилище
               //System.out.println("Нарушение формата строки в хранилище");
           }
        }
        else {
            // не найдена строка "STORE:["
            //System.out.println("не найдена строка STORE:[");
        }
        return result;
    }
    
    /*
     * Получение имени хранилища, на основании имени переучета:
     * получение STORE:[] на основании DISPLAY:[];
     */
    public String get_store_name_by_display_name(String display_name){
        String[] temp_list=this.store.get_list_store();
        String result="";
        for(int i=0;i<temp_list.length;i++){
            if(this.get_display_name(temp_list[i]).equals(display_name)){
                int index_begin=temp_list[i].indexOf("STORE:[");
                if((index_begin>=0)&&(temp_list[i].indexOf("]",index_begin)>0)){
                    //System.out.println("Найдена строка STORE[]");
                    result=temp_list[i].substring(index_begin+7,temp_list[i].indexOf("]",index_begin));
                    break;
                }
                else {
                    //System.out.println("Не найдена строка STORE:[]");
                }
            }
        }
        return result;
    }
    /*
     * Создать запись для переучета в основном хранилище
     */
    public void create_record(String display_name){
        // проверка на неповторение данного имени
        String[] temp_list=this.store.get_list_store();
        boolean flag_repeat=false;
        for(int i=0;i<temp_list.length;i++){
            if(this.get_display_name(temp_list[i]).equals(display_name)){
                //System.out.println("Найдено похожее имя - запись не будет создана");
                flag_repeat=true;
                break;
            }
        }
        if(flag_repeat==false){
            String store_name=Long.toString(System.currentTimeMillis());
            this.store.add_to_store("DISPLAY:["+display_name+"] STORE:["+this.preambule_store_name+store_name+"]");
            //System.out.println("добавлена запись>>>"+"DISPLAY:["+display_name+"] STORE:["+this.preambule_store_name+store_name+"]");
        }
    }
    /*
     * Удалить переучет на основании имени DISPLAY:[
     */
    public void delete_record_by_display_name(String display_name_for_delete){
        String[] temp_list=this.store.get_list_store();
        for(int i=0;i<temp_list.length;i++){
            String display_name=this.get_display_name(temp_list[i]);
            String store_name=this.get_store_name(temp_list[i]);
            if(display_name.equals(display_name_for_delete)){
                // имя найдено - удаление
                   // удаление из основного хранилища
                if(this.store.delete_from_store_by_name(temp_list[i])){
                    //System.out.println("Удаление из основного хранилища произведено"+temp_list[i]);
                }
                else {
                    //System.out.println("Удаление основного хранилища не произведено");
                }
                   // удаление созданного хранилища
                try{
                    //System.out.println("Попытка удаления данных из созданного хранилища:["+store_name+"]");
                    javax.microedition.rms.RecordStore.deleteRecordStore(store_name);
                    //System.out.println("созданное хранилище удалено:["+store_name+"]");
                }
                catch(Exception e){
                    //System.out.println("Ошибка при удалении данных из хранилища:\n"+e.getMessage());
                }
                break;
            }
        }
    }
    /*
     * Получить все данные по хранилищу на основании имени
     */
    public String get_data_from_store(String display_name){
        StringBuffer result=new StringBuffer("");
        String store_name=this.get_store_name_by_display_name(display_name);
        if((store_name!=null)&&(store_name!="")){
            try{
                TStore store_source=new TStore(store_name);
                store_source.openRecordStore();
                String[] temp_list=store_source.get_list_store();
                for(int i=0;i<temp_list.length;i++){
                    result.append(temp_list[i]+"\n");
                    //result=result+;
                }
                store_source.closeRecordStore();
            }
            catch(Exception e){
                //System.out.println(" error in open store: "+e.getMessage());
            }
        }
        else {
            //System.out.println("Error in open store for read data by rediscount");
        }
        return result.toString();
    }

}
