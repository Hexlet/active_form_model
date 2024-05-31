<% module_namespacing do -%>
class <%= class_name %>Form < <%= options['model'].classify %>
  include ActiveFormModel
end
<% end -%>
