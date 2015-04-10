class PostMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.post_mailer.new_post.subject
  #
  def new_post(group, post)
    @group = group
    @post = post

    mail to: "jason.hobbs@digisanctum.com", subject: "New post for #{@group.name}"

  end
end
