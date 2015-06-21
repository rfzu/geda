class Order < ActiveRecord::Base
  before_create     :generate_our_id
  before_create     :generate_our_serial

  def generate_our_id
    date = Time.now.strftime('%Y-%W')
    if (number = Order.where("generated_id like ?", "#{date}%").try(:last))
      number = number.generated_id.gsub(/\d{4}-\d+-/, '').to_i
      self.generated_id = "#{date}-#{number+1}"
    else
      self.generated_id = "#{date}-1"
    end
  end

  def generate_our_serial
    self.our_serial = "#{self.generated_id}-#{rand(100000..999999)}"
  end
end
