class Goal < ActiveRecord::Base
  validates :title, :due_date presence: true

  before_save :default_values

  private

  def default_values
    self.completed ||= false
    nil                           # required so that TX will not rollback!!!
  end
end
