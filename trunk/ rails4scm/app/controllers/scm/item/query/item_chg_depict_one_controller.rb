class Scm::Item::Query::ItemChgDepictOneController < ApplicationController

  def index
    @configure_chg_no = params[:configure_chg_no]
    clos = "MODIFY_DATE,TABLE_NAME,COLUMN_NAME,PROBLEM_DETAIL,MODIFY_DETAIL,MODIFY_PERSON"
    @clos = clos.split(",")
    @chgdata = ChgDatabaseRecord.find(:all,:conditions =>["chg_no =? ",@configure_chg_no])
    @message = "";
    mess = "±£´æ@WÉ¾³ý@W³É¹¦!@WÊ§°Ü!@W"
    message = mess.split("@W")
    click_hidden = params[:click_hidden]
    if click_hidden == nil or click_hidden == "" then
      click_hidden = "0"
    end
    #±£´æ
    if(click_hidden == "1")
      i =0
      for param in params[:chg]
       chg=param[1]
       i = i + 1
       if(i<=@chgdata.size)
         begin
           id = chg[:ID]
           chgdata = ChgDatabaseRecord.find(id)
           chgdata.id=id
           chgdata.MODIFY_DATE=chg[:MODIFY_DATE]
           chgdata.TABLE_NAME=chg[:TABLE_NAME]
           chgdata.COLUMN_NAME=chg[:COLUMN_NAME]
           chgdata.PROBLEM_DETAIL=chg[:PROBLEM_DETAIL]
           chgdata.MODIFY_DETAIL=chg[:MODIFY_DETAIL]
           chgdata.MODIFY_PERSON=chg[:MODIFY_PERSON] 
           chgdata.save
         rescue Exception => e
           puts e.message
         end
       else
         begin
           num = 1
           argument = Argument.new
           maxid = argument.max_id(num,"chg_database_record")
           chgdata = ChgDatabaseRecord.new
           j = maxid[0]
           chgdata.id=j[0]
           chgdata.ID=j[0]
           chgdata.CHG_NO=@configure_chg_no
           chgdata.MODIFY_DATE=chg[:MODIFY_DATE]
           chgdata.TABLE_NAME=chg[:TABLE_NAME]
           chgdata.COLUMN_NAME=chg[:COLUMN_NAME]
           chgdata.PROBLEM_DETAIL=chg[:PROBLEM_DETAIL]
           chgdata.MODIFY_DETAIL=chg[:MODIFY_DETAIL]
           chgdata.MODIFY_PERSON=chg[:MODIFY_PERSON] 
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
        ChgDatabaseRecord.delete(id)
        @message=message[1] + message[2]
      rescue Exception => e
        @message=message[1] + message[3]
      end
    end
    @chgdata = ChgDatabaseRecord.find(:all,:conditions =>["chg_no =? ",@configure_chg_no])
  end
end
