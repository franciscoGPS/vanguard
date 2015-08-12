class StaticPagesController < ApplicationController
  def index
    set_meta_tags :title => t("home"),
              :description => t("homedescription"),
              :keywords => 'home, vanguard, business, food'
  end
end
