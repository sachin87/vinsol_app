# == Schema Information
#
# Table name: users
#
#  id         :integer(4)      not null, primary key
#  name       :string(255)
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

require 'spec_helper'

describe User do
  before do
    @user = User.new(name: "Example User")

  end
  it {should respond_to(:microposts)}
  it {should respond_to(:feed)}
  it {should respond_to(:relationships)}
  
  
  it {should respond_to(:followed_users) }
  it {should respond_to(:following?) }
  it {should respond_to(:follow!) }
  it {should respond_to(:unfollow!) }
  it {should respond_to(:reverse_relationships) }
  it {should respond_to(:followers) }

  it {should be_valid}
  
  subject { @user }

  it {should respond_to(:name)}
  it {should respond_to(:microposts)}
   
  describe "micropost associations" do

    before { @user.save }
    let!(:older_micropost) do
      FactoryGirl.create(:micropost, user: @user, created_at: 1.day.ago)
    end
    let!(:newer_micropost) do
      FactoryGirl.create(:micropost, user: @user, created_at: 1.hour.ago)
    end

    it "should have the right microposts in the right order" do
      @user.microposts.should == [newer_micropost, older_micropost]
    end

    it "should destroy associated microposts" do
      microposts = @user.microposts
      @user.destroy
      microposts.each do |micropost|
        Micropost.find_by_id(micropost.id).should be_nil
      end
    end

    describe "status" do
      let(:unfollowed_post) do
        FactoryGirl.create(:micropost, user: FactoryGirl.create(:user))
      end
      let(:followed_user) {FactoryGirl.create(:user)}

      before do
        @user.follow!(followed_user)
        3.times {followed_user.microposts.create!(content: "Lorem ipsum")}
      end
      its(:feed) {should include(newer_micropost)}
      its(:feed) {should include(older_micropost)}
      its(:feed) {should_not include(unfollowed_post)}
      its(:feed) do
        followed_user.microposts.each do |micropost|
          should include(micropost)
        end
      end
    end

    describe "following" do
      let(:other_user) { FactoryGirl.create(:user) }
      before do
        @user.save
        @user.follow!(other_user)
      end

      it { should be_following(other_user) }
      its(:followed_users) { should include(other_user) }

      describe "followed user" do
        subject { other_user }
        its(:followers) { should include(@user) }
      end

      describe "and unfollowing" do
        before { @user.unfollow!(other_user) }

        it { should_not be_following(other_user) }
        its(:followed_users) { should_not include(other_user) }
      end
    end
  end
  
end






