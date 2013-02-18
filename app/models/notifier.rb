class Notifier < ActionMailer::ARMailer

  
    def enviar(eflyer, contact,delay)
     @subject = eflyer.subject
     @recipients = contact.email
     @from = eflyer.from
     @sent_on = (delay).seconds.from_now
     #@body= eflyer.body
     @headers["X-User-ID" ] = contact.id
     @body["eflyer" ] = eflyer      
     
end

def survey(eflyer)
  @subject        ="Pragmatic Order: Give us your thoughts"
  @recipients     = "burguer@gmail.com"
  @from           = 'e-promo@mensajeroexpress.com'
  @sent_on        = Time.now
  @body["eflyer" ] = eflyer
end

def depurado(eflyer,contact,delay)
     @subject = 'Feliz navidad'
     @recipients = contact.email
     @from = 'Mensajero<e-promo@mensajeroexpress.com>'
     @sent_on = (delay).seconds.from_now
     #@body= eflyer.body
     @body["eflyer" ] = eflyer  
end



    
    
    
end
