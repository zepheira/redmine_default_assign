class DefaultAssignIssueHook < Redmine::Hook::ViewListener
  def view_issues_form_details_top(context = {})
    # We only want to modify new issues; new issues haven't been assigned an id
    return  if not context[:issue].id.nil?

    # Don't do anything if we don't want interactive assignment
    interactive_assignment =
      Setting.plugin_redmine_default_assign['interactive_assignment'] || 'true'
    interactive_assignment = (interactive_assignment == 'true')
    return  if not interactive_assignment

    selected = nil
    if not context[:project].default_assignee.blank?
      selected = context[:project].default_assignee.id
    else
      default_default_id = Setting.plugin_redmine_default_assign['default_assignee_id']
      if not default_default_id.blank?
        default_default_assignee = User.find(default_default_id)
        if context[:project].assignable_users.member?(default_default_assignee)
          selected = default_default_assignee.id
        end
      end
    end

    context[:issue].assigned_to_id = selected
    nil
  end  
end
