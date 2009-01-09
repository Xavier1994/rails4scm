class Scm::Item::Change::ItemCycleUpgradeController < ApplicationController

  def index
    @configure_chg_no = params[:configure_chg_no]
    @configurechg = ConfigureChgApp.find(@configure_chg_no)

    conf = ConfChgReproductProducts.new
    @projectNon   = conf.findProjectNon(@configurechg.EVENT_CODE,@configurechg.CONFIGURE_CODE,@configurechg.PRE_VERSION)
    @projectBlock = conf.findProjectBlock(@configurechg.EVENT_CODE,@configurechg.CONFIGURE_CODE,@configurechg.PRE_VERSION)
    @itemNon   = conf.findItemNon(@configurechg.EVENT_CODE,@configurechg.CONFIGURE_CODE,@configurechg.PRE_VERSION)
    @itemblock = conf.findItemBlock(@configurechg.EVENT_CODE,@configurechg.CONFIGURE_CODE,@configurechg.PRE_VERSION)
  end
end
