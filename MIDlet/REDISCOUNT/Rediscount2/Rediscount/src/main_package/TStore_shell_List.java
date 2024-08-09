/*
 * TStore_shell_List.java
 *
 * Created on 16 ������� 2007 �., 12:07
 *
 * To change this template, choose Tools | Template Manager
 * and open the template in the editor.
 */

package main_package;

import javax.microedition.lcdui.List;

/**
 * @author root
 * ��� �����-������� ��� TStore (������������ � ���������� ������),
 * ���� ����� ����� �� ���� ������� ����������� �� List � ����������� � ������� �� DataStore
 * ��� ���������� ����� � ��������� REDISCOUNT � �� ��� 
 * DISPLAY:[display_name]STORE:[store_name]
 * DISPLAY:[display_name] - ������������ �� ������
 * STORE:[store_name] - ����� ��������, � ������� ����� ���������
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
     * ���������� �� List ��� ��������, ������� �� �������� �� ��������� ������
     */
    public void show_elements_on_list() {
       // ������� ��� ��������
       this.list.deleteAll();
       // ��������� �������� �� �����
       String[] temp_list=this.store.get_list_store();
       for(int i=0;i<temp_list.length;i++){
           //System.out.println("�������� �������: "+temp_list[i]);
           this.list.append(this.get_display_name(temp_list[i]),null);
       }
    }
    /*
     * �����, ������� ���������� �� ��������� ��� ��������� ��� ����������� ��� ����������� (display_name)
     * ������ ��������� - DISPLAY:[display_name]STORE:[store_name]
     */
    public String get_display_name(String string) {
        String result="";
        int index_begin=string.indexOf("DISPLAY:[");
        if(index_begin>=0){
            // ������ "DISPLAY" �������, �������� ������
           int index_end=string.indexOf("]",index_begin);
           if(index_end>0){
               result=string.substring(index_begin+9,index_end);
           }
           else {
               // ��������� ������� ������ � ���������
               //System.out.println("��������� ������� ������ � ���������");
           }
        }
        else {
            // �� ������� ������ "DISPLAY:["
            //System.out.println("�� ������� ������ DISPLAY:[");
        }
        return result;
    }
    /*
     * �����, ������� ���������� �� ��������� ��� ������������ ��������� ��� ����������� � ����������
     * ������ ��������� - DISPLAY:[display_name]STORE:[store_name]
     */

    public String get_store_name(String string) {
        String result="";
        int index_begin=string.indexOf("STORE:[");
        if(index_begin>=0){
            // ������ "DISPLAY" �������, �������� ������
           int index_end=string.indexOf("]",index_begin);
           if(index_end>0){
               result=string.substring(index_begin+7,index_end);
           }
           else {
               // ��������� ������� ������ � ���������
               //System.out.println("��������� ������� ������ � ���������");
           }
        }
        else {
            // �� ������� ������ "STORE:["
            //System.out.println("�� ������� ������ STORE:[");
        }
        return result;
    }
    
    /*
     * ��������� ����� ���������, �� ��������� ����� ���������:
     * ��������� STORE:[] �� ��������� DISPLAY:[];
     */
    public String get_store_name_by_display_name(String display_name){
        String[] temp_list=this.store.get_list_store();
        String result="";
        for(int i=0;i<temp_list.length;i++){
            if(this.get_display_name(temp_list[i]).equals(display_name)){
                int index_begin=temp_list[i].indexOf("STORE:[");
                if((index_begin>=0)&&(temp_list[i].indexOf("]",index_begin)>0)){
                    //System.out.println("������� ������ STORE[]");
                    result=temp_list[i].substring(index_begin+7,temp_list[i].indexOf("]",index_begin));
                    break;
                }
                else {
                    //System.out.println("�� ������� ������ STORE:[]");
                }
            }
        }
        return result;
    }
    /*
     * ������� ������ ��� ��������� � �������� ���������
     */
    public void create_record(String display_name){
        // �������� �� ������������ ������� �����
        String[] temp_list=this.store.get_list_store();
        boolean flag_repeat=false;
        for(int i=0;i<temp_list.length;i++){
            if(this.get_display_name(temp_list[i]).equals(display_name)){
                //System.out.println("������� ������� ��� - ������ �� ����� �������");
                flag_repeat=true;
                break;
            }
        }
        if(flag_repeat==false){
            String store_name=Long.toString(System.currentTimeMillis());
            this.store.add_to_store("DISPLAY:["+display_name+"] STORE:["+this.preambule_store_name+store_name+"]");
            //System.out.println("��������� ������>>>"+"DISPLAY:["+display_name+"] STORE:["+this.preambule_store_name+store_name+"]");
        }
    }
    /*
     * ������� �������� �� ��������� ����� DISPLAY:[
     */
    public void delete_record_by_display_name(String display_name_for_delete){
        String[] temp_list=this.store.get_list_store();
        for(int i=0;i<temp_list.length;i++){
            String display_name=this.get_display_name(temp_list[i]);
            String store_name=this.get_store_name(temp_list[i]);
            if(display_name.equals(display_name_for_delete)){
                // ��� ������� - ��������
                   // �������� �� ��������� ���������
                if(this.store.delete_from_store_by_name(temp_list[i])){
                    //System.out.println("�������� �� ��������� ��������� �����������"+temp_list[i]);
                }
                else {
                    //System.out.println("�������� ��������� ��������� �� �����������");
                }
                   // �������� ���������� ���������
                try{
                    //System.out.println("������� �������� ������ �� ���������� ���������:["+store_name+"]");
                    javax.microedition.rms.RecordStore.deleteRecordStore(store_name);
                    //System.out.println("��������� ��������� �������:["+store_name+"]");
                }
                catch(Exception e){
                    //System.out.println("������ ��� �������� ������ �� ���������:\n"+e.getMessage());
                }
                break;
            }
        }
    }
    /*
     * �������� ��� ������ �� ��������� �� ��������� �����
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
