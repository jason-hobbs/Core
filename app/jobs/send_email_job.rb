class SendEmailJob < ActiveJob::Base
  queue_as :default

  def perform(group, post, member)
    @group = group
    @post = post

    PostMailer.new_post(@group, @post, member).deliver_later
  end
end
