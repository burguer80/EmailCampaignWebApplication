# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  URL_PATH = 'www.mensajeroexpress.com'
 # URL_PATH = 'localhost:3000'
  # Pick a unique cookie name to distinguish our session data from others'
  session :session_key => '_MMailer_session_id'
  

  
    def bodybuild(id)
    eflyer= Eflyer.find(id)
        eflyer.body = BODY1 + eflyer.costumer  + BODY11 + URL_PATH + "/eflyer/show/" + eflyer.id.to_s + BODY2 + eflyer.link +  BODY3 + eflyer.photo.public_filename +  BODY4 + BODY400 + eflyer.link + BODY40  + eflyer.link + BODY41 + eflyer.email + BODY42 + eflyer.email + BODY43 + BODY5
    eflyer.save
    redirect_to :controller => 'admin',:action  => 'eflyer_edit', :id => eflyer   
    end
  
    
  BODY1 ='<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>'
    
BODY11 =    '- mensajeroexpress.com</title>
<style type="text/css">
<!--
.style1 {
	font-family: Verdana, Arial, Helvetica, sans-serif;
	font-size: 12px;
}
.style3 {font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 12px; color: #999999; }
-->
</style>

</head>

<body>
<center>
<table width="603" border="0">
  <tr>
    <td align="center">
      <span class="style1"><a href="http://'


BODY2 = '" target="_blank" style="color:#000000; text-decoration:none">Si no puede visualizar este correo dar click aqu&iacute;</a></span>	
	  <br /><br />

<a href="http://'
  
  
BODY3 = '" target="_blank"><img src="http://' + URL_PATH 

    


BODY4 =   '" / border="0"><br/> </a>	  
<br />'
    
#----imagen

  def bodybuild2(id)
    eflyer= Eflyer.find(id)
        eflyer.body = BODY1 + eflyer.costumer  + BODY11 + URL_PATH + "/eflyer/show/" + eflyer.id.to_s + FLASH0 + eflyer.photo.public_filename +  FLASH1 + eflyer.photo.public_filename +  FLASH2 + BODY400 + eflyer.link + BODY40  + eflyer.link + BODY41 + eflyer.email + BODY42 + eflyer.email + BODY43 + BODY5
    eflyer.save
    redirect_to :controller => 'admin',:action  => 'eflyer_edit', :id => eflyer   
    end 
    
    
    
FLASH0 = '" target="_blank" style="color:#000000; text-decoration:none">Si no puede visualizar este correo dar click aqu&iacute;</a></span>	
	  <br /><br /><center><object classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" codebase="http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=7,0,19,0" width="603" height="408">
  <param name="movie" value="http://' + URL_PATH

FLASH1 ='" />

  <param name="quality" value="high" />
  <embed src="http://' + URL_PATH

FLASH2 = '" quality="high" pluginspage="http://www.macromedia.com/go/getflashplayer" type="application/x-shockwave-flash" width="603" height="408"></embed>
</object></center><br />'    
    
    
    
    
#----------------------------------------------------------------------Pie de pagina    

BODY400 = '<span class="style1"><a href="http://'

BODY40 = '/" target="_blank">'
    
    


    BODY41 = '</a><br/><br/>Cont&aacute;ctanos:<a href="mailto:'   



BODY42 = '" target="_blank">'
BODY43 ='</a>'    
    
    
    
    
    


BODY5 = '<br/><br/><br />

Env&iacute;e sus bolet&iacute;nes electr&oacute;nicos a sus clientes potenciales<br />
<a href="http://www.mensajeroexpress.com" target="_blank">www.mensajeroexpress.com</a><br />
cont&aacute;ctanos:<a href="mailto:contacto@mensajeroexpress.com" target="_blank">contacto@mensajeroexpress.com</a> <br />
</span>
<br />


<a href="http://www.mensajeroexpress.com" target="_blank"><img src="http://www.mensajeroexpress.com/images/logo_.jpg" / border="0"></a>
<span class="style1">

<br />

Si quiere que su mail sea extra&iacute;do de esta lista,,<br />
mande un correo a:<a href="mailto:cancelacion@mensajeroexpress.com" target="_blank">cancelacion@mensajeroexpress.com</a><br />
</span>
<br />
<br /><br />

</td>
  </tr>
</table></center>


</body>
</html>'
  

end
