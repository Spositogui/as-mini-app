module ApplicationHelper
  def link_to_add_task(name, f, association, **args)
    new_object = f.object.send(association).klass.new
    id = new_object.object_id
    fields = f.fields_for(association, new_object, child_index: id) do |builder|
      render 'tasks/form', f: builder
    end
    link_to name, '#', class: "add-task-fields #{args[:class]}", data: {id: id, fields: fields.gsub("\n", '')}, remote: true
  end
end
