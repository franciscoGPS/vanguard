class StaticPagesController < ApplicationController
  before_action :authenticate_user!, :only => [:admin]
  layout "home", :except => [:admin]
  def index
    set_meta_tags :title => t("home"),
              :description => t("homedescription"),
              :keywords => 'home, vanguard, business, food'
  end
  def admin
  	
  end
end
