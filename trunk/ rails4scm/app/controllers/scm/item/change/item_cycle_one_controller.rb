class Scm::Item::Change::ItemCycleOneController < ApplicationController

  def index
    @configure_chg_no = params[:configure_chg_no]
    @configurechg = ConfigureChgApp.find(@configure_chg_no)
    configure_state = "已创建@W已实现@W已批准@W执行@W关闭@W"
    @configure_state = configure_state.split("@W")
    
    configureChgCycleDet = ConfigureChgCycleDet.new
    @configureChgCycleDetYi = configureChgCycleDet.findConfigureChgCycleDet(@configure_chg_no,@configure_state[0])
    @configureChgCycleDetEr = configureChgCycleDet.findConfigureChgCycleDet(@configure_chg_no,@configure_state[1])
    @configureChgCycleDetSa = configureChgCycleDet.findConfigureChgCycleDet(@configure_chg_no,@configure_state[2])
    @configureChgCycleDetSi = configureChgCycleDet.findConfigureChgCycleDet(@configure_chg_no,@configure_state[3])
  end
end
