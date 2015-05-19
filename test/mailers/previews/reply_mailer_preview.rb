# Preview all emails at http://localhost:3000/rails/mailers/post_mailer
class ReplyMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/reply_mailer/new_reply
  def new_reply
    group = Group.first
    post = group.posts.first
    reply = post.replies.first
    member = User.first
    ReplyMailer.new_reply(group, post, reply, member)
  end

end
