class Api::PagesController < ApplicationController
  include ActionController::MimeResponds

  before_filter :find_page, :only => [:show, :update, :destroy]

  def index
    @pages = Page.all

    respond_to do |format|
      format.json { render :json => @pages }
      format.xml { render :xml => @pages }
    end
  end

  def create
    @page = Page.new(params[:page])

    head(400) and return if @page.invalid?

    @page.save

    respond_to do |format|
      format.json { render :json => @page }
      format.xml { render :xml => @page }
    end
  end

  def show
    @page = Page.find(params[:id])

    respond_to do |format|
      format.json { render :json => @page }
      format.xml { render :xml => @page }
    end
  end

  def update
    @page.update_attributes(params[:page])

    head(400) and return if @page.invalid?

    respond_to do |format|
      format.json { render :json => @page }
      format.xml { render :xml => @page }
    end
  end

  def destroy
    @page.destroy

    respond_to do |format|
      format.json { render :json => :ok }
      format.xml { render :xml => :ok }
    end
  end

  private

  def find_page
    @page = Page.find(params[:id])
  end
end

