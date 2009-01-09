class Scm::Item::Query::ItemChgDepictController < ApplicationController

  def index
    @configure_chg_no = params[:configure_chg_no]
    clos = "MODIFY_DATE,TABLE_NAME,COLUMN_NAME,PROBLEM_DETAIL,MODIFY_DETAIL,MODIFY_PERSON"
    @closOne = clos.split(",")
    clos = "MODIFY_TIME,SUB_SYSTEM,APP_NAME,OBJECT_NAME,PROBLEM_DESCRIBE,MODIFY_NOTE,MODIRY_PERSON,PROBLEM_KIND,COMMENT"
    @closTwo = clos.split(",")
    clos = "MODIFY_TIME,SUB_SYSTEM,OBJECT_NAME,PROBLEM_DESCRIBE,MODIFY_NOTE,MODIRY_PERSON,PROBLEM_KIND,COMMENT"
    @closThree = clos.split(",")
    @chgdataOne   = ChgDatabaseRecord.find(:all,:conditions =>["chg_no =? ",@configure_chg_no])
    @chgdataTwo   = ChgSourceRecord.find(:all,:conditions =>["chg_no =? ",@configure_chg_no])
    @chgdataThree = ChgDocumentRecord.find(:all,:conditions =>["chg_no =? ",@configure_chg_no])
  end
end
