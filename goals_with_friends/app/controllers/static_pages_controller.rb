class StaticPagesController < ApplicationController
  def home
    redirect_to goals_path if signed_in?
  end

  def about
  end
end
