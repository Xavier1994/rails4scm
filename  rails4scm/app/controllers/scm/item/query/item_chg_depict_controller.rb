class Scm::Item::Query::ItemChgDepictController < ApplicationController

  def index
    @configure_chg_no = params[:configure_chg_no]
  end
end
