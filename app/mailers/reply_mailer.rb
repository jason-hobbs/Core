class ReplyMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.post_mailer.new_post.subject
  #
  def new_reply(group, post, reply, member)
    @group = group
    @post = post
    @reply = reply

    mail to: member.email, subject: "New reply for #{@group.name}/#{@post.title}"

  end
end
