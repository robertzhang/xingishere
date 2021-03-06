# encoding : utf-8
class ApplicationController < ActionController::Base
  # before_filter :authorize
  protect_from_forgery with: :exception
  include SessionsHelper
  def authorize
    if User.find_by_id(session[:user_id]).blank?
      redirect_to user_login_path, alert: "请您先登录"
    end
  end

  def user_login
    if session[:user_id].blank?
      store_location
      flash[:info] = "请您先登录"
      redirect_to login_path
    end
  end

  def is_admin
    user = User.find(session[:user_id]) if session[:user_id].present?
    if !user || !user.admin?
      render_404_page
    end
  end

  def render_404_page
    respond_to do |format|
      format.xml { render :xml => { :error => 'Not found' }, :status => 404 }
      format.html { render template: 'errors/404', status: 404, layout: 'static' }
    end
    # redirect_to "/404.html"
  end
end
