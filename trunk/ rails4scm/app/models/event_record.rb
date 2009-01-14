class EventRecord < ActiveRecord::Base
  self.table_name = "event_record"
  self.primary_key = "id"
  attr_accessor :id
  
  def findEventRecordAll(pageSize,curPageSize,event_name,m_event_type,project_code,event_sponsor,current_status)
    sql = "select * from event_record "
    if(event_name != nil or m_event_type != nil or project_code != nil or event_sponsor != nil or current_status != nil) then
          where = " where "
          if(event_name != nil) then
            event_name = event_name.lstrip
            event_name = event_name.rstrip
            where += "event_name like '%" + event_name + "%' and "
          end
          if(m_event_type != nil) then
            m_event_type = m_event_type.lstrip
            m_event_type = m_event_type.rstrip
            where += "m_event_type like '%" + m_event_type + "%' and "
          end
          if(project_code != nil) then
            project_code = project_code.lstrip
            project_code = project_code.rstrip
            where += "project_code like '%" + project_code + "%' and "
          end
          if(event_sponsor != nil) then
            event_sponsor = event_sponsor.lstrip
            event_sponsor = event_sponsor.rstrip
            where += "event_sponsor like '%" + event_sponsor + "%' and "
          end
          if(current_status != nil) then
            current_status = current_status.lstrip
            current_status = current_status.rstrip
            where += "current_status ='" + current_status + "' and "
          end
          whre_a = ""
          if(where != "" and where != nil) then
             where = (where.strip).split(//)
             i = where.size-3
             k = 0
             for j in where
               whre_a += j
               k = k + 1
               if(k == i) then
                 break
               end
             end
          end 
          sql += whre_a
          
    end
    sql += " ORDER BY EVENT_TIME desc" 
    
    EventRecord.paginate_by_sql([sql],:per_page =>pageSize,:page =>curPageSize,:order=>"EVENT_TIME desc")
  end
  
  #保存
  def addSave(id,sid,event_name_t,m_event_type_t,project_code_t,person)
       eventRecord = EventRecord.new
       eventRecord.ID=id
       eventRecord.EVENT_CODE=sid
       eventRecord.EVENT_NAME=event_name_t
       eventRecord.M_EVENT_TYPE=m_event_type_t
       eventRecord.PROJECT_CODE=project_code_t
       eventRecord.CURRENT_STATUS="已创建"
       eventRecord.EVENT_SPONSOR=person
       eventRecord.EVENT_TIME=Time.now
       
       eventRecord.save 
  end
 
  def findEventRecor(event_code)
    EventRecord.find(:first,:conditions =>["event_code=? ",event_code])
  end
end
