/*
 * ComListener.java
 *
 * Created on 9 ќкт€брь 2007 г., 8:06
 *
 * To change this template, choose Tools | Template Manager
 * and open the template in the editor.
 */

package get_data_from_com;

/**
 *
 * @author root
 */
/**
 * »нтерфейс, в который передаетс€ информаци€, считанна€ с COM порта
 */
public interface ComListener {
    public void data_from_port(String s);
}
