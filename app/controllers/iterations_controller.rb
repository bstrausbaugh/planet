class IterationsController < ApplicationController

  # GET /iterations/1
  # GET /iterations/1.xml
  def show
    @iteration = Iteration.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @iteration }
    end
  end

  # GET /iterations/new
  # GET /iterations/new.xml
  def new
    @project = Project.find(params[:project_id])
    if @project
      @iteration = @project.iterations.new
    else
      flash[:error] = 'Invalid Project specified'
    end

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @iteration }
    end
  end

  # GET /iterations/1/edit
  def edit
    @iteration = Iteration.find(params[:id])
  end

  # POST /iterations
  # POST /iterations.xml
  def create
    @project = Project.find(params[:project_id])
    if @project
      @iteration = @project.iterations.build(params[:iteration])
    else
      flash[:error] = 'Invalid Project specified'
    end

    respond_to do |format|
      if @iteration.save
        flash[:notice] = 'Iteration was successfully created.'
        format.html { redirect_to(@iteration) }
        format.xml  { render :xml => @iteration, :status => :created, :location => @iteration }
      else
        puts @iteration.errors
        format.html { render :action => "new" }
        format.xml  { render :xml => @iteration.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /iterations/1
  # PUT /iterations/1.xml
  def update
    @iteration = Iteration.find(params[:id])

    respond_to do |format|
      if @iteration.update_attributes(params[:iteration])
        flash[:notice] = 'Iteration was successfully updated.'
        format.html { redirect_to(@iteration) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @iteration.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /iterations/1
  # DELETE /iterations/1.xml
  def destroy
    @iteration = Iteration.find(params[:id])
    @project = @iteration.project
    @iteration.destroy

    respond_to do |format|
      format.html { redirect_to(project_url(@project)) }
      format.xml  { head :ok }
    end
  end
end
