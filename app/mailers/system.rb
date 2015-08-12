class System < ApplicationMailer
  def email_name
    mail :subject => "Notificación del Sistema",
         :to      => "vanguard.com.mx@gmail.com",
         :from    => "no-reply@vanguard.com.mx"
  end
end
