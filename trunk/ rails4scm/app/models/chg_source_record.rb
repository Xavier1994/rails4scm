class ChgSourceRecord < ActiveRecord::Base
  self.table_name = "chg_source_record"
  self.primary_key = "id"
  attr_accessor :id
end
