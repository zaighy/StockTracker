class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :user_stocks
  has_many :stocks, through: :user_stocks

  has_many :friendships
  has_many :friends, through: :friendships

  def full_name
    return "#{first_name} #{last_name}".strip if(first_name || last_name)
    "Anonymous"
  end

  def stock_already_added?(ticker)
    stock = Stock.find_by_ticker(ticker)
    # if stock is nil then return false
    return false unless stock

    #check if user is tracking the stock
    user_stocks.where(stock_id: stock.id).exists?
  end

  def under_stock_limit?
    #stock_limit = 10
    (user_stocks.count < 10)
  end

  def can_add_stock?(ticker)
    under_stock_limit? && !stock_already_added?(ticker)
    end

end
