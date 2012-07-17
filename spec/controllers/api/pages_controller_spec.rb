require 'spec_helper'

describe Api::PagesController do
  context "list of pages" do
    let!(:about) { create(:page) }
    let!(:article) { create(:page) }
    let(:format_type) { :json }

    before { get :index, :format => format_type }

    it { should respond_with(:success) }
    it { assigns(:pages).should == [about, article] }
    it { response.body.should == [about, article].to_json }

    context "on xml format" do
      let(:format_type) { :xml }

      it { response.body.should == [about, article].to_xml }
    end
  end
end

