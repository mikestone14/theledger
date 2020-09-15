class CalculateRecordScore
  attr_reader :win_count, :loss_count, :net_in_cents

  def self.call(win_count:, loss_count:, net_in_cents:)
    new(win_count, loss_count, net_in_cents).call
  end

  def initialize(win_count, loss_count, net_in_cents)
    @win_count = win_count
    @loss_count = loss_count
    @net_in_cents = net_in_cents
  end

  def call
    (win_count - loss_count) + (net_in_dollars / 5)
  end

  private

  def net_in_dollars
    (net_in_cents.to_f / 100).round(2)
  end
end
