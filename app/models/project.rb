class Project < ApplicationRecord
  validates :title, presence: true
  has_many :todos
  has_and_belongs_to_many :developers, ->{ where(role: 'developer') }, class_name: 'User'
  before_destroy { todos.destroy_all }
  
  def self.todos_with_status
    data = {}
    self.includes(:todos).each do |project|
      todos = project.todos
      array = [todos.done.length, todos.in_progress.length, todos.assigned.length]
      data[project.id] = array
    end
    data
  end
end
