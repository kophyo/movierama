class UserMailer < ActionMailer::Base
  default from: "noreply@movierama.com"

  def notify(movie, user, type)
    @author = movie.user
    @user = user
    @type = type
    @movie = movie
    mail(to: @author.email, subject: "#{@user.name} just #{@type}d your movie.")
  end
end
