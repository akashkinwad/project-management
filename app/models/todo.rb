class Todo < ApplicationRecord
  enum status: [ :assigned, :in_progress, :done ]
  validates :description, presence: true
  belongs_to :project
  belongs_to :developer, ->{ where(role: 'developer') }, class_name: 'User', foreign_key: :user_id

  before_create :assign_status

  private
    def assign_status
      self.status = 'assigned'
    end
end
