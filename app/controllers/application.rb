# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
   URL_PATH = 'www.mensajeroexpress.cn'
  #URL_PATH = 'localhost:3000'
  # Pick a unique cookie name to distinguish our session data from others'
  session :session_key => '_MMailer_session_id'
  
  def generate_confirmation(email)  
  #n = [Array.new(6){rand(256).chr}.join].pack("m").chomp
   n = Digest::SHA1.hexdigest("--#{Time.now.to_s}-#{email}---")[0,6]

  end
  
  
  def confirm_mail_builder(mail,confirmation)
    n = mail.insert(mail.index('&&--!>') + 17, 'http://' + URL_PATH + '/eflyer/confirm_contact/' + confirmation   ) 
    
  end

  
    def bodybuild(id)
    eflyer= Eflyer.find(id)
        eflyer.body = BODY1 + eflyer.costumer  + BODY11 + URL_PATH + "/eflyer/show/" + eflyer.id.to_s + BODY2 + eflyer.link +  BODY3 + eflyer.photo.public_filename +  BODY4 + eflyer.email + '">' + eflyer.email + BODY5
    eflyer.save
    redirect_to :controller => 'admin',:action  => 'eflyer_edit', :id => eflyer   
    end
  
    
  BODY1 ='<html>
<head>
<title>'
    
BODY11 =    '- mensajeroexpress.com</title>

</head>
<body leftmargin="0" marginwidth="0" topmargin="0" marginheight="0" offset="0" bgcolor="#FFFFFF" >
<table width="100%" cellpadding="10" cellspacing="0" class="backgroundTable" bgcolor="#FFFFF" >
<tr>
<td valign="top" align="center">

<table width="600" cellpadding="0" cellspacing="0"align="center" >
<tr>
<td style="border-top: 12px solid rgb(255, 255, 255); background-color: rgb(255, 255, 255);" valign="top" align="center">
<span style="font-size: 16px; color: rgb(0,0,0); line-height: 100%; font-family: verdana;">

Realiza tu posada de una manera original este a&ntilde;o en las Carnes Steak<br> 
con los paquetes atractivos que hemos creado para tu evento<br>
<br><br>


</span>
</td>
</tr>

<tr>
<td style="font-size:12px;background-color:#FFFFFF;border-top:0px solid #000000;border-bottom:0px solid #FFFFFF;text-align:center;" align="left">
<a href="http://'


BODY2 = '" target="_blank" style="color:#000000; text-decoration:none">Si no puede visualizar este correo dar click aqu&iacute;</a></td>

</tr><tr>
<td style="background-color:#FFFFFF;border-top:0px solid #FFFFFF;border-bottom:0px solid #333333;"><center><a href="http://'
  
  
BODY3 = '" target="_blank"><img src="http://' + URL_PATH 

    


BODY4 =   '"  border="0" ></a></center></td>
</tr>
</table>

<table  cellpadding="20" cellspacing="0" bgcolor="#FFFFFF">



<tr>
<td style="background-color:#FFFFFF;border-top:12px solid #FFFFFF;" valign="top" align="center">
<span style="font-size:12px;color:#333333;line-height:100%;font-family:verdana;">
Cont&aacute;ctanos: <a href="mailto:'
    
BODY5 = '</a>
<br />
<br />
<br />
<br />
Env&iacute;e sus bolet&iacute;nes electr&oacute;nicos a sus clientes potenciales<br /><br />
<a href="http://www.mensajeroexpress.com" target="_blank">www.mensajeroexpress.com</a><br /><br />
cont&aacute;ctanos:<a href="mailto:contacto@mensajeroexpress.com" target="_blank">contacto@mensajeroexpress.com</a>
<br />

<br />
<a href="http://www.mensajeroexpress.com" target="_blank"><img src="http://www.mensajeroexpress.com/images/logo_.jpg" / border="0"></a>
<br />
<br />

  
</span>
</td>
</tr>
<tr>
<td style="background-color:#FFFFFF;border-top:12px solid #FFFFFF;" valign="top" align="center">
<span style="font-size:12px;color:#B2B2B2;line-height:100%;font-family:verdana;">

Mensajero Express es una empresa mexicana especializada en env&iacute;o de mensajes<br /> 
a trav&eacute;s de Internet en la rep&uacute;blica Mexicana, que actualmente cuenta con una base<br />
 de datos de m&aacute;s de 12 millones de direcciones activas divididas en zonas geogr&aacute;ficas<br />
 de toda la rep&uacute;blica Mexicana. Este servicio que ofrecemos es una forma de incrementar<br />
 las ventas de su negocio y darse a conocer de manera masiva entre los consumidores es <br />
ideal para anunciar todos los productos y servicios  que tenga su negocio y es hoy por hoy,<br />
 una de las mejores y m&aacute;s econ&oacute;micas formas de comunicar al p&uacute;blico consumidor sus<br />
 mensajes, con lo cual llegar&aacute; a sus clientes de una forma r&aacute;pida y segura.</span> 
<span style="font-size:12px;color:#B2B2B2;line-height:100%;font-family:verdana;">
<br />S&iacute; ya usted
 no desea seguir recibiendo informaci&oacute;n  <br> 
&oacute; promociones presione:<br>
 <!--unsuscribe&&--!><a href="" style="font-size:12px;color:#B2B2B2;line-height:100%;font-family:verdana;" target="_blank">este enlace</a>.
 
</span>
</td>
</tr>

</table>


</td>
</tr>

</table>


</body>
</html>'
    


end
