class StaticPagesController < ApplicationController
  before_action :authenticate_user!, :only => [:admin]
  layout "home", :except => [:admin]
  def index
    set_meta_tags :title => t("home"),
              :description => t("homedescription"),
              :keywords => 'home, vanguard, business, food'
    redirect_to 'public/index.html'
  end

  def admin
    @week_sales = Sale.group_by_day(:created_at, range: 1.weeks.ago.midnight..Time.now).count
    @month_sales = Greenhouse.all_sales_per_month
    @total_sales_ammount = Sale.total_month_sales_ammount[0][:total_ammount]

  end
end
