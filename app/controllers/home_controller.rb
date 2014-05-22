class HomeController < ApplicationController
  skip_before_filter  :authorize
  def index
    @blogs     = Blog.published.includes(:blog_category, :tags).page(params[:page]).per(10)
  end
end
