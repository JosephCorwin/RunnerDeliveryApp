class AnonContactMailer < ApplicationMailer

  def anon_contact(data)
    @data = data
    byebug
    mail to: 'contact@runnerdeliveries.com', subject: "#{data[:full_name]} has this to say"
  end

end
