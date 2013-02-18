module AdminHelper
     def ordered
        begin
 	@n =  Email.count(:group => :eflyer_id, :order => "1 DESC") 
 	@m = ""
 	@n.each {|key, value| @m = @m + " <tr><td>#{Eflyer.find(key).name}</td><td align ='center'>#{value}</td><td><a href='/admin/email_destroy/#{key}'>destroy</a></td></tr> "  } 	
 	result =@m
        end
        
     rescue 
       result ="Procesando correos. <br>Correos ingresados hasta este momento: <b>#{Email.count}</b>"
       
      end
end

   
    
