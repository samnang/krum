class NotifierMailer < ActionMailer::Base
  default :from => Krum.config.sender_email

  def new_group(group)
    @group = group
    
    mail to: Krum.config.recipient_email,
         subject: "Krum: New Group Request"
  end
end
