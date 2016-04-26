class Goal < ActiveRecord::Base

  belongs_to :user

  has_many :tasks, dependent: :destroy

  validates :title, presence: true

  before_save :default_values

  private

  def default_values
    self.completed ||= false
    nil                           # required so that TX will not rollback!!!
  end
end
