require 'spec_helper'

describe Page do
  it { should validate_presence_of(:title) }
  it { should allow_mass_assignment_of(:title) }

  it { should validate_presence_of(:content) }
  it { should allow_mass_assignment_of(:content) }

  it { should allow_mass_assignment_of(:published_on) }
end

describe Page do
  subject { build(:page) }

  context "when page doesn't have published on" do
    before { subject.published_on = nil }

    it { should_not be_published }
  end

  context "when page have already published" do
    before { subject.published_on = 1.day.ago }

    it { should be_published }
  end

  context "when page is planned to be published in the future" do
    before { subject.published_on = 1.day.from_now }

    it { should_not be_published }
  end

  context "when page is published today" do
    before do
      Timecop.freeze DateTime.now

      subject.published_on = DateTime.now
    end

    after { Timecop.return }

    it { should be_published }
  end
end

