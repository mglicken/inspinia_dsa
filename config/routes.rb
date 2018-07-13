Myapp::Application.routes.draw do

  devise_for :users

 # You can have the root of your site routed with "root"
  root 'people#user_dashboard'

  get "/admin/", :controller => "accesses", :action => "admin"
  get "/models/", :controller => "people", :action => "models"
  get "/download/:id", :controller => "accesses", :action => "download_data"
  get "/dashboard/", :controller => "people", :action => "user_dashboard"
  get "/access_dashboard/", :controller => "people", :action => "access_dashboard"
  
  # Routes for the Access resource:
  resources :accesses do
    collection {post :import}
  end
  # CREATE
  get "/accesses/new", :controller => "accesses", :action => "new"
  get "/user/new", :controller => "accesses", :action => "new_user"
  post "/create_access", :controller => "accesses", :action => "create"
  post '/create_user_7tiZNpQdP7XnFuIuRUSx8l9h6HffrOZIRoHqQ7krtLOakdXuc9', :controller => "accesses", :action => "create_user"


  # READ
  get "/accesses", :controller => "accesses", :action => "index"
  get "/accesses/:id", :controller => "accesses", :action => "show"

  # UPDATE
  get "/accesses/:id/edit", :controller => "accesses", :action => "edit"
  post "/update_access/:id", :controller => "accesses", :action => "update"

  # DELETE
  get "/delete_access/:id", :controller => "accesses", :action => "destroy"

  # Routes for the Advisor Types resource:
  resources :advisor_types do
    collection {post :import}
  end  
  # CREATE
  get "/advisor_types/new", :controller => "advisor_types", :action => "new"
  post "/create_advisor_type", :controller => "advisor_types", :action => "create"

  # READ
  get "/advisor_types", :controller => "advisor_types", :action => "index"
  get "/advisor_types/:id", :controller => "advisor_types", :action => "show"

  # UPDATE
  get "/advisor_types/:id/edit", :controller => "advisor_types", :action => "edit"
  post "/update_advisor_type/:id", :controller => "advisor_types", :action => "update"

  # DELETE
  get "/delete_advisor_type/:id", :controller => "advisor_types", :action => "destroy"

  # Routes for the Bucket resource:
  resources :buckets do
    collection {post :import}
  end
  # CREATE
  get "/buckets/new", :controller => "buckets", :action => "new"
  post "/create_bucket", :controller => "buckets", :action => "create"

  # READ
  get "/", :controller => "buckets", :action => "index"
  get "/buckets", :controller => "buckets", :action => "index"
  get "/buckets/:id", :controller => "buckets", :action => "show"
  get "/bucket_search/:search", :controller => "buckets", :action => "search"

  # UPDATE
  get "/buckets/:id/edit", :controller => "buckets", :action => "edit"
  post "/update_bucket/:id", :controller => "buckets", :action => "update"

  # DELETE
  get "/delete_bucket/:id", :controller => "buckets", :action => "destroy"

  # Routes for the CIP resource:
  resources :cips do
    collection {
      post :import
      post :import_acquirers
      post :show_acquirers      
    }
  end
  # CREATE
  get "/cips/new", :controller => "cips", :action => "new"
  post "/create_cip", :controller => "cips", :action => "create"
  get "/copy_cip_layout/:cip_id/", :controller => "cips", :action => "copy_layout"

  # READ
  get "/cips", :controller => "cips", :action => "index"
  get "/cips/:id", :controller => "cips", :action => "show"
  get "/cip_search/:search", :controller => "cips", :action => "search"
  get "/cips/:id/sponsors", :controller => "cips", :action => "show_sponsors"
  get "/cips/:id/companies", :controller => "cips", :action => "show_companies"
  get "/cips/:id/acquirers", :controller => "cips", :action => "show_acquirers"
  get "/cips/:id/advisors", :controller => "cips", :action => "show_advisors"

  # UPDATE
  get "/cips/:id/edit", :controller => "cips", :action => "edit"
  post "/update_cip/:id", :controller => "cips", :action => "update"

  # DELETE
  get "/delete_cip/:id", :controller => "cips", :action => "destroy"

# Routes for the CIP_Slides resource:
  resources :cip_slides do
    collection {post :import}
  end
  # CREATE
  get "/cip_slides/new", :controller => "cip_slides", :action => "new"
  post "/create_cip_slide", :controller => "cip_slides", :action => "create"
  # READ
  get "/cip_slides", :controller => "cip_slides", :action => "index"
  get "/cip_slides/:id", :controller => "cip_slides", :action => "show"

  # UPDATE
  get "/cip_slides/:id/edit", :controller => "cip_slides", :action => "edit"
  post "/update_cip_slide/:id", :controller => "cip_slides", :action => "update"

  # DELETE
  get "/delete_cip_slide/:id", :controller => "cip_slides", :action => "destroy"

# Routes for the CIP Sponsors resource:
  resources :cip_sponsors do
    collection {post :import}
  end  
  # CREATE
  get "/cip_sponsors/new", :controller => "cip_sponsors", :action => "new"
  post "/create_cip_sponsor", :controller => "cip_sponsors", :action => "create"
  post "/create_cip_sponsor/:cip_id/", :controller => "cip_sponsors", :action => "create_by_name"
  
  # READ
  get "/cip_sponsors", :controller => "cip_sponsors", :action => "index"
  get "/cip_sponsors/:id", :controller => "cip_sponsors", :action => "show"

  # UPDATE
  get "/cip_sponsors/:id/edit", :controller => "cip_sponsors", :action => "edit"
  post "/update_cip_sponsor/:id", :controller => "cip_sponsors", :action => "update"
  get "/update_cip_sponsor/:id/:status", :controller => "cip_sponsors", :action => "update_status"

  # DELETE
  get "/delete_cip_sponsor/:id", :controller => "cip_sponsors", :action => "destroy"

  # Routes for the CIP Companies resource:
  resources :cip_companies do
    collection {post :import}
  end  
  # CREATE
  get "/cip_companies/new", :controller => "cip_companies", :action => "new"
  post "/create_cip_company", :controller => "cip_companies", :action => "create"
  post "/create_cip_company/:cip_id/", :controller => "cip_companies", :action => "create_by_name"  
  # READ
  get "/cip_companies", :controller => "cip_companies", :action => "index"
  get "/cip_companies/:id", :controller => "cip_companies", :action => "show"

  # UPDATE
  get "/cip_companies/:id/edit", :controller => "cip_companies", :action => "edit"
  post "/update_cip_company/:id", :controller => "cip_companies", :action => "update"
  get "/update_cip_company/:id/:status", :controller => "cip_companies", :action => "update_status"
 
  # DELETE
  get "/delete_cip_company/:id", :controller => "cip_companies", :action => "destroy"

# Routes for the Case_Studies resource:
  resources :case_studies do
    collection {post :import}
  end
  # CREATE
  get "/case_studies/new", :controller => "case_studies", :action => "new"
  post "/create_case_study", :controller => "case_studies", :action => "create"
  get "/copy_case_study_layout/:case_study_id/", :controller => "case_studies", :action => "copy_layout"

  # READ
  get "/case_studies", :controller => "case_studies", :action => "index"
  get "/case_studies/:id", :controller => "case_studies", :action => "show"

  # UPDATE
  get "/case_studies/:id/edit", :controller => "case_studies", :action => "edit"
  post "/update_case_study/:id", :controller => "case_studies", :action => "update"

  # DELETE
  get "/delete_case_study/:id", :controller => "case_studies", :action => "destroy"

  # Routes for the Case Study Slides resource:
  resources :case_study_slides do
    collection {post :import}
  end
  # CREATE
  get "/case_study_slides/new", :controller => "case_study_slides", :action => "new"
  post "/create_case_study_slide", :controller => "case_study_slides", :action => "create"
  # READ
  get "/case_study_slides", :controller => "case_study_slides", :action => "index"
  get "/case_study_slides/:id", :controller => "case_study_slides", :action => "show"

  # UPDATE
  get "/case_study_slides/:id/edit", :controller => "case_study_slides", :action => "edit"
  post "/update_case_study_slide/:id", :controller => "case_study_slides", :action => "update"

  # DELETE
  get "/delete_case_study_slide/:id", :controller => "case_study_slides", :action => "destroy"

  # Routes for the Company resource:
  resources :companies do
    collection {post :import}
  end  
  # CREATE
  get "/companies/new", :controller => "companies", :action => "new"
  post "/create_company", :controller => "companies", :action => "create"
  post "/create_subsidiary", :controller => "companies", :action => "create_subsidiary"
  get "/follow_company/:company_id/", :controller => "companies", :action => "follow"

  # READ
  get "/companies", :controller => "companies", :action => "index"
  get "/nbp_company_query/:bucket_id/bucket", :controller => "companies", :action => "nbp_index_query"
  get "/company_query", :controller => "companies", :action => "index_query"  
  get "/companies/:id", :controller => "companies", :action => "show"
  get "/company_search/:search", :controller => "companies", :action => "search"

  # UPDATE
  get "/companies/:id/edit", :controller => "companies", :action => "edit"
  post "/update_company/:id", :controller => "companies", :action => "update"

  # DELETE
  get "/delete_company/:id", :controller => "companies", :action => "destroy"
  get "/delete_company/:id", :controller => "companies", :action => "destroy"
  get "/unfollow_company/:id", :controller => "companies", :action => "unfollow"
 
  # Routes for the Company Follows resource:
  resources :company_follows do
    collection {post :import}
  end
  # CREATE
  get "/company_follows/new", :controller => "company_follows", :action => "new"
  post "/create_company_follow", :controller => "company_follows", :action => "create"
  # READ
  get "/company_follows", :controller => "company_follows", :action => "index"
  get "/company_follows/:id", :controller => "company_follows", :action => "show"

  # UPDATE
  get "/company_follows/:id/edit", :controller => "company_follows", :action => "edit"
  post "/update_company_follow/:id", :controller => "company_follows", :action => "update"

  # DELETE
  get "/delete_company_follow/:id", :controller => "company_follows", :action => "destroy"

  # Routes for the Company Notes resource:
  resources :company_notes do
    collection {post :import}
  end
  # CREATE
  get "/company_notes/new", :controller => "company_notes", :action => "new"
  post "/create_company_note", :controller => "company_notes", :action => "create"
  # READ
  get "/company_notes", :controller => "company_notes", :action => "index"
  get "/company_notes/:id", :controller => "company_notes", :action => "show"

  # UPDATE
  get "/company_notes/:id/edit", :controller => "company_notes", :action => "edit"
  post "/update_company_note/:id", :controller => "company_notes", :action => "update"

  # DELETE
  get "/delete_company_note/:id", :controller => "company_notes", :action => "destroy"

  # Routes for the Deal resource:
  resources :deals do
    collection {post :import}
  end  

  # CREATE
  get "/deals/new", :controller => "deals", :action => "new"
  post "/create_deal", :controller => "deals", :action => "create"

  # READ
  get "/", :controller => "deals", :action => "index"
  get "/deals", :controller => "deals", :action => "index"
  get "/deals/:id", :controller => "deals", :action => "show"
  get "/deal_search/:search", :controller => "deals", :action => "search"

  # UPDATE
  get "/deals/:id/edit", :controller => "deals", :action => "edit"
  post "/update_deal/:id", :controller => "deals", :action => "update"

  # DELETE
  get "/delete_deal/:id", :controller => "deals", :action => "destroy"


# DASHBOARD
  get "/dashboard/", :controller => "people", :action => "dashboard"

  post "/search/", :controller => "deals", :action => "search_all"

  # Routes for the Deal Follows resource:
  resources :deal_follows do
    collection {post :import}
  end
  # CREATE
  get "/deal_follows/new", :controller => "deal_follows", :action => "new"
  post "/create_deal_follow", :controller => "deal_follows", :action => "create"
  # READ
  get "/deal_follows", :controller => "deal_follows", :action => "index"
  get "/deal_follows/:id", :controller => "deal_follows", :action => "show"

  # UPDATE
  get "/deal_follows/:id/edit", :controller => "deal_follows", :action => "edit"
  post "/update_deal_follow/:id", :controller => "deal_follows", :action => "update"

  # DELETE
  get "/delete_deal_follow/:id", :controller => "deal_follows", :action => "destroy"

# Routes for the Deal_People resource:
  resources :deal_people do
    collection {post :import}
  end
  # CREATE
  get "/deal_people/new", :controller => "deal_people", :action => "new"
  get "/create_deal_person/:deal_id/:person_id", :controller => "deal_people", :action => "create"
  post "/create_deal_person", :controller => "deal_people", :action => "create"
  
  # READ
  get "/deal_people", :controller => "deal_people", :action => "index"
  get "/deal_people/:id", :controller => "deal_people", :action => "show"

  # UPDATE
  get "/deal_people/:id/edit", :controller => "deal_people", :action => "edit"
  post "/update_deal_person/:id", :controller => "deal_people", :action => "update"

  # DELETE
  get "/delete_deal_person/:id", :controller => "deal_people", :action => "destroy"

 # Routes for the Deal Stages resource:
  resources :deal_stages do
    collection {post :import}
  end  
  # CREATE
  get "/deal_stages/new", :controller => "deal_stages", :action => "new"
  post "/create_deal_stage", :controller => "deal_stages", :action => "create"

  # READ
  get "/deal_stages", :controller => "deal_stages", :action => "index"
  get "/deal_stages/:id", :controller => "deal_stages", :action => "show"

  # UPDATE
  get "/deal_stages/:id/edit", :controller => "deal_stages", :action => "edit"
  post "/update_deal_stage/:id", :controller => "deal_stages", :action => "update"

  # DELETE
  get "/delete_deal_stage/:id", :controller => "deal_stages", :action => "destroy"

   # Routes for the Deal Types resource:
  resources :deal_types do
    collection {post :import}
  end  
  # CREATE
  get "/deal_types/new", :controller => "deal_types", :action => "new"
  post "/create_deal_type", :controller => "deal_types", :action => "create"

  # READ
  get "/deal_types", :controller => "deal_types", :action => "index"
  get "/deal_types/:id", :controller => "deal_types", :action => "show"

  # UPDATE
  get "/deal_types/:id/edit", :controller => "deal_types", :action => "edit"
  post "/update_deal_type/:id", :controller => "deal_types", :action => "update"

  # DELETE
  get "/delete_deal_type/:id", :controller => "deal_types", :action => "destroy"

  # Routes for the Diligence Advisor resource:
  resources :diligence_advisors do
    collection {post :import}
  end  
  # CREATE
  get "/diligence_advisors/new", :controller => "diligence_advisors", :action => "new"
  post "/create_diligence_advisor", :controller => "diligence_advisors", :action => "create"

  # READ
  get "/diligence_advisors", :controller => "diligence_advisors", :action => "index"
  get "/diligence_advisors/:id", :controller => "diligence_advisors", :action => "show"

  # UPDATE
  get "/diligence_advisors/:id/edit", :controller => "diligence_advisors", :action => "edit"
  post "/update_diligence_advisor/:id", :controller => "diligence_advisors", :action => "update"

  # DELETE
  get "/delete_diligence_advisor/:id", :controller => "diligence_advisors", :action => "destroy"

  # Routes for the Favorite_Slide resource:
  resources :favorite_slides do
    collection {post :import}
  end
  # CREATE
  get "/favorite_slides/new", :controller => "favorite_slides", :action => "new"
  get "/create_favorite_slide/:user_id/:slide_id", :controller => "favorite_slides", :action => "create"
  post "/create_favorite_slide", :controller => "favorite_slides", :action => "create"
  
  # READ
  get "/favorite_slides", :controller => "favorite_slides", :action => "index"
  get "/favorite_slides/:id", :controller => "favorite_slides", :action => "show"

  # UPDATE
  get "/favorite_slides/:id/edit", :controller => "favorite_slides", :action => "edit"
  post "/update_favorite_slide/:id", :controller => "favorite_slides", :action => "update"

  # DELETE
  get "/destroy_favorite_slide/:id", :controller => "favorite_slides", :action => "destroy"

 # Routes for the Fund resource:
  resources :funds do
    collection {post :import}
  end  
  # CREATE
  get "/funds/new", :controller => "funds", :action => "new"
  post "/create_fund", :controller => "funds", :action => "create"

  # READ
  get "/funds", :controller => "funds", :action => "index"
  get "/funds/:id", :controller => "funds", :action => "show"
  get "/fund_search/:search", :controller => "funds", :action => "search"

  # UPDATE
  get "/funds/:id/edit", :controller => "funds", :action => "edit"
  post "/update_fund/:id", :controller => "funds", :action => "update"

  # DELETE
  get "/delete_fund/:id", :controller => "funds", :action => "destroy"

# Routes for the Fund Companies resource:
  resources :fund_companies do
    collection {post :import}
  end
  # CREATE
  get "/fund_companies/new", :controller => "fund_companies", :action => "new"
  get "/create_fund_company/:fund_id/:company_id", :controller => "fund_companies", :action => "create"
  post "/create_fund_company", :controller => "fund_companies", :action => "create"
  
  # READ
  get "/fund_companies", :controller => "fund_companies", :action => "index"
  get "/fund_companies/:id", :controller => "fund_companies", :action => "show"

  # UPDATE
  get "/fund_companies/:id/edit", :controller => "fund_companies", :action => "edit"
  post "/update_fund_company/:id", :controller => "fund_companies", :action => "update"

  # DELETE
  get "/delete_fund_company/:id", :controller => "fund_companies", :action => "destroy"

  # Routes for the Highlights resource:
  resources :highlights do
    collection {post :import}
  end  
  # CREATE
  get "/highlights/new", :controller => "highlights", :action => "new"
  post "/create_highlight", :controller => "highlights", :action => "create"

  # READ
  get "/highlights", :controller => "highlights", :action => "index"
  get "/highlights/:id", :controller => "highlights", :action => "show"

  # UPDATE
  get "/highlights/:id/edit", :controller => "highlights", :action => "edit"
  post "/update_highlight/:id", :controller => "highlights", :action => "update"

  # DELETE
  get "/delete_highlight/:id", :controller => "highlights", :action => "destroy"

  # Routes for the IOIs resource:
  resources :iois do
    collection {post :import}
  end  
  # CREATE
  get "/iois/new", :controller => "iois", :action => "new"
  post "/create_ioi", :controller => "iois", :action => "create"

  # READ
  get "/iois", :controller => "iois", :action => "index"
  get "/iois/:id", :controller => "iois", :action => "show"

  # UPDATE
  get "/iois/:id/edit", :controller => "iois", :action => "edit"
  post "/update_ioi/:id", :controller => "iois", :action => "update"
  post "/update_ioi_and_highlights/", :controller => "iois", :action => "update_ioi_and_highlights" 

  # DELETE
  get "/delete_ioi/:id", :controller => "iois", :action => "destroy"

  # Routes for the IOI Highlights resource:
  resources :ioi_highlights do
    collection {post :import}
  end
  # CREATE
  get "/ioi_highlights/new", :controller => "ioi_highlights", :action => "new"
  post "/create_ioi_highlight", :controller => "ioi_highlights", :action => "create"
  get "/ioi_highlight_checkbox/:highlight_id/:cip_id/:type_id/:status", :controller => "ioi_highlights", :action => "checkbox"
  
  # READ
  get "/ioi_highlights", :controller => "ioi_highlights", :action => "index"
  get "/ioi_highlights/:id", :controller => "ioi_highlights", :action => "show"

  # UPDATE
  get "/ioi_highlights/:id/edit", :controller => "ioi_highlights", :action => "edit"
  post "/update_ioi_highlight/:id", :controller => "ioi_highlights", :action => "update"

  # DELETE
  get "/delete_ioi_highlight/:id", :controller => "ioi_highlights", :action => "destroy"
  
  # Routes for the IOI Slides resource:
  resources :ioi_slides do
    collection {post :import}
  end
  # CREATE
  get "/ioi_slides/new", :controller => "ioi_slides", :action => "new"
  post "/create_ioi_slide", :controller => "ioi_slides", :action => "create"
  # READ
  get "/ioi_slides", :controller => "ioi_slides", :action => "index"
  get "/ioi_slides/:id", :controller => "ioi_slides", :action => "show"

  # UPDATE
  get "/ioi_slides/:id/edit", :controller => "ioi_slides", :action => "edit"
  post "/update_ioi_slide/:id", :controller => "ioi_slides", :action => "update"

  # DELETE
  get "/delete_ioi_slide/:id", :controller => "ioi_slides", :action => "destroy"

  # Routes for the LOIs resource:
  resources :lois do
    collection {post :import}
  end  
  # CREATE
  get "/lois/new", :controller => "lois", :action => "new"
  post "/create_loi", :controller => "lois", :action => "create"

  # READ
  get "/lois", :controller => "lois", :action => "index"
  get "/lois/:id", :controller => "lois", :action => "show"

  # UPDATE
  get "/lois/:id/edit", :controller => "lois", :action => "edit"
  post "/update_loi/:id", :controller => "lois", :action => "update"
  post "/update_loi_and_highlights/", :controller => "lois", :action => "update_loi_and_highlights" 

  # DELETE
  get "/delete_loi/:id", :controller => "lois", :action => "destroy"

  # Routes for the LOI Highlights resource:
  resources :loi_highlights do
    collection {post :import}
  end
  # CREATE
  get "/loi_highlights/new", :controller => "loi_highlights", :action => "new"
  post "/create_loi_highlight", :controller => "loi_highlights", :action => "create"
  get "/loi_highlight_checkbox/:highlight_id/:mp_id/:type_id/:status", :controller => "loi_highlights", :action => "checkbox"
  
  # READ
  get "/loi_highlights", :controller => "loi_highlights", :action => "index"
  get "/loi_highlights/:id", :controller => "loi_highlights", :action => "show"

  # UPDATE
  get "/loi_highlights/:id/edit", :controller => "loi_highlights", :action => "edit"
  post "/update_loi_highlight/:id", :controller => "loi_highlights", :action => "update"

  # DELETE
  get "/delete_loi_highlight/:id", :controller => "loi_highlights", :action => "destroy"
  
  # Routes for the LOI Slides resource:
  resources :loi_slides do
    collection {post :import}
  end
  # CREATE
  get "/loi_slides/new", :controller => "loi_slides", :action => "new"
  post "/create_loi_slide", :controller => "loi_slides", :action => "create"
  # READ
  get "/loi_slides", :controller => "loi_slides", :action => "index"
  get "/loi_slides/:id", :controller => "loi_slides", :action => "show"

  # UPDATE
  get "/loi_slides/:id/edit", :controller => "loi_slides", :action => "edit"
  post "/update_loi_slide/:id", :controller => "loi_slides", :action => "update"

  # DELETE
  get "/delete_loi_slide/:id", :controller => "loi_slides", :action => "destroy"

  # Routes for the NBP resource:
  resources :nbps do
    collection {
      post :import
      post :import_acquirers
      post :show_sponsors
      post :show_companies        
    }
  end
  # CREATE
  get "/nbps/new", :controller => "nbps", :action => "new"
  post "/create_nbp", :controller => "nbps", :action => "create"
  get "/copy_nbp_layout/:nbp_id/", :controller => "nbps", :action => "copy_layout"

  # READ
  get "/nbps", :controller => "nbps", :action => "index"
  get "/nbps/:id", :controller => "nbps", :action => "show"
  get "/nbps/:id/sponsors", :controller => "nbps", :action => "show_sponsors"
  get "/nbps/:id/companies", :controller => "nbps", :action => "show_companies"
  get "/nbp_search/:search", :controller => "nbps", :action => "search"

  # UPDATE
  get "/nbps/:id/edit", :controller => "nbps", :action => "edit"
  post "/update_nbp/:id", :controller => "nbps", :action => "update"

  # DELETE
  get "/delete_nbp/:id", :controller => "nbps", :action => "destroy"

  # Routes for the NBP Companies resource:
  resources :nbp_companies do
    collection {post :import}
  end  
  # CREATE
  get "/nbp_companies/new", :controller => "nbp_companies", :action => "new"
  post "/create_nbp_company", :controller => "nbp_companies", :action => "create"
  post "/create_nbp_company/:nbp_id/", :controller => "nbp_companies", :action => "create_by_name"
  
  # READ
  get "/nbp_companies", :controller => "nbp_companies", :action => "index"
  get "/nbp_companies/:id", :controller => "nbp_companies", :action => "show"

  # UPDATE
  get "/nbp_companies/:id/edit", :controller => "nbp_companies", :action => "edit"
  post "/update_nbp_company/:id", :controller => "nbp_companies", :action => "update"
  get "/update_nbp_companies/:layouts", :controller => "nbp_companies", :action => "update_nbp_companies"

  # DELETE
  get "/delete_nbp_company/:id", :controller => "nbp_companies", :action => "destroy"

  # Routes for the NBP_Slides resource:
  resources :nbp_slides do
    collection {post :import}
  end
  # CREATE
  get "/nbp_slides/new", :controller => "nbp_slides", :action => "new"
  post "/create_nbp_slide", :controller => "nbp_slides", :action => "create"

  # READ
  get "/nbp_slides", :controller => "nbp_slides", :action => "index"
  get "/nbp_slides/:id", :controller => "nbp_slides", :action => "show"

  # UPDATE
  get "/nbp_slides/:id/edit", :controller => "nbp_slides", :action => "edit"
  post "/update_nbp_slide/:id", :controller => "nbp_slides", :action => "update"

  # DELETE
  get "/delete_nbp_slide/:id", :controller => "nbp_slides", :action => "destroy"

  # Routes for the NBP Sponsors resource:
  resources :nbp_sponsors do
    collection {post :import}
  end  
  # CREATE
  get "/nbp_sponsors/new", :controller => "nbp_sponsors", :action => "new"
  post "/create_nbp_sponsor", :controller => "nbp_sponsors", :action => "create"
  post "/create_nbp_sponsor/:nbp_id/", :controller => "nbp_sponsors", :action => "create_by_name"

  # READ
  get "/nbp_sponsors", :controller => "nbp_sponsors", :action => "index"
  get "/nbp_sponsors/:id", :controller => "nbp_sponsors", :action => "show"

  # UPDATE
  get "/nbp_sponsors/:id/edit", :controller => "nbp_sponsors", :action => "edit"
  post "/update_nbp_sponsor/:id", :controller => "nbp_sponsors", :action => "update"

  # DELETE
  get "/delete_nbp_sponsor/:id", :controller => "nbp_sponsors", :action => "destroy"

  # Routes for the NBP Tags resource:
  resources :nbp_tags do
    collection {post :import}
  end
  # CREATE
  get "/nbp_tags/new", :controller => "nbp_tags", :action => "new"
  post "/create_nbp_tag", :controller => "nbp_tags", :action => "create"
  post "/create_nbp_tag/:nbp_id", :controller => "nbp_tags", :action => "create_by_name"
  
  # READ
  get "/nbp_tags", :controller => "nbp_tags", :action => "index"
  get "/nbp_tags/:id", :controller => "nbp_tags", :action => "show"

  # UPDATE
  get "/nbp_tags/:id/edit", :controller => "nbp_tags", :action => "edit"
  post "/update_nbp_tag/:id", :controller => "nbp_tags", :action => "update"

  # DELETE
  get "/delete_nbp_tag/:id", :controller => "nbp_tags", :action => "destroy"

  # Routes for the NDA resource:
  resources :ndas do
    collection {post :import}
  end
  # CREATE
  get "/ndas/new", :controller => "ndas", :action => "new"
  post "/create_nda", :controller => "ndas", :action => "create"

  # READ
  get "/ndas", :controller => "ndas", :action => "index"
  get "/ndas/:id", :controller => "ndas", :action => "show"

  # UPDATE
  get "/ndas/:id/edit", :controller => "ndas", :action => "edit"
  post "/update_nda/:id", :controller => "ndas", :action => "update"

  # DELETE
  get "/delete_nda/:id", :controller => "ndas", :action => "destroy"

  # Routes for the NDA Highlights resource:
  resources :nda_highlights do
    collection {post :import}
  end
  # CREATE
  get "/nda_highlights/new", :controller => "nda_highlights", :action => "new"
  post "/create_nda_highlight", :controller => "nda_highlights", :action => "create"
  get "/nda_highlight_checkbox/:highlight_id/:teaser_id/:type_id/:status", :controller => "nda_highlights", :action => "checkbox"
  
  # READ
  get "/nda_highlights", :controller => "nda_highlights", :action => "index"
  get "/nda_highlights/:id", :controller => "nda_highlights", :action => "show"

  # UPDATE
  get "/nda_highlights/:id/edit", :controller => "nda_highlights", :action => "edit"
  post "/update_nda_highlight/:id", :controller => "nda_highlights", :action => "update"

  # DELETE
  get "/delete_nda_highlight/:id", :controller => "nda_highlights", :action => "destroy"

  # Routes for the NDA Slides resource:
  resources :nda_slides do
    collection {post :import}
  end
  # CREATE
  get "/nda_slides/new", :controller => "nda_slides", :action => "new"
  post "/create_nda_slide", :controller => "nda_slides", :action => "create"
  # READ
  get "/nda_slides", :controller => "nda_slides", :action => "index"
  get "/nda_slides/:id", :controller => "nda_slides", :action => "show"

  # UPDATE
  get "/nda_slides/:id/edit", :controller => "nda_slides", :action => "edit"
  post "/update_nda_slide/:id", :controller => "nda_slides", :action => "update"

  # DELETE
  get "/delete_nda_slide/:id", :controller => "nda_slides", :action => "destroy"

  # Routes for the Teaser Sponsors resource:
  resources :teaser_sponsors do
    collection {post :import}
  end  
  # CREATE
  get "/teaser_sponsors/new", :controller => "teaser_sponsors", :action => "new"
  post "/create_teaser_sponsor", :controller => "teaser_sponsors", :action => "create"
  post "/create_teaser_sponsor/:teaser_id/", :controller => "teaser_sponsors", :action => "create_by_name"
  
  # READ
  get "/teaser_sponsors", :controller => "teaser_sponsors", :action => "index"
  get "/teaser_sponsors/:id", :controller => "teaser_sponsors", :action => "show"

  # UPDATE
  get "/teaser_sponsors/:id/edit", :controller => "teaser_sponsors", :action => "edit"
  post "/update_teaser_sponsor/:id", :controller => "teaser_sponsors", :action => "update"
  get "/update_teaser_sponsor/:id/:status", :controller => "teaser_sponsors", :action => "update_status"

  # DELETE
  get "/delete_teaser_sponsor/:id", :controller => "teaser_sponsors", :action => "destroy"

  # Routes for the Teaser Companies resource:
  resources :teaser_companies do
    collection {post :import}
  end  
  # CREATE
  get "/teaser_companies/new", :controller => "teaser_companies", :action => "new"
  post "/create_teaser_company", :controller => "teaser_companies", :action => "create"
  post "/create_teaser_company/:teaser_id/", :controller => "teaser_companies", :action => "create_by_name"  
  # READ
  get "/teaser_companies", :controller => "teaser_companies", :action => "index"
  get "/teaser_companies/:id", :controller => "teaser_companies", :action => "show"

  # UPDATE
  get "/teaser_companies/:id/edit", :controller => "teaser_companies", :action => "edit"
  post "/update_teaser_company/:id", :controller => "teaser_companies", :action => "update"
  get "/update_teaser_company/:id/:status", :controller => "teaser_companies", :action => "update_status"
 
  # DELETE
  get "/delete_teaser_company/:id", :controller => "teaser_companies", :action => "destroy"

  # Routes for the MP Resource:
  resources :mps do
    collection {
      post :import
      post :import_acquirers
      post :show_acquirers 
    }
  end
  # CREATE
  get "/mps/new", :controller => "mps", :action => "new"
  post "/create_mp", :controller => "mps", :action => "create"
  get "/copy_mp_layout/:mp_id/", :controller => "mps", :action => "copy_layout"

  # READ
  get "/mps", :controller => "mps", :action => "index"
  get "/mps/:id", :controller => "mps", :action => "show"
  get "/mp_search/:search", :controller => "mps", :action => "search"
  get "/mps/:id/acquirers", :controller => "mps", :action => "show_acquirers"
  get "/mps/:id/sponsors", :controller => "mps", :action => "show_sponsors"
  get "/mps/:id/companies", :controller => "mps", :action => "show_companies"

  # UPDATE
  get "/mps/:id/edit", :controller => "mps", :action => "edit"
  post "/update_mp/:id", :controller => "mps", :action => "update"

  # DELETE
  get "/delete_mp/:id", :controller => "mps", :action => "destroy"

# Routes for the mp_Slides resource:
  resources :mp_slides do
    collection {post :import}
  end
  # CREATE
  get "/mp_slides/new", :controller => "mp_slides", :action => "new"
  post "/create_mp_slide", :controller => "mp_slides", :action => "create"
  
  # READ
  get "/mp_slides", :controller => "mp_slides", :action => "index"
  get "/mp_slides/:id", :controller => "mp_slides", :action => "show"

  # UPDATE
  get "/mp_slides/:id/edit", :controller => "mp_slides", :action => "edit"
  post "/update_mp_slide/:id", :controller => "mp_slides", :action => "update"

  # DELETE
  get "/delete_mp_slide/:id", :controller => "mp_slides", :action => "destroy"

# Routes for the MP Sponsors resource:
  resources :mp_sponsors do
    collection {post :import}
  end  
  # CREATE
  get "/mp_sponsors/new", :controller => "mp_sponsors", :action => "new"
  post "/create_mp_sponsor", :controller => "mp_sponsors", :action => "create"
  post "/create_mp_sponsor/:mp_id/", :controller => "mp_sponsors", :action => "create_by_name"
  
  # READ
  get "/mp_sponsors", :controller => "mp_sponsors", :action => "index"
  get "/mp_sponsors/:id", :controller => "mp_sponsors", :action => "show"

  # UPDATE
  get "/mp_sponsors/:id/edit", :controller => "mp_sponsors", :action => "edit"
  post "/update_mp_sponsor/:id", :controller => "mp_sponsors", :action => "update"
  get "/update_mp_sponsor/:id/:status", :controller => "mp_sponsors", :action => "update_status"

  # DELETE
  get "/delete_mp_sponsor/:id", :controller => "mp_sponsors", :action => "destroy"

  # Routes for the MP Companies resource:
  resources :mp_companies do
    collection {post :import}
  end  
  # CREATE
  get "/mp_companies/new", :controller => "mp_companies", :action => "new"
  post "/create_mp_company", :controller => "mp_companies", :action => "create"
  post "/create_mp_company/:mp_id/", :controller => "mp_companies", :action => "create_by_name"  
  # READ
  get "/mp_companies", :controller => "mp_companies", :action => "index"
  get "/mp_companies/:id", :controller => "mp_companies", :action => "show"

  # UPDATE
  get "/mp_companies/:id/edit", :controller => "mp_companies", :action => "edit"
  post "/update_mp_company/:id", :controller => "mp_companies", :action => "update"
  get "/update_mp_company/:id/:status", :controller => "mp_companies", :action => "update_status"
 
  # DELETE
  get "/delete_mp_company/:id", :controller => "mp_companies", :action => "destroy"

  # Routes for the Note resource:
  resources :notes do
    collection {post :import}
  end
  # CREATE
  get "/notes/new", :controller => "notes", :action => "new"
  post "/create_note/:company_id/:person_id/:sponsor_id", :controller => "notes", :action => "create"

  # READ
  get "/notes", :controller => "notes", :action => "index"
  get "/notes/:id", :controller => "notes", :action => "show"
  get "/note_search/:search", :controller => "notes", :action => "search"

  # UPDATE
  get "/notes/:id/edit", :controller => "notes", :action => "edit"
  post "/update_note/:id", :controller => "notes", :action => "update"

  # DELETE
  get "/delete_note/:id", :controller => "notes", :action => "destroy"

  # Routes for the Person resource:
  resources :people do
    collection {post :import}
  end  
  # CREATE
  get "/people/new", :controller => "people", :action => "new"
  post "/create_person", :controller => "people", :action => "create"
  post "/create_work_history", :controller => "people", :action => "create_work_history"
  post "/create_sponsor_history", :controller => "people", :action => "create_sponsor_history"

  # READ
  get "/people", :controller => "people", :action => "index"
  get "/people/:id", :controller => "people", :action => "show"
  get "/person_search/:search", :controller => "people", :action => "search"

  # UPDATE
  get "/people/:id/edit", :controller => "people", :action => "edit"
  post "/update_person/:id", :controller => "people", :action => "update"
  post "/update_user/", :controller => "people", :action => "update_user"
  post "/update_access/", :controller => "people", :action => "update_access"
  post "/update_work_history/:id", :controller => "people", :action => "update_work_history"
  post "/update_sponsor_history/:id", :controller => "people", :action => "update_sponsor_history"

  # DELETE
  get "/delete_person/:id", :controller => "people", :action => "destroy"

  # Routes for the Person Notes resource:
  resources :person_notes do
    collection {post :import}
  end
  # CREATE
  get "/person_notes/new", :controller => "person_notes", :action => "new"
  post "/create_person_note", :controller => "person_notes", :action => "create"
  # READ
  get "/person_notes", :controller => "person_notes", :action => "index"
  get "/person_notes/:id", :controller => "person_notes", :action => "show"

  # UPDATE
  get "/person_notes/:id/edit", :controller => "person_notes", :action => "edit"
  post "/update_person_note/:id", :controller => "person_notes", :action => "update"

  # DELETE
  get "/delete_person_note/:id", :controller => "person_notes", :action => "destroy"

  # Routes for the Roles resource:
  resources :roles do
    collection {post :import}
  end  
  # CREATE
  get "/roles/new", :controller => "roles", :action => "new"
  post "/create_role", :controller => "roles", :action => "create"

  # READ
  get "/roles", :controller => "roles", :action => "index"
  get "/roles/:id", :controller => "roles", :action => "show"

  # UPDATE
  get "/roles/:id/edit", :controller => "roles", :action => "edit"
  post "/update_role/:id", :controller => "roles", :action => "update"

  # DELETE
  get "/delete_role/:id", :controller => "roles", :action => "destroy"

 # Routes for the Sponsor resource:
  resources :sponsors do
    collection {post :import}
  end  
  # CREATE
  get "/sponsors/new", :controller => "sponsors", :action => "new"
  post "/create_sponsor", :controller => "sponsors", :action => "create"
  get "/follow_sponsor/:sponsor_id/", :controller => "sponsors", :action => "follow"

  # READ
  get "/sponsors", :controller => "sponsors", :action => "index"
  get "/sponsor_query", :controller => "sponsors", :action => "index_query"  
  get "/sponsors/:id", :controller => "sponsors", :action => "show"
  get "/sponsor_search/:search", :controller => "sponsors", :action => "search"

  # UPDATE
  get "/sponsors/:id/edit", :controller => "sponsors", :action => "edit"
  post "/update_sponsor/:id", :controller => "sponsors", :action => "update"

  # DELETE
  get "/delete_sponsor/:id", :controller => "sponsors", :action => "destroy"
  get "/unfollow_sponsor/:id", :controller => "sponsors", :action => "unfollow"

  # Routes for the Sponsor Follows resource:
  resources :sponsor_follows do
    collection {post :import}
  end
  # CREATE
  get "/sponsor_follows/new", :controller => "sponsor_follows", :action => "new"
  post "/create_sponsor_follow", :controller => "sponsor_follows", :action => "create"
  # READ
  get "/sponsor_follows", :controller => "sponsor_follows", :action => "index"
  get "/sponsor_follows/:id", :controller => "sponsor_follows", :action => "show"

  # UPDATE
  get "/sponsor_follows/:id/edit", :controller => "sponsor_follows", :action => "edit"
  post "/update_sponsor_follow/:id", :controller => "sponsor_follows", :action => "update"

  # DELETE
  get "/delete_sponsor_follow/:id", :controller => "sponsor_follows", :action => "destroy"

  # Routes for the Sponsor Histories resource:
  resources :sponsor_histories do
    collection {post :import}
  end
  # CREATE
  get "/sponsor_histories/new", :controller => "sponsor_histories", :action => "new"
  post "/create_sponsor_history", :controller => "sponsor_histories", :action => "create"
  # READ
  get "/sponsor_histories", :controller => "sponsor_histories", :action => "index"
  get "/sponsor_histories/:id", :controller => "sponsor_histories", :action => "show"

  # UPDATE
  get "/sponsor_histories/:id/edit", :controller => "sponsor_histories", :action => "edit"
  post "/update_sponsor_history/:id", :controller => "sponsor_histories", :action => "update"

  # DELETE
  get "/delete_sponsor_history/:id", :controller => "sponsor_histories", :action => "destroy"

  # Routes for the Sponsor Notes resource:
  resources :sponsor_notes do
    collection {post :import}
  end
  # CREATE
  get "/sponsor_notes/new", :controller => "sponsor_notes", :action => "new"
  post "/create_sponsor_note", :controller => "sponsor_notes", :action => "create"
  # READ
  get "/sponsor_notes", :controller => "sponsor_notes", :action => "index"
  get "/sponsor_notes/:id", :controller => "sponsor_notes", :action => "show"

  # UPDATE
  get "/sponsor_notes/:id/edit", :controller => "sponsor_notes", :action => "edit"
  post "/update_sponsor_note/:id", :controller => "sponsor_notes", :action => "update"

  # DELETE
  get "/delete_sponsor_note/:id", :controller => "sponsor_notes", :action => "destroy"

  # Routes for the Slides resource:
  resources :slides do
    collection {post :import}
  end
  # CREATE
  get "/slides/new", :controller => "slides", :action => "new"
  post "/create_slide", :controller => "slides", :action => "create"
  get "/create_nbp_slide/:nbp_id", :controller => "slides", :action => "create_nbp_slides"
  get "/create_teaser_slide/:teaser_id", :controller => "slides", :action => "create_teaser_slides"
  get "/create_nda_slide/:nda_id", :controller => "slides", :action => "create_nda_slides"
  get "/create_cip_slide/:cip_id", :controller => "slides", :action => "create_cip_slides"
  get "/create_ioi_slide/:ioi_id", :controller => "slides", :action => "create_ioi_slides"
  get "/create_mp_slide/:mp_id", :controller => "slides", :action => "create_mp_slides"
  get "/create_loi_slide/:loi_id", :controller => "slides", :action => "create_loi_slides"

  # READ
  get "/slides", :controller => "slides", :action => "index"
  get "/slides/:id", :controller => "slides", :action => "show"
  get "/slide_search/:search", :controller => "slides", :action => "search"  

  # UPDATE
  get "/slides/:id/edit", :controller => "slides", :action => "edit"
  post "/update_slide/:id", :controller => "slides", :action => "update"

  # DELETE
  get "/delete_slide/:id", :controller => "slides", :action => "destroy"


  # Routes for the Slide Layout resource:
  resources :slide_layouts do
    collection {post :import}
  end
  # CREATE
  get "/slide_layouts/new", :controller => "slide_layouts", :action => "new"
  post "/create_slide_layout/:slide_ids/", :controller => "slide_layouts", :action => "create"
  post "/share_slide_layout/", :controller => "slide_layouts", :action => "share_layout"
  get "/create_slide_layout_pdf/:id/", :controller => "slide_layouts", :action => "create_pdf"
  get "/create_slide_layout_pptx/:id/", :controller => "slide_layouts", :action => "create_pptx"

  # READ
  get "/slide_layouts", :controller => "slide_layouts", :action => "index"
  get "/slide_layouts/:id", :controller => "slide_layouts", :action => "show"
  
  # UPDATE
  get "/slide_layouts/:id/edit", :controller => "slide_layouts", :action => "edit"
  post "/update_slide_layout/:slide_ids", :controller => "slide_layouts", :action => "update"

  # DELETE
  get "/delete_slide_layout/:id", :controller => "slide_layouts", :action => "destroy"

  # Routes for the Slide Layout Slides resource:
  resources :slide_layout_slides do
    collection {post :import}
  end
  # CREATE
  get "/slide_layout_slides/new", :controller => "slide_layout_slides", :action => "new"
  post "/create_slide_layout_slide/:slide_ids/", :controller => "slide_layout_slides", :action => "create"
  post "/share_slide_layout_slide/", :controller => "slide_layout_slides", :action => "share_layout"


  # READ
  get "/slide_layout_slides", :controller => "slide_layout_slides", :action => "index"
  get "/slide_layout_slides/:id", :controller => "slide_layout_slides", :action => "show"
  
  # UPDATE
  get "/slide_layout_slides/:id/edit", :controller => "slide_layout_slides", :action => "edit"
  post "/update_slide_layout_slide/:slide_ids", :controller => "slide_layout_slides", :action => "update"

  # DELETE
  get "/delete_slide_layout_slide/:id", :controller => "slide_layout_slides", :action => "destroy"

  # Routes for the Slide_Tags resource:
  resources :slide_tags do
    collection {post :import}
  end
  # CREATE
  get "/slide_tags/new", :controller => "slide_tags", :action => "new"
  get "/create_slide_tag/:slide_id/:tag_id", :controller => "slide_tags", :action => "create"
  post "/create_slide_tag", :controller => "slide_tags", :action => "create"
  post "/create_slide_tag/:slide_id/", :controller => "slide_tags", :action => "create_by_name"

  # READ
  get "/slide_tags", :controller => "slide_tags", :action => "index"
  get "/slide_tags/:id", :controller => "slide_tags", :action => "show"

  # UPDATE
  get "/slide_tags/:id/edit", :controller => "slide_tags", :action => "edit"
  post "/update_slide_tag/:id", :controller => "slide_tags", :action => "update"

  # DELETE
  get "/delete_slide_tag/:id", :controller => "slide_tags", :action => "destroy"

  # Routes for the Strip Tags resource:
  resources :strip_tags do
    collection {post :import}
  end
  # CREATE
  get "/strip_tags/new", :controller => "strip_tags", :action => "new"
  post "/create_strip_tag", :controller => "strip_tags", :action => "create"
  get "/generate_strip_tags", :controller => "strip_tags", :action => "create_nbp_tag"  
  # READ
  get "/strip_tags", :controller => "strip_tags", :action => "index"
  get "/strip_tags/:id", :controller => "strip_tags", :action => "show"

  # UPDATE
  get "/strip_tags/:id/edit", :controller => "strip_tags", :action => "edit"
  get "/update_strip_tag/:id/:value", :controller => "strip_tags", :action => "update_value"
  post "/update_strip_tag/:id", :controller => "strip_tags", :action => "update"

  # DELETE
  get "/delete_strip_tag/:id", :controller => "strip_tags", :action => "destroy"

  # Routes for the Subsidiaries resource:
  resources :subsidiaries do
    collection {post :import}
  end
  # CREATE
  get "/subsidiaries/new", :controller => "subsidiaries", :action => "new"
  post "/create_subsidiary", :controller => "subsidiaries", :action => "create"
  
  # READ
  get "/subsidiaries", :controller => "subsidiaries", :action => "index"
  get "/subsidiaries/:id", :controller => "subsidiaries", :action => "show"

  # UPDATE
  get "/subsidiaries/:id/edit", :controller => "subsidiaries", :action => "edit"
  post "/update_subsidiary/:id", :controller => "subsidiaries", :action => "update"

  # DELETE
  get "/delete_subsidiary/:id", :controller => "subsidiaries", :action => "destroy"

  # Routes for the Tags resource:
  resources :tags do
    collection {post :import}
  end  

  # CREATE
  get "/tags/new", :controller => "tags", :action => "new"
  post "/create_tag", :controller => "tags", :action => "create"

  # READ
  get "/tags", :controller => "tags", :action => "index"
  get "/tag_query", :controller => "tags", :action => "index_query"  
  get "/tags/:id", :controller => "tags", :action => "show"
  get "/tag_search/:search", :controller => "tags", :action => "search"
  get "/view_slides/:tag_id", :controller => "tags", :action => "view_slides"


  # UPDATE
  get "/tags/:id/edit", :controller => "tags", :action => "edit"
  post "/update_tag/:id", :controller => "tags", :action => "update"

  # DELETE
  get "/delete_tag/:id", :controller => "tags", :action => "destroy"

# Routes for the Teaser resource:
  resources :teasers do
    collection {post :import}
  end
  # CREATE
  get "/teasers/new", :controller => "teasers", :action => "new"
  post "/create_teaser", :controller => "teasers", :action => "create"
  get "/copy_teaser_layout/:teaser_id/", :controller => "teasers", :action => "copy_layout"

  # READ
  get "/teasers", :controller => "teasers", :action => "index"
  get "/teasers/:id", :controller => "teasers", :action => "show"
  get "/teasers/:id/sponsors", :controller => "teasers", :action => "show_sponsors"
  get "/teasers/:id/companies", :controller => "teasers", :action => "show_companies"

  # UPDATE
  get "/teasers/:id/edit", :controller => "teasers", :action => "edit"
  post "/update_teaser/:id", :controller => "teasers", :action => "update"

  # DELETE
  get "/delete_teaser/:id", :controller => "teasers", :action => "destroy"

# Routes for the Teaser_Slides resource:
  resources :teaser_slides do
    collection {post :import}
  end
  # CREATE
  get "/teaser_slides/new", :controller => "teaser_slides", :action => "new"
  post "/create_teaser_slide", :controller => "teaser_slides", :action => "create"

  # READ
  get "/teaser_slides", :controller => "teaser_slides", :action => "index"
  get "/teaser_slides/:id", :controller => "teaser_slides", :action => "show"

  # UPDATE
  get "/teaser_slides/:id/edit", :controller => "teaser_slides", :action => "edit"
  post "/update_teaser_slide/:id", :controller => "teaser_slides", :action => "update"

  # DELETE
  get "/delete_teaser_slide/:id", :controller => "teaser_slides", :action => "destroy"

  # Routes for the Work Histories resource:
  resources :work_histories do
    collection {post :import}
  end
  # CREATE
  get "/work_histories/new", :controller => "work_histories", :action => "new"
  post "/create_work_history", :controller => "work_histories", :action => "create"
  # READ
  get "/work_histories", :controller => "work_histories", :action => "index"
  get "/work_histories/:id", :controller => "work_histories", :action => "show"

  # UPDATE
  get "/work_histories/:id/edit", :controller => "work_histories", :action => "edit"
  post "/update_work_history/:id", :controller => "work_histories", :action => "update"

  # DELETE
  get "/delete_work_history/:id", :controller => "work_histories", :action => "destroy"

  # All other routes
  get "dashboards/dashboard_1"
  get "dashboards/dashboard_2"
  get "dashboards/dashboard_3"
  get "dashboards/dashboard_4"
  get "dashboards/dashboard_4_1"
  get "dashboards/dashboard_5"

  get "layoutsoptions/index"
  get "layoutsoptions/off_canvas"

  get "graphs/flot"
  get "graphs/morris"
  get "graphs/rickshaw"
  get "graphs/chartjs"
  get "graphs/chartist"
  get "graphs/peity"
  get "graphs/sparkline"
  get "graphs/c3charts"

  get "mailbox/inbox"
  get "mailbox/email_view"
  get "mailbox/compose_email"
  get "mailbox/email_templates"
  get "mailbox/basic_action_email"
  get "mailbox/alert_email"
  get "mailbox/billing_email"

  get "metrics/index"

  get "widgets/index"

  get "forms/basic_forms"
  get "forms/advanced"
  get "forms/wizard"
  get "forms/file_upload"
  get "forms/text_editor"
  get "forms/autocomplete"
  get "forms/markdown"

  get "appviews/contacts"
  get "appviews/profile"
  get "appviews/profile_two"
  get "appviews/contacts_two"
  get "appviews/projects"
  get "appviews/project_detail"
  get "appviews/activity_stream"
  get "appviews/file_menager"
  get "appviews/vote_list"
  get "appviews/calendar"
  get "appviews/faq"
  get "appviews/timeline"
  get "appviews/pin_board"
  get "appviews/teams_board"
  get "appviews/social_feed"
  get "appviews/clients"
  get "appviews/outlook_view"
  get "appviews/blog"
  get "appviews/article"
  get "appviews/issue_tracker"

  get "pages/search_results"
  get "pages/lockscreen"
  get "pages/invoice"
  get "pages/invoice_print"
  get "pages/login"
  get "pages/login_2"
  get "pages/forgot_password"
  get "pages/register"
  get "pages/not_found_error"
  get "pages/internal_server_error"
  get "pages/empty_page"

  get "miscellaneous/notification"
  get "miscellaneous/nestablelist"
  get "miscellaneous/timeline_second_version"
  get "miscellaneous/forum_view"
  get "miscellaneous/forum_post_view"
  get "miscellaneous/google_maps"
  get "miscellaneous/datamaps"
  get "miscellaneous/social_buttons"
  get "miscellaneous/code_editor"
  get "miscellaneous/modal_window"
  get "miscellaneous/validation"
  get "miscellaneous/tree_view"
  get "miscellaneous/chat_view"
  get "miscellaneous/agile_board"
  get "miscellaneous/diff"
  get "miscellaneous/pdf_viewer"
  get "miscellaneous/sweet_alert"
  get "miscellaneous/idle_timer"
  get "miscellaneous/spinners"
  get "miscellaneous/spinners_usage"
  get "miscellaneous/live_favicon"
  get "miscellaneous/masonry"
  get "miscellaneous/tour"
  get "miscellaneous/loading_buttons"
  get "miscellaneous/clipboard"
  get "miscellaneous/text_spinners"
  get "miscellaneous/truncate"
  get "miscellaneous/password_meter"
  get "miscellaneous/i18support"

  get "uielements/typography"
  get "uielements/icons"
  get "uielements/draggable_panels"
  get "uielements/resizeable_panels"
  get "uielements/buttons"
  get "uielements/video"
  get "uielements/tables_panels"
  get "uielements/tabs"
  get "uielements/notifications_tooltips"
  get "uielements/helper_classes"
  get "uielements/badges_labels_progress"

  get "gridoptions/index"

  get "tables/static_tables"
  get "tables/data_tables"
  get "tables/foo_tables"
  get "tables/jqgrid"

  get "commerce/products_grid"
  get "commerce/products_list"
  get "commerce/product_edit"
  get "commerce/product_detail"
  get "commerce/orders"
  get "commerce/cart"
  get "commerce/payments"

  get "gallery/basic_gallery"
  get "gallery/slick_carusela"
  get "gallery/bootstrap_carusela"

  get "cssanimations/index"

  get "landing/index"

end
