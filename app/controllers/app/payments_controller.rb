class App::PaymentsController < AuthenticatedController
  layout 'app'

  def index
    @payments = current_user.payments
    @schedules = current_user.payment_schedules
  end

  def show
    @payment = current_user.payments.find(params[:id])
  end

  def new
    @payment = current_user.payments.build(payment_params(required: false))
  end

  def create
    @payment = Payment.new(payment_params)

    if @payment.save
      redirect_to (params[:back_to_url] || {action: :index}), notice: "Payment #{@payment.name} created successfully!"
    else
      errors = @payment.errors.full_messages.map{ |m| "• #{m}" }.join("<br/>")
      redirect_to params.merge(action: :new).permit!.to_h, alert: errors
    end
  end

  def edit
    # TODO
  end

  def update
    # TODO
  end

  private

  def payment_params(required: true)
    if required
      params.require(:payment)
    else
      params.fetch(:payment, {})
    end.permit(:id, :user_id, :name, :account, :amount, :due_date, :optional)
  end
end
