require 'spec_helper'

describe Videopost do

  let(:user) { FactoryGirl.create(:user) }
  before { @videopost = user.videoposts.build(content: "http://www.youtube.com/watch?v=9bZkp7q19f0") }

  subject { @videopost }

  it { should respond_to(:content) }
  it { should respond_to(:user_id) }
  it { should respond_to(:user) }
  its(:user) { should == user }

  it { should be_valid }

  describe "when user_id is not present" do
    before { @videopost.user_id = nil }
    it { should_not be_valid }
  end

  describe "accessible attributes" do
    it "should not allow access to user_id" do
      expect do
        Videopost.new(user_id: user.id)
      end.to raise_error(ActiveModel::MassAssignmentSecurity::Error)
    end
  end

  describe "when user_id is not present" do
    before { @videopost.user_id = nil }
    it { should_not be_valid }
  end

  describe "with blank content" do
    before { @videopost.content = " " }
    it { should_not be_valid }
  end
end
