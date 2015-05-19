class SendEmailJob2 < ActiveJob::Base
  queue_as :default

  def perform(group, post, reply, member)
    @group = group
    @post = post
    @reply = reply

    ReplyMailer.new_reply(@group, @post, @reply, member).deliver_later
  end
end
