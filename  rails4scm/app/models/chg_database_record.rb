class ChgDatabaseRecord < ActiveRecord::Base
  self.table_name = "chg_database_record"
  self.primary_key = "id"
  attr_accessor :id
end
