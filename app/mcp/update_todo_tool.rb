class UpdateTodoTool < MCP::Tool
  description "Update a todo item's title and/or mark it as completed or not"
  input_schema(
    properties: {
      id: {
        type: "integer",
        description: "The ID of the todo to update"
      },
      title: {
        type: "string",
        description: "New title for the todo"
      },
      completed: {
        type: "boolean",
        description: "Set to true to mark as completed, false to mark as incomplete"
      }
    },
    required: ["id"]
  )
  annotations(destructive_hint: false, idempotent_hint: true)

  def self.call(id:, server_context:, **args)
    todo = Todo.find(id)
    todo.update!(args.slice(:title, :completed))
    result = { id: todo.id, title: todo.title, completed: todo.completed }
    MCP::Tool::Response.new([{ type: "text", text: result.to_json }])
  end
end
