require 'redmine'
require 'dispatcher'

require 'default_assign_issue_patch'
require 'default_assign_project_patch'
require 'default_assign/hooks/default_assign_projects_hooks'
require 'default_assign/hooks/default_assign_issues_hooks.rb'


Dispatcher.to_prepare do
  require_dependency 'project'
  require_dependency 'issue'
  Project.send(:include, DefaultAssignProjectPatch)
  Issue.send(:include, DefaultAssignIssuePatch)
end

Redmine::Plugin.register :redmine_default_assign do
  name 'Default Assign plugin'
  author 'Robert Chady'
  description 'Plugin implementing Douglas Campos\' ticket-482 code as a plugin.  It has since been extended to offer other features as well.'
  version '0.2.0'

  settings :default => {'default_assignee_id' => nil}, :partial => 'settings/default_assign'

end
