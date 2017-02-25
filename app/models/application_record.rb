class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
  
  # sign_in_and_redirect @user
  
  def after_sign_in_path_for(resource)
      sign_in_url = new_user_session_url
      if request.referer == sign_in_url
        super
      else
        stored_location_for(resource) || request.referer || root_path
      end
    end
    
  # def after_sign_in_path_for(resource)
  #  user(resource)
  # end
  

end
