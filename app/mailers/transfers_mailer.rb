class TransfersMailer < ApplicationMailer
  default from: "ngari@ngarindungu.me.ke"
  def transfer_notification
    @transfer = params[:transfer]
    mail(to: @transfer.sender.email, subject: "Transfer Confirmation")
  end

  def transaction_summary
    @user = params[:user]
    puts "......#{@user}........"
    # build list of user deposits, transfers and receipts
    mail(to: @user.email, subject: "Transaction History") 
  end
end
