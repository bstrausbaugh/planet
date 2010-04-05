class TimeEntriesController < ApplicationController

  def show
    @time_entry = TimeEntry.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @task }
    end
  end

  def new
    @task = Task.find(params[:task_id])
    @time_entry = TimeEntry.new

    respond_to do |format|
      format.html { render :edit }
      format.xml  { render :xml => @time_entry }
    end
  end

  def edit
    @time_entry = Task.find(params[:id])
  end

  def create
    assign_params_persons

    @task = Task.find(params[:task_id])
    if @task
      @time_entry = @task.time_entries.build(params[:time_entry])
    else
      flash[:error] = 'Invalid Task specified.'
    end
    respond_to do |format|
      if @time_entry && @time_entry.save
        flash[:notice] = 'Time Entry was successfully created.'
        format.html { redirect_to(@task) }
        format.xml  { render :xml => @time_entry, :status => :created, :location => @time_entry }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @time_entry.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    @time_entry = TimeEntry.find(params[:id])
    @task = @time_entry.task

    respond_to do |format|
      if @time_entry.update_attributes(params[:time_entry])
        flash[:notice] = 'Time Entry was successfully updated.'
        format.html { redirect_to(task_url(@task)) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @time_entry.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @time_entry = TimeEntry.find(params[:id])
    @task = @time_entry.task
    @time_entry.destroy

    respond_to do |format|
      format.html { redirect_to(task_url(@task)) }
      format.xml  { head :ok }
    end
  end
  
  
  protected
  def assign_params_persons
    person1_id = params[:time_entry][:person1_id]
    person2_id = params[:time_entry][:person2_id]
    if person1_id.empty?
      params[:time_entry][:person1_id] = nil
    else
      params[:time_entry][:person1_id] = Person.find(person1_id)
    end
    if person2_id.empty?
      params[:time_entry][:person2_id] = nil
    else
      params[:time_entry][:person2_id] = Person.find(person2_id)
    end
    
  end
  
end
