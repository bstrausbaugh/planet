# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  
  def top_nav
    create_model_references
    
    html = "<ul>"
  	html += "<li class=\"first\">#{link_to_unless_current "Home", projects_path}</li>"
  	if @project && ! @project.new_record?
    	html += "<li>#{link_to_unless_current @project.name, project_path(@project)}</li>"
  	end
  	if @iteration && ! @iteration.new_record?
    	html += "<li>#{link_to_unless_current @iteration.to_s, iteration_path(@iteration)}</li>"
    end
    html += "</ul>"
  end

  private 
  def create_model_references
    if @task
      @story = @task.story unless @story
    end
    if @story
      @iteration = @story.iteration unless @iteration
    end
    if @iteration
      @project = @iteration.project unless @project
    end
  end
  
end
