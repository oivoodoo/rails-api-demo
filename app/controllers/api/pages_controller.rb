class Api::PagesController < ApplicationController
  include ActionController::MimeResponds

  respond_to :json, :xml

  def index
    @pages = Page.all

    respond_with @pages
  end
end

