module TransfersMailerHelper
  def user_transactions(user)
    # get :amount and :created_at from deposits
    deposits = user.deposits.pluck(:amount, :created_at)
    # get :amount, :recipient and created_at from transfers
    transfers = user.sends.pluck(:amount, :recipient_id, :created_at)
    # get :amount, :sender and :created_at from transfers
    receipts = user.receipts.pluck(:amount, :sender_id, :created_at)

    transaction_summary = ""
    deposits.each { |amount, creation_time|
      deposits_s += "#{amount.to_s} Kes deposited at #{format_time(creation_time)}"
    } 
  end

  def format_time(time)
    time.strftime("%I:%M%p on %D")
  end
end
