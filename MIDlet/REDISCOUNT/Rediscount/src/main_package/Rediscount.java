/*
 * Rediscount.java
 *
 * Created on 7 Октябрь 2007 г., 9:08
 */

package main_package;

import javax.microedition.midlet.*;
import javax.microedition.lcdui.*;

/**
 *
 * @author root
 */

public class Rediscount extends MIDlet implements CommandListener {
    String store_name=null;
    TStore store=null;
    
    /**
     * Creates a new instance of Rediscount
     */
    public Rediscount() {
    }
    
    private Form rediscount;//GEN-BEGIN:MVDFields
    private Command exitCommand;
    private Command delete_command;
    private Command add_command;
    private Command list_data;
    private Command edit_command;
    private TextField textField_record;
    private ChoiceGroup choiceGroup_store;//GEN-END:MVDFields
    
    private TStore_shell_ChoiceGroup store_shell;
//GEN-LINE:MVDMethods

    /** This method initializes UI of the application.//GEN-BEGIN:MVDInitBegin
     */
    private void initialize() {//GEN-END:MVDInitBegin
        // Insert pre-init code here
        getDisplay().setCurrent(get_rediscount());//GEN-LINE:MVDInitInit
        // Insert post-init code here
        store_name=new String("REDISCOUNT");
        store=new TStore(store_name);
        store.openRecordStore();
        this.store_shell=new TStore_shell_ChoiceGroup(store,"REDISCOUNT",this.choiceGroup_store);
    }//GEN-LINE:MVDInitEnd
    
    /** Called by the system to indicate that a command has been invoked on a particular displayable.//GEN-BEGIN:MVDCABegin
     * @param command the Command that ws invoked
     * @param displayable the Displayable on which the command was invoked
     */
    public void commandAction(Command command, Displayable displayable) {//GEN-END:MVDCABegin
        // Insert global pre-action code here
        if (displayable == rediscount) {//GEN-BEGIN:MVDCABody
            if (command == exitCommand) {//GEN-END:MVDCABody
                // Insert pre-action code here
                exitMIDlet();//GEN-LINE:MVDCAAction3
                // Insert post-action code here
            } else if (command == add_command) {//GEN-LINE:MVDCACase3
                // Insert pre-action code here
                this.add_data_to_screen();
                // Do nothing//GEN-LINE:MVDCAAction9
                // Insert post-action code here
            } else if (command == edit_command) {//GEN-LINE:MVDCACase9
                // Insert pre-action code here
                // Do nothing//GEN-LINE:MVDCAAction13
                // Insert post-action code here
            } else if (command == list_data) {//GEN-LINE:MVDCACase13
                // Insert pre-action code here
                this.list_data_to_screen();
                // Do nothing//GEN-LINE:MVDCAAction11
                // Insert post-action code here
            } else if (command == delete_command) {//GEN-LINE:MVDCACase11
                // Insert pre-action code here
                // Do nothing//GEN-LINE:MVDCAAction7
                // Insert post-action code here
                this.delete_from_screen();
            }//GEN-BEGIN:MVDCACase7
        }//GEN-END:MVDCACase7
        // Insert global post-action code here
}//GEN-LINE:MVDCAEnd
    
    /**
     * This method should return an instance of the display.
     */
    public Display getDisplay() {//GEN-FIRST:MVDGetDisplay
        return Display.getDisplay(this);
    }//GEN-LAST:MVDGetDisplay
    
    /**
     * This method should exit the midlet.
     */
    public void exitMIDlet() {//GEN-FIRST:MVDExitMidlet
        getDisplay().setCurrent(null);
        destroyApp(true);
        notifyDestroyed();
    }//GEN-LAST:MVDExitMidlet
    
    /** This method returns instance for rediscount component and should be called instead of accessing rediscount field directly.//GEN-BEGIN:MVDGetBegin2
     * @return Instance for rediscount component
     */
    public Form get_rediscount() {
        if (rediscount == null) {//GEN-END:MVDGetBegin2
            // Insert pre-init code here
            rediscount = new Form("Rediscount", new Item[] {//GEN-BEGIN:MVDGetInit2
                get_textField_record(),
                get_choiceGroup_store()
            });
            rediscount.addCommand(get_exitCommand());
            rediscount.addCommand(get_delete_command());
            rediscount.addCommand(get_add_command());
            rediscount.addCommand(get_list_data());
            rediscount.addCommand(get_edit_command());
            rediscount.setCommandListener(this);//GEN-END:MVDGetInit2
            // Insert post-init code here
        }//GEN-BEGIN:MVDGetEnd2
        return rediscount;
    }//GEN-END:MVDGetEnd2
    
    
    /** This method returns instance for exitCommand component and should be called instead of accessing exitCommand field directly.//GEN-BEGIN:MVDGetBegin5
     * @return Instance for exitCommand component
     */
    public Command get_exitCommand() {
        if (exitCommand == null) {//GEN-END:MVDGetBegin5
            // Insert pre-init code here
            exitCommand = new Command("Exit", Command.EXIT, 1);//GEN-LINE:MVDGetInit5
            // Insert post-init code here
        }//GEN-BEGIN:MVDGetEnd5
        return exitCommand;
    }//GEN-END:MVDGetEnd5

    /** This method returns instance for delete_command component and should be called instead of accessing delete_command field directly.//GEN-BEGIN:MVDGetBegin6
     * @return Instance for delete_command component
     */
    public Command get_delete_command() {
        if (delete_command == null) {//GEN-END:MVDGetBegin6
            // Insert pre-init code here
            delete_command = new Command("Delete", Command.OK, 1);//GEN-LINE:MVDGetInit6
            // Insert post-init code here
        }//GEN-BEGIN:MVDGetEnd6
        return delete_command;
    }//GEN-END:MVDGetEnd6

    /** This method returns instance for add_command component and should be called instead of accessing add_command field directly.//GEN-BEGIN:MVDGetBegin8
     * @return Instance for add_command component
     */
    public Command get_add_command() {
        if (add_command == null) {//GEN-END:MVDGetBegin8
            // Insert pre-init code here
            add_command = new Command("Add", Command.OK, 1);//GEN-LINE:MVDGetInit8
            // Insert post-init code here
        }//GEN-BEGIN:MVDGetEnd8
        return add_command;
    }//GEN-END:MVDGetEnd8

    /** This method returns instance for list_data component and should be called instead of accessing list_data field directly.//GEN-BEGIN:MVDGetBegin10
     * @return Instance for list_data component
     */
    public Command get_list_data() {
        if (list_data == null) {//GEN-END:MVDGetBegin10
            // Insert pre-init code here
            list_data = new Command("List", Command.OK, 1);//GEN-LINE:MVDGetInit10
            // Insert post-init code here
        }//GEN-BEGIN:MVDGetEnd10
        return list_data;
    }//GEN-END:MVDGetEnd10

    /** This method returns instance for edit_command component and should be called instead of accessing edit_command field directly.//GEN-BEGIN:MVDGetBegin12
     * @return Instance for edit_command component
     */
    public Command get_edit_command() {
        if (edit_command == null) {//GEN-END:MVDGetBegin12
            // Insert pre-init code here
            edit_command = new Command("Edit", Command.OK, 1);//GEN-LINE:MVDGetInit12
            // Insert post-init code here
        }//GEN-BEGIN:MVDGetEnd12
        return edit_command;
    }//GEN-END:MVDGetEnd12
 
    /** This method returns instance for textField_record component and should be called instead of accessing textField_record field directly.//GEN-BEGIN:MVDGetBegin15
     * @return Instance for textField_record component
     */
    public TextField get_textField_record() {
        if (textField_record == null) {//GEN-END:MVDGetBegin15
            // Insert pre-init code here
            textField_record = new TextField("Record Add", null, 120, TextField.ANY);//GEN-LINE:MVDGetInit15
            // Insert post-init code here
        }//GEN-BEGIN:MVDGetEnd15
        return textField_record;
    }//GEN-END:MVDGetEnd15

    /** This method returns instance for choiceGroup_store component and should be called instead of accessing choiceGroup_store field directly.//GEN-BEGIN:MVDGetBegin18
     * @return Instance for choiceGroup_store component
     */
    public ChoiceGroup get_choiceGroup_store() {
        if (choiceGroup_store == null) {//GEN-END:MVDGetBegin18
            // Insert pre-init code here
            choiceGroup_store = new ChoiceGroup("Enumeration store", Choice.MULTIPLE, new String[0], new Image[0]);//GEN-BEGIN:MVDGetInit18
            choiceGroup_store.setSelectedFlags(new boolean[0]);//GEN-END:MVDGetInit18
            // Insert post-init code here
        }//GEN-BEGIN:MVDGetEnd18
        return choiceGroup_store;
    }//GEN-END:MVDGetEnd18
      /*
     *Выводит на экран данные которые были получены из хранилища данных
     */
    private void list_data_to_screen(){
        this.store_shell.show_elements_on_choicegroup();
    }
    /*
     * Удаляет запись с экрана
     */
    private void delete_from_screen() {
        for(int i=0;i<this.choiceGroup_store.size();i++){
            if(this.choiceGroup_store.isSelected(i)){
                // delete from Store
                System.out.println("delete?:"+this.choiceGroup_store.getString(i));
                this.store_shell.delete_element(this.choiceGroup_store.getString(i));
                break;
            }
        }
        // Show store element
        this.store_shell.show_elements_on_choicegroup();
    }

    /*
     * Добавляет запись в хранилище и выводит данные на экран
     */
    private void add_data_to_screen() {
        //this.store.add_to_store(this.textField_record.getString());
        //this.list_data_to_screen();
        this.store_shell.add_elements(this.textField_record.getString());
        this.textField_record.setString("");
    }
    
    public void startApp() {
        initialize();
    }
    
    public void pauseApp() {
    }
    
    public void destroyApp(boolean unconditional) {
    }

    
}
