class AdminController < ApplicationController
  require 'csv'

  before_filter :check_authentication,  :except => [:login] 
  
  
  def check_authentication 
		  unless session[:user] 
		   session[:intended_action] = action_name 
		   session[:intended_controller] = controller_name 
		   redirect_to :action => "login" 
		  end       
		 end

  def login 
    #render :text => 'Actualizando Servidor'
    
	   @sslyn = request.ssl?  
	   if request.post? 
	     user = User.authenticate(params[:user][:login], params[:user][:salt])
	     if not user.nil?
	       session[:user] = user.id 
	       session[:intended_action] = 'index'  if ((session[:intended_action]) or (session[:intended_action] == 'login'))         
	       redirect_to :action => session[:intended_action], 
	                   :controller => session[:intended_controller]       
	     else
	       @user = User.new
	       flash[:notice] = 'Usuario no valido o la clave es incorrecta, favor de verificar'
	     end
	   else
	     @user = User.new
	   end 
  
           
  end  
  
  def signout
		  session[:user] = nil

		  redirect_to :action => 'login'
end
  
  
  ############################# fin Login
#  
#  def barrer
#    File.open('listado.txt','r'){|r|  @archivo=  r.read(nil)}
#      for linea in @archivo
#        n = Contact.new
#        n.email = linea.to(linea.length-2)
#        n.save
#      end
#  end
#  
#    def fixiar
#    xx = 0
#    contacts = Contact.find(:all, :conditions => "email like '%\r%'" )
#    for contact in contacts
#    
#        contact.email.gsub(/\r\n?/, "")
#        if contact.save       
#        xx =xx +1        
#      end   
#    
#    end
#    render :text => 'listo ' + xx.to_s + ' modificados'
#    
#  end
  
  def friltar
     @contact_pages, @contacts = paginate(:contact, :per_page => 20, :order => 'tester = true' )    
     
  end
  
  
  def contact_list
   case params[:filter]
      when nil then @contact_pages, @contacts = paginate(:contact, :per_page => 20, :order => 'email,name', :conditions => 'active = true' ) 
      when '1' then @contact_pages, @contacts = paginate(:contact, :per_page => 500, :order => 'email, name', :conditions => 'tester = true' )
      when '2' then @contact_pages, @contacts = paginate(:contact, :per_page => 500, :order => 'email, name', :conditions => 'active = false' )
    end
    
       
  end

  def contact_new
    @contact = Contact.new
    @categories = Category.find(:all, :order => 'name')    
  end

  def contact_createmany
     @categories = Category.find(:all, :order => 'name')
  end
  
  
  def contact_create
    @contact = Contact.new(params[:contact])
    @contact.confirmation = generate_confirmation(@contact.email) 
    if @contact.save
    redirect_to :action => 'contact_list'
    else
    redirect_to :action => 'contact_new'
    end
  end
  
  def contact_edit    
    @contact = Contact.find(params[:id])
    @categories = Category.find(:all,  :order => 'name')
  end
  
  def contact_update
         
      contact = Contact.find(params[:id])
      contact.update_attributes(params[:contact])
      redirect_to :action => 'contact_list'
  end
  
  def contact_destroy
    Contact.destroy(params[:id])
    redirect_to :action => 'contact_list'
  end
  

   ############################# fin contactos

  def eflyer_list
    
     @eflyer_pages, @eflyers = paginate(:eflyer, :per_page => 20, :order => 'created_at DESC' )  
  end

  def eflyer_new
    eflyer = Eflyer.new
    eflyer.costumer = "Nombre del Cliente"
    eflyer.name = "nombre del Eflyer"
    eflyer.subject = "Asunto"
    eflyer.email = "Email del cliente"
    eflyer.from = "Mensajero Express<e-promo@mensajeroexpress.com>"
    eflyer.link = "www.mensajeroexpress.com"
    eflyer.plain_text = "
====================================================
Mensajeroexpress.com  
====================================================
El texto del este correo no debera ser mayor a 60 caracteres
de ancho.
Este es un ejemplo de email en texto plano este texto sera 
desplegado en cualquier momento que el mensaje original no
se muestre en el cliente de correo.

Tips para mensajes en texto plano:
------------------------------------

** utilizar muchos simbolos como asteriscos.

** Utilizar marcadores visulaes como este para dividir
   secciones del correo.

** Las ligas no siempre estan activos para darle click.

** Hay que ser muy claros y explicitos.

** Utilizar solo texto que sea nocesario, y el correo no
   sea muy extenso.

------------------------------------

Para visitar nuestro sitio, escribe este URL en tu 
navegador de internet.
http://www.mensajeroexpress.com


Gracias ,

El equipo del mensajeroexpress.com


===================================================
===================================================
"
    eflyer.hold = false
    eflyer.save
       
         redirect_to :action => 'eflyer_edit', :id => eflyer
   

      
  end
  
  def eflyer_create
    eflyer = Eflyer.new(params[:eflyer])
    eflyer.save
    redirect_to :action => 'eflyer_list'
    
  end

  def eflyer_edit
    @eflyer = Eflyer.find(params[:id])
   
    @categories = Category.find(:all, :order => 'name')
    @owners = Owner.find(:all)
  end
  
  def eflyer_update
     eflyer = Eflyer.find(params[:id])
     eflyer.update_attributes(params[:eflyer])
      
           if eflyer.format == 1
             bodybuild(eflyer)
             
           else
             bodybuild2(eflyer)
           end

     expire_page(:controller => 'eflyer', :action => 'show', :id => eflyer)
   
     
  end
  
  def eflyer_show
    
    @eflyer = Eflyer.find(params[:id])
    render(:layout => false)   
  end

  
  
  def eflyer_destroy
    expire_page(:controller => 'eflyer', :action => 'show', :id => params[:id])
    Eflyer.destroy(params[:id])
    
    redirect_to :action => 'eflyer_list'
  end
  
   ############################# fin Eflyers
   
  def category_list
    
     @category_pages, @categories = paginate(:category, :per_page => 10 , :order => 'name')  
  end

  def category_new
     @category = Category.new
  end
  
  def category_create
   category = Category.new(params[:category])
    category.save
    redirect_to :action => 'category_list'
  end

  def category_edit
    @category = Category.find(params[:id])
  end
  
  def category_update
    category = Category.find(params[:id])
      category.update_attributes(params[:category])
      redirect_to :action => 'category_list'
  end
  
  def category_destroy
    Category.destroy(params[:id])
    redirect_to :action => 'category_list'
  end
  
   ############################# fin Cetegories
      
  def owner_list
     
     @owner_pages, @owners = paginate(:owner, :per_page => 10 )  
  end

  def owner_new
     @owner = Owner.new
  end
  
  def owner_create
   owner = Owner.new(params[:owner])
    owner.save
    redirect_to :action => 'owner_list'
  end

  def owner_edit
    @owner = Owner.find(params[:id])
  end
  
  def owner_update
    owner = Owner.find(params[:id])
      owner.update_attributes(params[:owner])
      redirect_to :action => 'owner_list'
  end
  
  def owner_destroy
    Owner.destroy(params[:id])
    redirect_to :action => 'owner_list'
  end
  
   ############################# fin Owners
         
  def zone_list
     
     @zone_pages, @zones = paginate(:zone, :per_page => 10 )  
  end

  def zone_new
     @zone = Zone.new
  end
  
  def zone_create
   zone = Zone.new(params[:zone])
   if zone.save
    redirect_to :action => 'zone_list'
   end
   
    
  end

  def zone_edit
    @zone = Zone.find(params[:id])
  end
  
  def zone_update
    zone = Zone.find(params[:id])
      zone.update_attributes(params[:zone])
      redirect_to :action => 'zone_list'
  end
  
  def zone_destroy
    Zone.destroy(params[:id])
    redirect_to :action => 'zone_list'
  end
  
    def zone_add
      @categories = Category.find(:all, :order => 'name')
      @zone = Zone.find(params[:id])
    end
    
    def zone_associate
       @categories = Category.find(:all, :order => 'name' )
      @zone = Zone.find(params[:id])
          checked_categories = []
          checked_params = params[:category_list] || []
    
          for check_box_id in checked_params
           category = Category.find(check_box_id)
            if not @zone.categories.include?(category)
              @zone.categories << category
            end
              checked_categories << category
          end
           
             missing_categories = @categories - checked_categories
    for category in missing_categories
      if @zone.categories.include?(category)
         @zone.categories.delete(category)
      end
    end       
      
      
           if @zone.save
      flash[:notice] = 'Zona a sido actualizado exitosamente.'
      
      
     
      redirect_to :action => 'zone_list', :id => @zone
    else
      render :action => 'zone_list'
    end
      
      
      
    end
  
   ############################# fin Zones
   def photo_new
     @eflyer = Eflyer.find(params[:id])
     @photo = Photo.new
   end
   
   def photo_list
     @photos = Photo.find(:all)
   end

   def photo_create
     
      photo = Photo.new(params[:photo])
      eflyer = Eflyer.find(params[:ideflyer])
      eflyer.photo = photo
      eflyer.format = params[:type].to_i
     if eflyer.save
           if eflyer.format == 1
             bodybuild(eflyer)
             
           else
             bodybuild2(eflyer)
           end
         
     else
       render :action => 'photo_new'
     end
   end
   
   def photo_destroy
     eflyer = Eflyer.find(params[:id])
     eflyer.photo.destroy
     redirect_to :action  => 'eflyer_edit', :id => eflyer     
   end
   


  
  
  
   ############################# fin Photos
   
   def user_list
      @users = User.find(:all)
     
     
   end
   
   def user_new
     @user = User.new
   end
   
   def user_create
     user = User.new(params[:user])
  user.password=user.salt
  if user.save
    flash[:notice] = 'Usuario was successfully created.'
    redirect_to :action => 'user_list'
  else
    render :action => 'new_user'
  end
   end
   
   
   def user_destroy
   User.destroy(params[:id])
   redirect_to :action => 'user_list'
   end
   
   
   
   
   
   
   
     ############################# fin Users
   
   
   
   
   
 def send_eflyer

      eflyer = Eflyer.find(params[:id])
      contacts= Contact.find(:all, :conditions => 'active = true and category_id = 1' , :order => 'email')
   #manda los mails
   mail_sender_procedure(contacts,eflyer)
    
     eflyer.hold = true
     eflyer.delivered_to =eflyer.delivered_to + contacts.length
     eflyer.save
   

      flash[:notice] ="ya se envio " + eflyer.name + " a " + contacts.length.to_s + " contactos" 
    redirect_to :action => 'eflyer_list'  
  end
  
#   def mail_parent(id)
#
#        eflyer = Eflyer.find(id)
#         mails = Email.find(:all, :conditions => "mail like '%#{eflyer.body}%' ")
#          for mail in mails
#            mail.eflyer_id = eflyer.id
#            mail.save
#          end
#   end
 
 def set_parent(id, confirmation)
   
  email = Email.find(:first, :order => 'id DESC', :limit => 1 )
  
  email.mail = confirm_mail_builder(email.mail,confirmation)

  email.eflyer_id = id
  email.save
 end
  
def mail_sender_procedure(contacts,eflyer)
  sec = 1.083333333
  delay = sec
  
   for contact in contacts
        email = Notifier.create_enviar(eflyer,contact,delay)
        email.content_transfer_encoding = 'base64'
      email.body = Base64.encode64(email.body) 


       Notifier.deliver(email)
       set_parent(eflyer.id, contact.confirmation)
       delay  = delay + sec
     end   
end  
 
 def send_test
   
      eflyer = Eflyer.find(params[:id])
      
   contacts= Contact.find(:all, :conditions => 'tester = true')
   #manda los mails
   
   mail_sender_procedure(contacts,eflyer)
   
     
    flash[:notice] ="ya se envio " + eflyer.name + " a " +  contacts.length.to_s + " contactos" 
    redirect_to :action => 'eflyer_list' 
  end
  
 
  def send_depurado
   
     eflyer = Eflyer.find(:first)
     # contacts= Contact.find(:all, :conditions => 'tester = true')
 contacts= Contact.find(:all, :conditions => 'active = true and category_id = 1' , :order => 'email')
   #manda los mails
  
    sec = 1.083333333
  delay = sec
   for contact in contacts
       email = Notifier.create_depurado(eflyer,contact,delay)
       Notifier.deliver(email)
     #  set_parent(eflyer.id, contact.confirmation)
       delay  = delay + sec
     end  
     
    render :text => "enviado"
  end
 

  
 
def probar
#x = "asd,dos,bussd@sdd.com,assdasd@fff.com,ultimo@ll.com"
x = params[:category][:name]

y = x.split(/,/)
i = 0
counter = 0
for row in y
     
  n = Contact.new
  y[i] = y[i].rstrip
  n.email = y[i].gsub(/\r\n?/, "") 
  n.active = 1
  n.category_id = params[:contact][:category_id]
  n.tester = 0
  n.confirmation = generate_confirmation(n.email) 
  i=i+1
  if n.save
  counter = counter + 1
  end
  
 
    
end

flash[:notice] ="se han dado <b>" +  counter.to_s + "</b> registros de alta"
  redirect_to :action => 'fix_strings'


end  

def contact_disable_it
#x = "asd,dos,bussd@sdd.com,assdasd@fff.com,ultimo@ll.com"
x = params[:category][:name]

y = x.split(/,/)
i = 0
counter = 0
for row in y
 # direccion = y[i] 
y[i] = y[i].gsub(/\r\n?/, "")
y[i] = y[i].rstrip 

  n = Contact.find(:first, :conditions => ["email LIKE ?", '%' + y[i] + '%'])
 if n != nil 
  n.active = 0
  n.email.chomp

  if n.save
  counter = counter + 1
  end
 end   
   i=i+1
end

flash[:notice] ="se han desabilitado <b>" +  counter.to_s + "</b> registros "
  redirect_to :action => 'contact_list'


end




  def contact_search
    
    session[:search] = params[:contact][:name]
    redirect_to :action => 'contact_result'
  end

  def contact_result
     @contact_pages, @contacts = paginate :contact, :order => 'tester,email DESC', :per_page => 40,:conditions =>  "(UPPER(email)  LIKE '#{session[:search].upcase}%') or " +
                                                 "(UPPER(email)  LIKE '%#{session[:search].upcase}') or " +
                                                 "(UPPER(email)  LIKE '%#{session[:search].upcase}%')"
                                                                                                   
  end

  
  def email_destroy

    Email.delete_all("eflyer_id = '#{params[:id]}'")
  
    redirect_to :action => 'admin_list'
  end
  

#def add_confirmation
#  x = 0
#  contacts = Contact.find(:all, :conditions => 'confirmation is NULL')
#  for contact in contacts
#  contact.confirmation = generate_confirmation(contact.email) 
#  if contact.save
#  x= x + 1 
#  end    
#  end
#    render :text =>  x.to_s + ' salvados'  
#  end




# comma

  def contacts_csvburguer80
  content_type = if request.user_agent =~ /windows/i
                   'application/vnd.ms-excel'
                 else
                   'text/csv'
                 end
  CSV::Writer.generate(output = "" ) do |csv|
    Contact.find(:all, :conditions => "active = false and email not like '%yahoo%'").each do |contact|
      csv << [contact.email]
    end
  end
  send_data(output,
              :type => content_type,
              :filename => "contactsincativejust.csv" )
end
#######################################

  
  
def fix_strings
  
   modif = 0 
   
  ### hotmail.com
  word = ['@hotamzail','@hotamail','@homail', '@hotail','@hoteil','@huamail', '@homail','@hotaiml','@homtail','@homtial','@homital','@hotmil','@homa','@hotnail','@hotnial','@hotial']
   x = 0
  word.length.times do     
      
    @contacts = Contact.find(:all, :conditions => "email like '%#{word[x-1]}%' and active = true") 
   if @contacts != nil
     for contact in @contacts
       contact.active = true
       contact.email[word[x-1]]= "@hotmail"

       contact.save
       modif = modif + 1
     end
    
   end
   x = x +1   

  end
  ### hotmail.com   
    ### yahoo.com
  word = ['@ahoo','@yaoo','@yhoo', '@yaohh','@yaooh','@yhaoo']
   x = 0
  word.length.times do     
      
    @contacts = Contact.find(:all, :conditions => "email like '%#{word[x-1]}%' and active = true") 
   if @contacts != nil
     for contact in @contacts
       contact.active = true
       contact.email[word[x-1]]= "@yahoo"

       contact.save
       modif = modif + 1
     end
    
   end
   x = x +1   

  end
  ### yahoo.com
      ### .com
  word = [',com','.comm.','.comcom', '.om.']
   x = 0
  word.length.times do     
      
    @contacts = Contact.find(:all, :conditions => "email like '%#{word[x-1]}%' and active = true") 
   if @contacts != nil
     for contact in @contacts
       contact.active = true
       contact.email[word[x-1]]= ".com"

       contact.save
       modif = modif + 1
     end
    
   end
   x = x +1   

  end
  ### ..com
     

 
render :text => modif.to_s

end

end
