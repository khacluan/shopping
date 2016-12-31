class Order < ApplicationRecord
  include AASM
  include OrderConcerns::Calculator

  belongs_to :user, required: false
  has_many :line_items, dependent: :destroy
  has_many :products,   through: :line_items
  has_many :payments,   dependent: :destroy

  scope :incomplete,  -> { where.not(status: :completed) }
  scope :paid,        -> { joins(:payments).where(payments: { status: :charged }) }

  aasm column: :status do
    state :cart, initial: true
    state :address  # fill billing address
    state :delivery # choose shipping method
    state :payment  # payment
    state :confirmed
    state :completed
  end

  def associate_user!(user, override_email = true)
    self.user  = user
    self.email = user.email if override_email
    self.save
  end

  def contents
    @contents ||= OrderContents.new(self)
  end
end
