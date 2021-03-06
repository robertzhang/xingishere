# encoding : utf-8
class LinksController < ApplicationController
  layout  'links'
  def index
    @links = Link.includes(:link_category).group_by { |link| link.link_category_id }
  end
end
