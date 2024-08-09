/*
 * TStore_shell_ChoiceGroup.java
 *
 * Created on 8 Октябрь 2007 г., 6:37
 *
 * To change this template, choose Tools | Template Manager
 * and open the template in the editor.
 */

package main_package;

import javax.microedition.lcdui.ChoiceGroup;

/**
 *
 * @author root
 */
public class TStore_shell_ChoiceGroup {
    private TStore store;
    private ChoiceGroup choicegroup;
    /** Constructor - инициализация элемента TStore - Комбинация*/
    public TStore_shell_ChoiceGroup(TStore store_source,String store_name,ChoiceGroup choicegroup_source) {
        this.store=store_source;
        this.choicegroup=choicegroup_source;
        if(this.store.isOpen()==false){
            this.store.set_store_name(store_name);
            this.store.openRecordStore();
        }
        this.show_elements_on_choicegroup();
    }
    /*
     * Отобразить элементы из Store на ChoiceGroup
     */
    public void show_elements_on_choicegroup(){
        // clear choice group
        this.choicegroup.deleteAll();
        // set element into group
        String[] elements=this.store.get_list_store();
        for(int i=0;i<elements.length;i++){
            this.choicegroup.append(elements[i],null);
        }
    }
    /*
     * Добавление элемента
     */
    public void add_elements(String new_elements){
        this.store.add_to_store(new_elements);
        this.show_elements_on_choicegroup();
    }
    /*
     * Удаление элемента
     */
    public boolean delete_element(String elements){
        boolean result=false;
        int record_id=-1;
        record_id=this.store.get_recordid_by_recorddata(elements);
        if(record_id!=-1){
            this.store.delete_from_store_by_id(record_id);
            this.show_elements_on_choicegroup();
            result=true;
            System.out.println("Element deleted");
        }
        else {
            // element no found
            result=false;
            System.out.println("Element not deleted");
        }
        return result;
    }
    /*
     * Замена элемента
     */ 
    public boolean replace_element(String old_element,String new_element){
       boolean result=false;
       int old_record_id=-1;
       old_record_id=this.store.get_recordid_by_recorddata(old_element);
       if(old_record_id!=-1){
           this.store.delete_from_store_by_id(old_record_id);
           this.store.add_to_store(new_element);
           this.show_elements_on_choicegroup();
           result=true;
       }
       else {
           result=false;
       }
       return result;
    }
}
