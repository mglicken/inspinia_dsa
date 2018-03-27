class BucketsController < ApplicationController
  def index
    @buckets = Bucket.all

    respond_to do |format|
      format.html
      format.csv {send_data @buckets.to_csv }
    end
  end

  def search
    @text = params[:search].downcase

    @bucket_ids = []
    Bucket.all.each do |bucket|
      if bucket.name.downcase.include? @text
        @bucket_ids.push(bucket.id)
      end
    end

    @buckets= Bucket.where(id: @bucket_ids.uniq)
  end

  def show
    @bucket = Bucket.find(params[:id])
  end

  def new
    @bucket = Bucket.new
  end

  def create
    @bucket = Bucket.new

    @bucket.title = params[:title]
    @bucket.nbp_id = params[:nbp_id]
    @bucket.rationale = params[:rationale]

    if @bucket.save
      redirect_to "/nbps/#{@bucket.nbp_id}/companies", :notice => "Bucket created successfully."
    else
      render 'new'
    end
  end

  def edit
    bucket = Bucket.find(params[:id])
  end

  def update
    @bucket = Bucket.find(params[:id])

    @bucket.title = params[:title]
    @bucket.nbp_id = params[:nbp_id]
    @bucket.rationale = params[:rationale]
    
    if @bucket.save
      redirect_to "/nbps/#{@bucket.nbp_id}/companies", :notice => "Bucket updated successfully."
    else
      render 'edit'
    end
  end

  def destroy
    @bucket = Bucket.find(params[:id])

    @bucket.destroy

    redirect_to "/buckets", :notice => "Bucket deleted."
  end
  def import
    Bucket.import(params[:file])
    redirect_to "/models/", notice: "Buckets imported"
  end

end
