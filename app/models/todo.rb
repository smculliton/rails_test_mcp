class Todo < ApplicationRecord
  validates :title, presence: true
  attribute :completed, :boolean, default: false

  after_update_commit -> {
    broadcast_replace_to "todos", partial: "todos/todo_row", locals: { todo: self }
  }
end
