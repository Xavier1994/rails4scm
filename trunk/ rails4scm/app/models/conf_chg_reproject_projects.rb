class ConfChgReprojectProjects < ActiveRecord::Base
  self.table_name = "conf_chg_reproject_projects"
  self.primary_key = "id"
  
  def findConfChgReprojectProjects(event_code)
    project_state = "ÒÑ½áÊø@W"
    stateArra = project_state.split("@W")
    sql = "SELECT CONF_CHG_REPROJECT_PROJECTS.ID,CONF_CHG_REPROJECT_PROJECTS.EVENT_CODE,"
    sql += "CONF_CHG_REPROJECT_PROJECTS.NEW_IDENTIFY_STATUS,CONF_CHG_REPROJECT_PROJECTS.NEW_STORE_STATUS,"
    sql += "CONF_CHG_REPROJECT_PROJECTS.CHG_CIRC_STATUS,CONF_CHG_REPROJECT_PROJECTS.CHG_CIRC_DETAIL,"
    sql += "PROJECT_MSG.PROJECT_NAME FROM CONF_CHG_REPROJECT_PROJECTS, PROJECT_MSG  "
    sql += " WHERE ( CONF_CHG_REPROJECT_PROJECTS.PROJECT_CODE = PROJECT_MSG.PROJECT_CODE )  and "
    sql += " ( ( PROJECT_MSG.PROJECT_STATE <> '" + stateArra[0] + "' ) or PROJECT_MSG.PROJECT_STATE is null) "
    sql += " AND CONF_CHG_REPROJECT_PROJECTS.event_code='" + event_code + "'"
 
    ConfChgReprojectProjects.find_by_sql(sql)
  end
end
