Rails.application.routes.draw do

  get("/", { :controller => "application", :action => "index"})

  # Routes for the Meeting user resource:

  # CREATE
  post("/insert_meeting_user", { :controller => "meeting_users", :action => "create" })
          
  # READ
  get("/meeting_users", { :controller => "meeting_users", :action => "index" })
  
  get("/meeting_users/:path_id", { :controller => "meeting_users", :action => "show" })
  
  # UPDATE
  
  post("/modify_meeting_user/:path_id", { :controller => "meeting_users", :action => "update" })
  
  # DELETE
  get("/delete_meeting_user/:meeting_id/:user_id", { :controller => "meeting_users", :action => "destroy" })

  #------------------------------

  # Routes for the Meeting resource:

  # CREATE
  post("/insert_meeting", { :controller => "meetings", :action => "create" })
          
  # READ
  get("/meetings", { :controller => "meetings", :action => "index" })

  get("/meetings/restaurant/:path_id", { :controller => "meetings", :action => "from_restaurant" })

  get("/meetings/availabilities", { :controller => "meetings", :action => "available_requests"})

  get("/meetings/history", { :controller => "meetings", :action => "display_history"})

  get("/meetings/review/:path_id", { :controller => "meetings", :action => "review"})
  
  get("/meetings/:path_id", { :controller => "meetings", :action => "show" })

 

 
  
  # UPDATE
  
  post("/modify_meeting/:path_id", { :controller => "meetings", :action => "update" })
  
  # DELETE
  get("/delete_meeting/:path_id", { :controller => "meetings", :action => "destroy" })

  #------------------------------

  # Routes for the Cuisine restaurant resource:

  # CREATE
  post("/insert_cuisine_restaurant", { :controller => "cuisine_restaurants", :action => "create" })
          
  # READ
  get("/cuisine_restaurants", { :controller => "cuisine_restaurants", :action => "index" })
  
  get("/cuisine_restaurants/:path_id", { :controller => "cuisine_restaurants", :action => "show" })
  
  # UPDATE
  
  post("/modify_cuisine_restaurant/:path_id", { :controller => "cuisine_restaurants", :action => "update" })
  
  # DELETE
  get("/delete_cuisine_restaurant/:path_id", { :controller => "cuisine_restaurants", :action => "destroy" })

  #------------------------------

  # Routes for the Cuisine resource:

  # CREATE
  post("/insert_cuisine", { :controller => "cuisines", :action => "create" })
          
  # READ
  get("/cuisines", { :controller => "cuisines", :action => "index" })
  
  get("/cuisines/:path_id", { :controller => "cuisines", :action => "show" })
  
  # UPDATE
  
  post("/modify_cuisine/:path_id", { :controller => "cuisines", :action => "update" })
  
  # DELETE
  get("/delete_cuisine/:path_id", { :controller => "cuisines", :action => "destroy" })

  #------------------------------

  # Routes for the Restaurant resource:

  # CREATE
  post("/insert_restaurant", { :controller => "restaurants", :action => "create" })
          
  # READ
  get("/restaurants", { :controller => "restaurants", :action => "index" })
  
  get("/restaurants/:path_id", { :controller => "restaurants", :action => "show" })
  
  # UPDATE
  
  post("/modify_restaurant/:path_id", { :controller => "restaurants", :action => "update" })
  
  # DELETE
  get("/delete_restaurant/:path_id", { :controller => "restaurants", :action => "destroy" })

  #------------------------------

  # Routes for the User account:

  # SIGN UP FORM
  get("/user_sign_up", { :controller => "user_authentication", :action => "sign_up_form" })        
  # CREATE RECORD
  post("/insert_user", { :controller => "user_authentication", :action => "create"  })
      
  # EDIT PROFILE FORM        
  get("/edit_user_profile", { :controller => "user_authentication", :action => "edit_profile_form" })       
  # UPDATE RECORD
  post("/modify_user", { :controller => "user_authentication", :action => "update" })
  
  # DELETE RECORD
  get("/cancel_user_account", { :controller => "user_authentication", :action => "destroy" })

  # ------------------------------

  # SIGN IN FORM
  get("/user_sign_in", { :controller => "user_authentication", :action => "sign_in_form" })
  # AUTHENTICATE AND STORE COOKIE
  post("/user_verify_credentials", { :controller => "user_authentication", :action => "create_cookie" })
  
  # SIGN OUT        
  get("/user_sign_out", { :controller => "user_authentication", :action => "destroy_cookies" })
             
  #------------------------------

end
