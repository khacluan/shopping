class Payment < ApplicationRecord
  include AASM

  belongs_to :order

  aasm column: :status do
    state :authorized, initial: true
    state :pending
    state :charged
    state :failed
  end
end
