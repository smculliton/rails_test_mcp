class DeleteTodoTool < MCP::Tool
  description "Delete a todo item by ID"
  input_schema(
    properties: {
      id: {
        type: "integer",
        description: "The ID of the todo to delete"
      }
    },
    required: ["id"]
  )
  annotations(destructive_hint: true, idempotent_hint: true)

  def self.call(id:, server_context:)
    Todo.find(id).destroy!
    MCP::Tool::Response.new([{ type: "text", text: { deleted: true, id: id }.to_json }])
  end
end
