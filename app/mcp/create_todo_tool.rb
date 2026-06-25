class CreateTodoTool < MCP::Tool
  description "Create a new todo item"
  input_schema(
    properties: {
      title: {
        type: "string",
        description: "The title or description of the todo"
      }
    },
    required: ["title"]
  )
  annotations(destructive_hint: false, idempotent_hint: false)

  def self.call(title:, server_context:)
    todo = Todo.create!(title: title)
    result = { id: todo.id, title: todo.title, completed: todo.completed }
    MCP::Tool::Response.new([{ type: "text", text: result.to_json }])
  end
end
