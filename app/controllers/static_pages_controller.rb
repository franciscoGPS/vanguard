class StaticPagesController < ApplicationController
  before_action :authenticate_user!, :only => [:admin]
  layout "home", :except => [:admin]
  def index
    set_meta_tags :title => t("home"),
              :description => t("homedescription"),
              :keywords => 'home, vanguard, business, food'
    redirect_to 'public/index.html'
  end

  #Este método es al unico que se tiene acceso sin autenticar
  #Se designa en la línea 2 de este doc
  def admin
    @sales = Sale.group_by_day(:created_at).count
    #@sales_by_customer = Sale
  end
end
