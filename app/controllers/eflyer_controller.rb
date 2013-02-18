class EflyerController < ApplicationController
caches_page :show

  def show
     
    @eflyer = Eflyer.find(params[:id])
     render(:layout => false) 
  rescue
    
  redirect_to "../" 
    
  end
  
  
def confirm_contact
 
                                            
  @n = Contact.find(:first, :conditions => "confirmation = '#{params[:id]}'")
  rescue
    
  redirect_to "../"
end

def unsuscribe_contact
  @n= Contact.find(:first, :conditions => "confirmation = '#{params[:confirmation]}'")
  @n.active = false
  @n.save
  
end

  def sign_up
    @categories = Category.find(:all, :order => 'name')
    @contact = Contact.new
       
  end
  
    def contact_create
    @contact = Contact.new(params[:contact])
    @contact.confirmation = generate_confirmation(@contact.email)
    @contact.category_id = params[:contact][:category_id]
    @contact.active = true
    @contact.tester = false
   if @contact.save
    render :text => 'Thanks, your address has been added to our email contact list.'
   else
     flash[:notice] = 'This record is already registered,or may be a problem in the format of the address. Try again!'
     redirect_to :action => 'sign_up'
   end
  end

   def redirect_to_sign_up
     
   end
  
end
