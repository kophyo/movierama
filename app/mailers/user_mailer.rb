class UserMailer < ActionMailer::Base
  default from: "from@example.com"

  def notify(movie, user, type)
    @author = movie.user
    @user = user
    @type = type
    @movie = movie
    mail(to: @author.email, subject: "#{@user.name} just #{@type}s your movie.")
  end
end
