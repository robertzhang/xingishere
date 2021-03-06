# encoding: utf-8
class Admin::BlogsController < AdminController
  layout 'admin'
  def index
    @blogs = Blog.where("title like ?", "%#{params[:title]}%").weight_order.page(params[:page]).per(10)
    @category = BlogCategory.all
  end

  def show
    @blog = Blog.find(params[:id])
    @like = false                   # 当前用户是否喜欢此博客
    @blog.view_total = @blog.view_total += 1
    @blog.save
    @like = true if (current_user.present? && Blog.like_by_user?(current_user.id, @blog.id))

    @auth = false # 用户是否有权限操作此博客
    @auth = true if current_user.present? && @blog.user_id == current_user.id
  end

  def new
    @blog = Blog.new
    @category = BlogCategory.all
  end

  def create
    if current_user.blogs.create(params[:blog])
      redirect_to admin_blogs_path, success: "发表成功"
    else
      render 'new'
    end
  end

  def edit
    @blog = Blog.find_by_url_name(params[:id])
    @category = BlogCategory.all
  end

  def update
    @blog = Blog.find_by_url_name(params[:id])
    if @blog.update_attributes(params[:blog])
      redirect_to admin_blogs_path, success: "更新成功"
    else
      render 'edit'
    end
  end

  def destroy
    @blog = Blog.find_by_url_name(params[:id])
    if @blog.publish_status?
      @blog.update_attributes(publish_status:  false)
    else
      @blog.update_attributes(publish_status:  true)
    end

    if @blog.save
      redirect_to admin_blogs_url, success: "删除成功"
    else
      redirect_to admin_blogs_url, danger: "删除失败"
    end
  end

  def toggle_publish_status
    @blog = Blog.find_by_url_name(params[:id])
    if @blog.publish_status?
      @blog.update_attributes(publish_status:  false)
    else
      @blog.update_attributes(publish_status:  true)
    end

    if @blog.save
      redirect_to admin_blogs_url, success: "删除成功"
    else
      redirect_to admin_blogs_url, danger: "删除失败"
    end
  end
end
