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
    @diligence_advisors = DiligenceAdvisor.order(id: :asc)
    @engagement_companies = EngagementCompany.order(id: :asc)
    @engagement_sponsors = EngagementSponsor.order(id: :asc)
    @favorite_slides = FavoriteSlide.order(id: :asc)
    @funds = Fund.order(id: :asc)
    @fund_companies = FundCompany.order(id: :asc)
    @highlights = Highlight.order(id: :asc)
    @iois = Ioi.order(id: :asc)
    @ioi_highlights = IoiHighlight.order(id: :asc)
    @ioi_slides = IoiSlide.order(id: :asc)
    @lois = Loi.order(id: :asc)
    @loi_highlights = LoiHighlight.order(id: :asc)
    @loi_slides = LoiSlide.order(id: :asc)
    @market_studies = MarketStudy.order(id: :asc)
    @market_study_slides = MarketStudySlide.order(id: :asc)
    @mps = Mp.order(id: :asc)
    @mp_companies = MpCompany.order(id: :asc)
    @mp_slides = MpSlide.order(id: :asc)
    @mp_sponsors = MpSponsor.order(id: :asc)
    @nbps = Nbp.order(id: :asc)
    @nbp_companies = NbpCompany.order(id: :asc)
    @nbp_slides = NbpSlide.order(id: :asc)
    @nbp_sponsors = NbpSponsor.order(id: :asc)
    @nbp_tags = NbpTag.order(id: :asc)
    @ndas = Nda.order(id: :asc)
    @nda_highlights = NdaHighlight.order(id: :asc)
    @nda_slides = NdaSlide.order(id: :asc)
    @notes = Note.order(id: :asc)
    @people = Person.order(id: :asc)
    @person_notes = PersonNote.order(id: :asc)
    @qoves = Qofe.order(id: :asc)
    @qofe_slides = QofeSlide.order(id: :asc)
    @roles = Role.order(id: :asc)
    @slide_layouts = SlideLayout.order(id: :asc)
    @slide_layout_slides = SlideLayoutSlide.order(id: :asc)
    @slides = Slide.order(id: :asc)
    @slide_tags = SlideTag.order(id: :asc)
    @sponsors = Sponsor.order(id: :asc)
    @sponsor_follows = SponsorFollow.order(id: :asc)
    @sponsor_histories = SponsorHistory.order(id: :asc)
    @sponsor_notes = SponsorNote.order(id: :asc)
    @strip_tags = StripTag.order(id: :asc)
    @subsidiaries = Subsidiary.order(id: :asc)
    @tags = Tag.order(id: :asc)
    @teasers = Teaser.order(id: :asc)
    @teaser_companies = TeaserCompany.order(id: :asc)
    @teaser_slides = TeaserSlide.order(id: :asc)
    @teaser_sponsors = TeaserSponsor.order(id: :asc)
    @users = User.order(id: :asc)
    @work_histories = WorkHistory.order(id: :asc)

    respond_to do |format|
      format.html
      format.xlsx {
        response.headers['Content-Disposition'] = 'attachment; filename="DataBackup.xlsx"'
        }
    end
  end

  def remove_sponsors

    @sponsors = Sponsor.where("id > ?", 1743)
    @count = @sponsors.count
    @sponsors.each do |sponsor|
        sponsor.destroy
    end
    redirect_to "/models", :notice => "#{@count} Sponsors successfully deleted."
      
  end

  def access_dashboard
    @users = User.all.order("id ASC")
    @people=Person.all
  end

  def user_dashboard
    @companies = Company.where(id: CompanyFollow.where(user_id:current_user.id).pluck(:company_id))
    @sponsors = Sponsor.where(id: SponsorFollow.where(user_id:current_user.id).pluck(:sponsor_id))
    @slide_layouts = current_user.slide_layouts.order("id ASC")
    @deals = current_user.deals.order("name ASC")
    @notes = current_user.person.notes
    @nbps = Nbp.where(deal_id: @deals.ids).order("nbp_date DESC")
    @teasers = Teaser.where(deal_id: @deals.ids).order("teaser_date DESC")
    @cips = Cip.where(deal_id: @deals.ids).order("cip_date DESC")
    @mps = Mp.where(deal_id: @deals.ids).order("mp_date DESC")
  end

end
