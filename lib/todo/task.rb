module Todo
  require 'active_record'

  class Task < ActiveRecord::Base
    belongs_to :user

    validates :name, presence: true

    scope :active, -> { where(completed_at: nil) }
    scope :completed, -> { where.not(completed_at: nil) }
  end
end
