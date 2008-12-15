class RtSystemFunction < ActiveRecord::Base
      self.table_name = "rt_system_function"
      self.primary_key = "func_id"
      
      def findUserSystemFunction(operid)
        sql = "select distinct aa.func_id,ab.func_name,ab.target,ab.func_group_id "
        sql += "from RT_POSITION_RIGHT_ITEM aa,RT_SYSTEM_FUNCTION ab,PERSON_CLASS ac "
        sql += "where aa.func_id=ab.func_id and aa.person_class_code=ac.person_class_code "
        sql += "and aa.PERSON_CLASS_CODE in (select a.PERSON_CLASS_CODE from operator_works a,PERSON_CLASS b,operator c "
        sql += "where a.PERSON_CLASS_CODE=b.PERSON_CLASS_CODE and a.OPER_ID=c.OPER_ID and a.oper_id='" + operid + "')"
        
        RtSystemFunction.find_by_sql(sql) 
      end
end
