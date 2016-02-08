require 'rails_helper'
require 'capybara/rails'
require 'support/pages/movie_list'
require 'support/with_user'

RSpec.describe 'vote on movies', type: :feature do

  let(:page) { Pages::MovieList.new }

  before do
    bob = User.create(
      uid:  'null|33333',
      name: 'Bob',
      email: 'bob@example.com'
    )
    Movie.create(
      title:        'Empire strikes back',
      description:  'Who\'s scruffy-looking?',
      date:         '1980-05-21',
      user:         bob
    )
  end

  with_logged_in_user

  before { page.open }
  context 'someone likes the movie' do
    it 'sends email to author' do
      page.like('Empire strikes back')
      expect(last_email.to).to eq(['bob@example.com'])
      expect(last_email.subject).to eq('John McFoo just liked your movie.')
      expect(last_email.body.encoded).to include("John McFoo just liked your movie 'Empire strikes back'")
    end
  end

  context 'someone hates the movie' do
    it 'sends email to author' do
      page.hate('Empire strikes back')
      expect(last_email.to).to eq(['bob@example.com'])
      expect(last_email.subject).to eq('John McFoo just hated your movie.')
      expect(last_email.body.encoded).to include("John McFoo just hated your movie 'Empire strikes back'")
    end
  end

  def last_email
    ActionMailer::Base.deliveries.last
  end
end



