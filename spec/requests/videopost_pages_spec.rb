require 'spec_helper'

describe "Videopost pages" do

  subject { page }

  let(:user) { FactoryGirl.create(:user) }
  before { sign_in user }

  describe "videopost creation" do
    before { visit root_path }

    describe "with invalid information" do

      it "should not create a videopost" do
        expect { click_button "Share" }.not_to change(Videopost, :count)
      end

      describe "error messages" do
        before { click_button "Share" }
        it { should have_content('error') }
      end
    end

    describe "with valid information" do

      before { fill_in 'videopost_content', with: "http://www.youtube.com/watch?v=9bZkp7q19f0" }
      it "should create a videopost" do
        expect { click_button "Share" }.to change(Videopost, :count).by(1)
      end
    end
  end

  describe "videopost destruction" do
    before { FactoryGirl.create(:videopost, user: user) }

    describe "as correct user" do
      before { visit root_path }

      it "should delete a videopost" do
        expect { click_link "delete" }.to change(Videopost, :count).by(-1)
      end
    end
  end
end