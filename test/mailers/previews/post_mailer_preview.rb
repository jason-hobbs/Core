# Preview all emails at http://localhost:3000/rails/mailers/post_mailer
class PostMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/post_mailer/new_post
  def new_post
    group = Group.first
    post = group.posts.first
    member = User.first
    PostMailer.new_post(group, post, member)
  end

end
