class TasksController < ApplicationController

  # GET /tasks/1
  # GET /tasks/1.xml
  def show
    @task = Task.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @task }
    end
  end

  def new
    @story = Story.find(params[:story_id])
    @task = Task.new

    respond_to do |format|
      format.html { render :edit }
      format.xml  { render :xml => @task }
    end
  end

  # GET /tasks/1/edit
  def edit
    @task = Task.find(params[:id])
  end

  def create
    
    assign_params_acceptor

    @story = Story.find(params[:story_id])
    if @story
      @task = @story.tasks.build(params[:task])
    else
      flash[:error] = 'Invalid Story specified.'
    end
    respond_to do |format|
      if @task && @task.save
        flash[:notice] = 'Task was successfully created.'
        format.html { redirect_to(@task) }
        format.xml  { render :xml => @task, :status => :created, :location => @task }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @task.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /tasks/1
  # PUT /tasks/1.xml
  def update
    @task = Task.find(params[:id])
    @story = @task.story

    respond_to do |format|
      if @task.update_attributes(params[:task])
        flash[:notice] = 'Task was successfully updated.'
        format.html { redirect_to(story_url(@story)) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @task.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /tasks/1
  # DELETE /tasks/1.xml
  def destroy
    @task = Task.find(params[:id])
    @story = @task.story
    @task.destroy

    respond_to do |format|
      format.html { redirect_to(story_url(@story)) }
      format.xml  { head :ok }
    end
  end
  
  def complete
    @task = Task.find(params[:id])
    @task.complete = true
    @task.save
    respond_to do |format|
      format.html { redirect_to(@task) }
      format.xml  { head :ok }
    end
  end
  
  def incomplete
    @task = Task.find(params[:id])
    @task.complete = false
    @task.save
    respond_to do |format|
      format.html { redirect_to(@task) }
      format.xml  { head :ok }
    end
  end  
  
  protected
  def assign_params_acceptor
    id = params[:task][:acceptor_id]
    if id.empty?
      params[:task][:acceptor] = nil
    else
      params[:task][:acceptor] = Person.find(id)
    end
  end
end
