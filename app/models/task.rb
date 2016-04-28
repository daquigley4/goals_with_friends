class Task < ActiveRecord::Base
  belongs_to :goal

  validates :title, presence: true

  before_save :default_values

  def default_values
    self.completed ||= false
    nil                           # required so that TX will not rollback!!!
  end
end
