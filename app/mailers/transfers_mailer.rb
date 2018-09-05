class TransfersMailer < ApplicationMailer
  def transfer_notification
    @transfer = params[:transfer]
    mail(to: transfer.sender.email, subject: "Transfer Confirmation")
  end

  def transaction_summary
    @user = params[:user]
    # build list of user deposits, transfers and receipts
  end
end
