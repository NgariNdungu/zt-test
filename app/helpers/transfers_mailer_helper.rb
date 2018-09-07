module TransfersMailerHelper
  def user_transactions(user)
    # get :amount and :created_at from deposits
    deposits = user.deposits.pluck(:amount, :created_at)
    # get :amount, :recipient and created_at from transfers
    transfers = user.sends.pluck(:amount, :recipient_id, :created_at)
    # get :amount, :sender and :created_at from transfers
    receipts = user.receipts.pluck(:amount, :sender_id, :created_at)

    transaction_summary = "
      Deposits: \n #{build_deposits(deposits)}
      Transfers: \n #{build_transfers(transfers)}
      Receipts: \n #{build_receipts(receipts)}
    "
   
  end

  def build_deposits(deposits)
    deposits_s = ""
    deposits.each { |amount, creation_time|
      deposits_s += "#{amount.to_s} Kes deposited at #{format_time(creation_time)}\n"
    }   
    deposits_s
  end

  def build_transfers(transfers)
    transfers_s = ""
    transfers.each{ |amount, recipient, creation_time|
      transfers_s += "#{amount} Kes sent to #{User.find(recipient).email if recipient} at #{format_time(creation_time)}\n"
    }
    transfers_s
  end

  def build_receipts(receipts)
    receipts_s = ""
    receipts.each{ |amount, sender, creation_time|
      receipts_s += "#{amount} Kes received from #{User.find(sender).email if sender} at #{format_time(creation_time)}\n"
    }
    receipts_s
  end
 
  def format_time(time)
    time.strftime("%I:%M%p on %D")
  end
end
