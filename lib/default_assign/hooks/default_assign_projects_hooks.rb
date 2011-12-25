class DefaultAssignProjectHook < Redmine::Hook::ViewListener
 
  # context:
  # * :form - the form builder
  # * :project - the current project
  def view_projects_form(context={})
    selected = context[:project].default_assignee.id unless context[:project].default_assignee.blank?
    selected ||= Setting.plugin_redmine_default_assign['default_assignee_id'] unless Setting.plugin_redmine_default_assign['default_assignee_id'].blank? # FIX also make sure system-wide default is an assignable user
    selected ||= []
    return content_tag(:p, context[:form].select(:default_assignee_id,  
                                      options_from_collection_for_select(context[:project].assignable_users, :id, :name, Integer(selected)), {:include_blank => :none}))
 
  end
end
