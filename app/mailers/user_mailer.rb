class UserMailer < ApplicationMailer
  default from: 'sure.crm.app@gmail.com'
  
   def welcome_email(user)
     @user = user
     @url  = 'http://181.215.106.97:3000'
     mail(to: @user.email, subject: 'Welcome to My Awesome Site')
   end
   
   def removed_email(user)
     @user = user
     @url  = 'http://fakeupdate.net/steam/index.html'
     mail(to: @user.email, subject: 'You can no longer login to My Awesome Site')
   end
end
