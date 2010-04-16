class MiniUrlsController < ApplicationController
  # GET /mini_urls
  # GET /mini_urls.xml
  def index
    @mini_urls = MiniUrl.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @mini_urls }
    end
  end

  # GET /mini_urls/1
  # GET /mini_urls/1.xml
  def show
    @mini_url = MiniUrl.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @mini_url }
    end
  end

  # GET /mini_urls/new
  # GET /mini_urls/new.xml
  def new
    @mini_url = MiniUrl.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @mini_url }
    end
  end

  # GET /mini_urls/1/edit
  def edit
    @mini_url = MiniUrl.find(params[:id])
  end

  # POST /mini_urls
  # POST /mini_urls.xml
  def create
    @mini_url = MiniUrl.new(params[:mini_url])

    respond_to do |format|
      if @mini_url.save
        format.html { redirect_to(@mini_url, :notice => 'Mini url was successfully created.') }
        format.xml  { render :xml => @mini_url, :status => :created, :location => @mini_url }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @mini_url.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /mini_urls/1
  # PUT /mini_urls/1.xml
  def update
    @mini_url = MiniUrl.find(params[:id])

    respond_to do |format|
      if @mini_url.update_attributes(params[:mini_url])
        format.html { redirect_to(@mini_url, :notice => 'Mini url was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @mini_url.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /mini_urls/1
  # DELETE /mini_urls/1.xml
  def destroy
    @mini_url = MiniUrl.find(params[:id])
    @mini_url.destroy

    respond_to do |format|
      format.html { redirect_to(mini_urls_url) }
      format.xml  { head :ok }
    end
  end
end
