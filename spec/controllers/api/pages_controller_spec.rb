require 'spec_helper'

describe Api::PagesController do
  context "list of pages" do
    let!(:about) { create(:page) }
    let!(:article) { create(:page) }

    before { get :index, :format => :json }

    it { should respond_with(:success) }
    it { assigns(:pages).should == [about, article] }
  end
end

