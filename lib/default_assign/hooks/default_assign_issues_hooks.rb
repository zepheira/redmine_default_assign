class DefaultAssignIssueHook < Redmine::Hook::ViewListener
  def view_issues_form_details_top(context = {})
    # We only want to modify new issues; new issues haven't been assigned an id
    return  if not context[:issue].id.nil?

    # Don't do anything if we don't want interactive assignment
    interactive_assignment =
      Setting.plugin_redmine_default_assign['interactive_assignment'] || 'true'
    interactive_assignment = (interactive_assignment == 'true')
    return  if not interactive_assignment

    if not context[:project].default_assignee.blank?
      context[:issue].assigned_to_id = context[:project].default_assignee.id
    end

    nil
  end  
end
