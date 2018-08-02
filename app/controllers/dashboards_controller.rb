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
    @accesses = Access.order(id: :asc)
    @advisor_types = AdvisorType.order(id: :asc)
    @buckets = Bucket.order(id: :asc)
    @case_studies = CaseStudy.order(id: :asc)
    @case_study_slides = CaseStudySlide.order(id: :asc)
    @cips = Cip.order(id: :asc)
    @cip_companies = CipCompany.order(id: :asc)
    @cip_slides = CipSlide.order(id: :asc)
    @cip_sponsors = CipSponsor.order(id: :asc)
    @companies = Company.order(id: :asc)
    @company_follows = CompanyFollow.order(id: :asc)
    @company_notes = CompanyNote.order(id: :asc)
    @deals = Deal.order(id: :asc)
    @deal_follows = DealFollow.order(id: :asc)
    @deal_people = DealPerson.order(id: :asc)
    @deal_stages = DealStage.order(id: :asc)
    @deal_types = DealType.order(id: :asc)

    respond_to do |format|
      format.html
      format.xlsx {
        response.headers['Content-Disposition'] = 'attachment; filename="DataBackup.xlsx"'
        }
    end
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
    @nbps = Nbp.where(deal_id: @deals.ids).order("nbp_date DESC")
    @teasers = Teaser.where(deal_id: @deals.ids).order("teaser_date DESC")
    @cips = Cip.where(deal_id: @deals.ids).order("cip_date DESC")
    @mps = Mp.where(deal_id: @deals.ids).order("mp_date DESC")
  end

end
