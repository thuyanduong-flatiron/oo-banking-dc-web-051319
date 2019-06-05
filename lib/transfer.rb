require 'pry'

class Transfer

  attr_reader :sender, :receiver, :amount
  attr_accessor :status

  def initialize(sender, receiver, amount)
    @sender = sender
    @receiver = receiver
    @amount = amount
    @status = 'pending'
  end

  def valid?
    @sender.valid? && @receiver.valid?
  end

  def execute_transaction
    if self.valid? && @sender.balance > @amount && @status == 'pending'
      @sender.balance -= @amount
      @receiver.balance += @amount
      return @status = 'complete'
    end
    @status = 'rejected'
    return "Transaction rejected. Please check your account balance."
  end

  def reverse_transfer
    if self.valid? && @status == "complete"
      @sender.balance += @amount
      @receiver.balance -= @amount
      return @status = 'reversed'
    end
  end
end
