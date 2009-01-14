class Scm::Collquery::Query::ConfigTreeController < ApplicationController
  before_filter :fileLoginSessionNil
  
  def index
    @tree = getTree()
  end
  
 private
     def getTree()
       begin
          inst=FsTreeModel::Treeview.new("配置项","#",0,'mainvalue',"collquery_query_main")
          url = "/scm/collquery/query/config_main?code="
          
          param = Param.new()
          configitem = ConfigureItem.new()
          
          #一级菜单
          @param = param.findParamAll()
          if @param == nil then
            return inst
          end
          
          #二级菜单
          @param2 = param.findParamER()
          
          #三级菜单
          @configitem = configitem.findConfigureItem()
          
          i=1
          for param1 in @param
            param_code = param1.con_type
            sub1=FsTreeModel::Treeview.new(param_code,"#",i,'value' + i.to_s,"collquery_query_main")
            j=1
            
            for param2 in @param2
              param_code2 = param2.param_code
              if param_code == param_code2 then
                 param_name2 = param2.param_name
                 cn = i.to_s + j.to_s 
                 sub2=FsTreeModel::Treeview.new(param_name2,"#",cn,'value' + cn,"collquery_query_main")
                 k = 1
                 for configitem1 in @configitem
                   configure_type = configitem1.configure_type
                   if configure_type==param_name2 then
                     url = "/scm/collquery/query/config_main?code="
                     name = configitem1.name
                     code = configitem1.code
                     cnk = cn.to_s + k.to_s
                     url = url.to_s + code
                     sub3=FsTreeModel::Treeview.new(name,url,cnk,'value' + cnk,"collquery_query_main")
                     cnk = ""
                     k = k + 1
                     sub2<<sub3
                     code = nil
                   end
                   configure_type = nil
                 end
                 j = j+1
                 cn = ""
                 sub1<<sub2
                 param_name2 = nil
              end
              param_code2 = nil
            end
            param_code = nil
            i = i+1
            inst<<sub1
          end
       rescue Exception => e  
          print e.backtrace.join("[配置项分类查询 -- 树型(/scm/collquery/query/config_query)]\n")
       end
       return inst
     end
end
