/*
 * TStringTokenizer.java
 *
 * Created on 11 Ноябрь 2007 г., 9:02
 *
 * To change this template, choose Tools | Template Manager
 * and open the template in the editor.
 */

package main_package;

import java.util.Enumeration;
import java.util.Vector;

/**
 * Полный аналог класса из J2SE TStringTokenizer
 * class replaced TStringTokenizer in java.util.* (J2SE)
 */
class TStringTokenizer implements Enumeration{
    private Vector v=new Vector();
    private int counter=0;
    TStringTokenizer(String text,String delimeter){
        int index=0;
        while((index=(text.indexOf(delimeter)))>0){
            v.addElement(text.substring(0,index));
            text=text.substring(index+delimeter.length());
        }
        if(text.trim().length()!=0){
        	v.addElement(text);
        }
    }
    
    TStringTokenizer(String text){
        this(text," ");
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
    
    public void reset(){
        this.counter=0;
    }
    
    public String get_element(int index){
        String return_value="";
        if(index<this.countTokens()){
            return_value=(String)this.v.elementAt(index);
        }
        return return_value;
    }
}
