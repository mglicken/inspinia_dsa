class DashboardsController < ApplicationController
  def dashboard_1
  end

  def dashboard_2
  end

  def dashboard_3
    @extra_class = "sidebar-content"
  end

  def dashboard_4
    render :layout => "layout_2"
  end

  def dashboard_4_1
  end

  def dashboard_5
  end

  def models

  end

  def access_dashboard
    @users = User.all.order("id ASC")
    @people=Person.all
  end

  def user_dashboard
    @companies = Company.where(id: CompanyFollow.where(user_id:current_user.id).pluck(:company_id))
    @sponsors = Sponsor.where(id: SponsorFollow.where(user_id:current_user.id).pluck(:sponsor_id))
    @slide_layouts = current_user.slide_layouts.order("id ASC")
    @deals = current_user.person.deals.order("name ASC")
    @notes = current_user.person.notes
  end

end
