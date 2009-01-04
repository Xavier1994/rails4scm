class Scm::Item::Query::ItemChgDepictThreeController < ApplicationController

  def index
    @configure_chg_no = params[:configure_chg_no]
    clos = "MODIFY_TIME,SUB_SYSTEM,OBJECT_NAME,PROBLEM_DESCRIBE,MODIFY_NOTE,MODIRY_PERSON,PROBLEM_KIND,COMMENT"
    @clos = clos.split(",")
    @chgdata = ChgDocumentRecord.find(:all,:conditions =>["chg_no =? ",@configure_chg_no])
    @message = "";
    mess = "±£´æ@WÉ¾³ý@W³É¹¦!@WÊ§°Ü!@W"
    message = mess.split("@W")
    click_hidden = params[:click_hidden]
    if click_hidden == nil or click_hidden == "" then
      click_hidden = "0"
    end
    #±£´æ
    if(click_hidden == "1")
      hash = params[:chg].to_a
      for param in hash
       chg=param[1]
       i =param[0].to_i
       if(i<=@chgdata.size)
         begin
           if(chg.key?(:MODIFY_TIME))
             id = chg[:ID]
             chgdata = ChgDocumentRecord.find(id)
             chgdata.id=id
             chgdata.MODIFY_TIME=chg[:MODIFY_TIME]
             chgdata.SUB_SYSTEM=chg[:SUB_SYSTEM]
             chgdata.OBJECT_NAME=chg[:OBJECT_NAME]
             chgdata.PROBLEM_DESCRIBE=chg[:PROBLEM_DESCRIBE]
             chgdata.MODIFY_NOTE=chg[:MODIFY_NOTE] 
             chgdata.MODIRY_PERSON=chg[:MODIRY_PERSON]
             chgdata.PROBLEM_KIND=chg[:PROBLEM_KIND]
             chgdata.COMMENT=chg[:COMMENT]
             chgdata.save
           end
           
         rescue Exception => e
           puts e.message
         end
       else
         begin
           num = 1
           argument = Argument.new
           maxid = argument.max_id(num,"chg_database_record")
           chgdata = ChgDocumentRecord.new
           j = maxid[0]
           chgdata.id=j[0]
           chgdata.ID=j[0]
           chgdata.CHG_NO=@configure_chg_no
           chgdata.MODIFY_TIME=chg[:MODIFY_TIME]
           chgdata.SUB_SYSTEM=chg[:SUB_SYSTEM]
           chgdata.OBJECT_NAME=chg[:OBJECT_NAME]
           chgdata.PROBLEM_DESCRIBE=chg[:PROBLEM_DESCRIBE]
           chgdata.MODIFY_NOTE=chg[:MODIFY_NOTE] 
           chgdata.MODIRY_PERSON=chg[:MODIRY_PERSON]
           chgdata.PROBLEM_KIND=chg[:PROBLEM_KIND]
           chgdata.COMMENT=chg[:COMMENT] 
           chgdata.save 
         rescue Exception => e
           puts e.message
         end
       end
       @message=message[0] + message[2]
      end
    end
    
    #É¾³ý
    if(click_hidden == "2")
      begin
        id = params[:delete_id_hidden]
        ChgDocumentRecord.delete(id)
        @message=message[1] + message[2]
      rescue Exception => e
        @message=message[1] + message[3]
      end
    end
    @chgdata = ChgDocumentRecord.find(:all,:conditions =>["chg_no =? ",@configure_chg_no])
  end
end
