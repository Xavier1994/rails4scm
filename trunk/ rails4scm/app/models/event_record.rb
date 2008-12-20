class EventRecord < ActiveRecord::Base
  self.table_name = "event_record"
  self.primary_key = "id"
  
  def findEventRecordAll(pageSize,curPageSize,event_name,m_event_type,project_code,event_sponsor,current_status)
    sql = "select * from event_record "
    if(event_name != nil or m_event_type != nil or project_code != nil or event_sponsor != nil or current_status != nil) then
          where = " where "
          if(event_name != nil) then
            where += "event_name like '%" + event_name + "%' and "
          end
          if(m_event_type != nil) then
            where += "m_event_type like '%" + m_event_type + "%' and "
          end
          if(project_code != nil) then
            where += "project_code like '%" + project_code + "%' and "
          end
          if(event_sponsor != nil) then
            where += "event_sponsor like '%" + event_sponsor + "%' and "
          end
          if(current_status != nil) then
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
    
    EventRecord.paginate_by_sql([sql],:per_page =>pageSize,:page =>curPageSize,:order=>"event_time desc")
  end
end
