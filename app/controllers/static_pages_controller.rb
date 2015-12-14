class StaticPagesController < ApplicationController
  before_action :authenticate_user!, :only => [:admin, :activities]
  layout "home", :only => [:index]
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

    # Generates Fb-wall like activities
    @activities = PublicActivity::Activity.limit(4).order("created_at DESC")
  end

  def activities
    @activities = PublicActivity::Activity.all.order("created_at DESC").page(params[:page]).per(15)
  end
end
