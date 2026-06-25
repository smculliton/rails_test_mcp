class ListTodosTool < MCP::Tool
  description "List all todo items, optionally filtered by completion status"
  input_schema(
    properties: {
      completed: {
        type: "boolean",
        description: "Filter by completion status. Omit to return all todos."
      }
    }
  )
  annotations(read_only_hint: true, destructive_hint: false)

  def self.call(server_context:, **args)
    todos = args.key?(:completed) ? Todo.where(completed: args[:completed]) : Todo.all
    result = todos.order(:id).map { |t| { id: t.id, title: t.title, completed: t.completed } }
    MCP::Tool::Response.new([{ type: "text", text: result.to_json }])
  end
end
