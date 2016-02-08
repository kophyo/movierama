require 'rails_helper'

RSpec.describe UserMailer do
  describe 'notify' do
    let(:movie) { double(user: author, title: 'Fast and Furious') }
    let(:author) { double(email: 'author@example.com', name: 'Author') }
    let(:user) { double(name: 'Bob') }
    let(:type) { :like }
    let(:mail) { UserMailer.notify(movie, user, type) }

    it 'renders the subject' do
      expect(mail.subject).to eql('Bob just liked your movie.')
    end

    it 'renders the receiver email' do
      expect(mail.to).to eql(['author@example.com'])
    end

    it 'renders the sender email' do
      expect(mail.from).to eql(['noreply@movierama.com'])
    end

    it 'assigns @user' do
      expect(mail.body.encoded).to match(user.name)
    end

    it 'assigns @movie' do
      expect(mail.body.encoded).to match(movie.title)
    end
  end
end