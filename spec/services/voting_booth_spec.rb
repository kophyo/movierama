require 'rails_helper'

RSpec.describe VotingBooth do

  subject { VotingBooth.new(user, movie)}

  let(:user) { double }
  let(:movie) { double(likers: [].to_set, haters: [].to_set) }

  describe "#vote" do
    it 'notifies author when liked' do
      mailer = double
      expect(UserMailer).to receive(:notify).with(movie, user, :like).and_return(mailer)
      expect(mailer).to receive(:deliver)
      allow(movie).to receive(:update)
      subject.vote(:like)
    end

    it 'notifies author when hated' do
      mailer = double
      expect(UserMailer).to receive(:notify).with(movie, user, :hate).and_return(mailer)
      expect(mailer).to receive(:deliver)
      allow(movie).to receive(:update)
      subject.vote(:hate)
    end
  end
end
