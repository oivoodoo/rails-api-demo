require 'spec_helper'

describe Page do
  it { should validate_presence_of(:title) }
  it { should allow_mass_assignment_of(:title) }

  it { should validate_presence_of(:content) }
  it { should allow_mass_assignment_of(:content) }

  it { should allow_mass_assignment_of(:published_on) }
end

describe Page do
  describe "published scope" do
    before do
      Timecop.freeze DateTime.now
    end

    after { Timecop.return }

    let!(:two_days_ago) { create(:page, :published_on => 2.days.ago) }
    let!(:today) { create(:page, :published_on => 1.minute.ago) }
    let!(:day_ago) { create(:page, :published_on => 1.day.ago) }
    let!(:not_published) { create(:page) }
    let!(:in_future_published) { create(:page, :published_on => 1.week.from_now) }

    it "should return only published pages" do
      Page.published.all.should == [today, day_ago, two_days_ago]
    end
  end
end

