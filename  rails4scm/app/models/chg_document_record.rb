class ChgDocumentRecord < ActiveRecord::Base
  self.table_name = "chg_document_record"
  self.primary_key = "id"
  attr_accessor :id
end
