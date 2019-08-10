class User < ApplicationRecord
  devise :database_authenticatable, 
         :registerable,
         :rememberable, 
         :validatable

  enum role: [ :admin, :developer ]

  has_many :todos
  has_and_belongs_to_many :projects

  after_initialize :set_default_role, if: :new_record?

  private
    def set_default_role
      self.role ||= :developer
    end

end
