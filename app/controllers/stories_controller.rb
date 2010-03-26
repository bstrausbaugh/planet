class StoriesController < ApplicationController

  # GET /stories/1
  # GET /stories/1.xml
  def show
    @story = Story.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @story }
    end
  end

  # GET /stories/new
  # GET /stories/new.xml
  def new
    @iteration = Iteration.find(params[:iteration_id])
    @story = Story.new

    respond_to do |format|
      format.html { render :edit }
      format.xml  { render :xml => @story }
    end
  end

  # GET /stories/1/edit
  def edit
    @story = Story.find(params[:id])
  end

  # POST /stories
  # POST /stories.xml
  def create
    
    assign_params_tracker

    @iteration = Iteration.find(params[:iteration_id])
    if @iteration
      @story = @iteration.stories.build(params[:story])
    else
      flash[:error] = 'Invalid Iteration specified.'
    end
    respond_to do |format|
      if @story && @story.save
        flash[:notice] = 'Story was successfully created.'
        format.html { redirect_to(@story) }
        format.xml  { render :xml => @story, :status => :created, :location => @story }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @story.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /stories/1
  # PUT /stories/1.xml
  def update

    assign_params_tracker
    @story = Story.find(params[:id])
    
    respond_to do |format|
      if @story.update_attributes(params[:story])
        flash[:notice] = 'Story was successfully updated.'
        format.html { redirect_to(@story) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @story.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /stories/1
  # DELETE /stories/1.xml
  def destroy
    @story = Story.find(params[:id])
    @iteration = @story.iteration
    @story.destroy

    respond_to do |format|
      format.html { redirect_to(iteration_url(@iteration)) }
      format.xml  { head :ok }
    end
  end

  protected
  def assign_params_tracker
    id = params[:story][:tracker_id]
    if id.empty?
      params[:story][:tracker] = nil
    else
      params[:story][:tracker] = Person.find(id)
    end
  end
  
end
