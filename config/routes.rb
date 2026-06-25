mcp_server = MCP::Server.new(
  name: "rails_todo_mcp",
  title: "Rails Todo MCP Server",
  version: "1.0.0",
  tools: [
    ListTodosTool,
    CreateTodoTool,
    UpdateTodoTool,
    DeleteTodoTool
  ]
)
mcp_transport = MCP::Server::Transports::StreamableHTTPTransport.new(mcp_server, stateless: true)

Rails.application.routes.draw do
  mount mcp_transport => "/mcp"

  resources :todos
  root "todos#index"

  get "up" => "rails/health#show", as: :rails_health_check
end
