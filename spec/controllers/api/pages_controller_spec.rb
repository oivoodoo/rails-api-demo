require 'spec_helper'

describe Api::PagesController do
  let(:format_type) { :json }

  context "list of pages" do
    let!(:about) { create(:page) }
    let!(:article) { create(:page) }

    before { get :index, :format => format_type }

    it { should respond_with(:success) }
    it { assigns(:pages).should == [about, article] }
    it { response.body.should == [about, article].to_json }

    context "as xml response" do
      let(:format_type) { :xml }

      it { response.body.should == [about, article].to_xml }
    end
  end

  context "create new page" do
    before { post :create, :page => attributes, :format => format_type }

    context "with valid attributes" do
      let(:attributes) { attributes_for(:page) }

      it { should respond_with(:success) }
      it { assigns(:page).should be_persisted }
      it { response.body.should == Page.last.to_json }

      context "as xml response" do
        let(:format_type) { :xml }

        it { response.body.should == Page.last.to_xml }
      end
    end

    context "with invalid attributes" do
      let(:attributes) { attributes_for(:page, :title => nil) }

      it { should respond_with(400) }
    end
  end

  context "get page" do
    let!(:page) { create(:page) }

    before { get :show, :id => page.id, :format => format_type }

    it { should respond_with(:success) }
    it { response.body.should == page.to_json }

    context "as xml response" do
      let(:format_type) { :xml }

      it { response.body.should == page.to_xml }
    end
  end

  context "try to get page with invalid id" do
    before { get :show, :id => "invalid id", :format => format_type }

    it { should respond_with(404) }
  end

  context "update page details" do
    let!(:page) { create(:page) }

    context "with valid attributes" do
      before do
        put :update, :id => page.id,
          :page => { :title => "new title" },
          :format => format_type
      end

      it { should respond_with(:success) }
      it { response.body.should == Page.last.to_json }
      it { assigns(:page).title.should == "new title" }
      it { Page.last.title.should == "new title" }
    end

    context "with invalid attributes" do
      before do
        put :update, :id => page.id,
          :page => { :title => nil },
          :format => format_type
      end

      it { should respond_with(400) }
    end

    context "as xml response" do
      let(:format_type) { :xml }

      before do
        put :update, :id => page.id,
          :page => { :title => "new title" },
          :format => format_type
      end

      it { response.body.should == Page.last.to_xml }
    end
  end

  context "try to update page with invalid id" do
    before { put :update, :id => "invalid id", :format => format_type }

    it { should respond_with(404) }
  end

  context "destroy page object" do
    let!(:page) { create(:page) }

    it "should destroy page from database" do
      expect {
        delete :destroy, :id => page.id, :format => format_type
      }.to change { Page.count }.by(-1)
    end
  end

  context "try to destroy page with invalid id" do
    before { delete :destroy, :id => "invalid id", :format => format_type }

    it { should respond_with(404) }
  end
end

describe Api::PagesController do
  let(:format_type) { :json }

  context "provide only published pages sorting by published on desc" do
    let!(:page) { create(:page) }

    before do
      Page.should_receive(:published).and_return([page])

      get :published, :format => format_type
    end

    it { should respond_with(:success) }
    it { response.body.should == [page].to_json }

    context "as xml response" do
      let(:format_type) { :xml }

      it { response.body.should == [page].to_xml }
    end
  end
end

describe Api::PagesController do
  let(:format_type) { :json }

  context "provide only unpublished pages sorting by published on desc" do
    let!(:page) { create(:page) }

    before do
      Page.should_receive(:unpublished).and_return([page])

      get :unpublished, :format => format_type
    end

    it { should respond_with(:success) }
    it { response.body.should == [page].to_json }

    context "as xml response" do
      let(:format_type) { :xml }

      it { response.body.should == [page].to_xml }
    end
  end
end

describe Api::PagesController do
  let(:format_type) { :json }

  context "publish page" do
    let!(:page) { create(:page) }

    before do
      Timecop.freeze DateTime.now

      post :publish, :id => page.id, :format => format_type
    end

    after { Timecop.return }

    it "should set current time for published on of the page" do
      Page.last.published_on.should == DateTime.now
    end

    it { response.body.should == page.reload.to_json }

    context "as xml response" do
      let(:format_type) { :xml }

      it { response.body.should == page.reload.to_xml }
    end
  end

  context "try to publish page with invalid id" do
    before { post :publish, :id => "invalid id", :format => format_type }

    it { should respond_with(404) }
  end
end
