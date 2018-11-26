class EmailController < ApplicationController
 def email_form
 end
 
 def email_send
     mail = "::written_by_"+ params[:mail]
     email = params[:email]
     title = params[:title]
     content= params[:content]
     gmail = Gmail.connect("leegyul1015@gmail.com", "president2*")
     gmail.deliver do
         to email
         subject title
         text_part do
             body content + mail
         end
     end
     gmail.logout
     
     redirect_to :back
 end
end
