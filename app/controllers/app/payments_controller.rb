class App::PaymentsController < AuthenticatedController
  layout 'app'

  before_action :load_payment, except: [:index, :new, :create]

  def index
    @payments = current_user.payments
    @schedules = current_user.payment_schedules
  end

  def show
  end

  def new
    @payment = current_user.payments.build(payment_params(required: false))
  end

  def create
    @payment = Payment.new(payment_params)

    if @payment.save
      url = current_user.payments.one? ? app_dashboard_path : {action: :index}
      redirect_to url, notice: "Payment '#{@payment.name}' created successfully!"
    else
      errors = @payment.errors.full_messages.map{ |m| "• #{m}" }.join("<br/>")
      redirect_to params.merge(action: :new).permit!.to_h, alert: errors
    end
  end

  def edit
    @payment.assign_attributes(payment_params(required: false))
  end

  def update
    if @payment.update_attributes(payment_params)
      redirect_to action: :index, notice: "Payment '#{@payment.name}' saved successfully!"
    else
      errors = @payment.errors.full_messages.map{ |m| "• #{m}" }.join("<br/>")
      redirect_to params.merge(action: :edit).permit!.to_h, alert: errors
    end
  end

  def pay
    @payment.pay!
    redirect_back fallback_url: app_dashboard_path
  end

  def skip
    @payment.skip!
    redirect_back fallback_url: app_dashboard_path
  end

  private

  def load_payment
    @payment = current_user.payments.find(params[:id])
  end

  def payment_params(required: true)
    if required
      params.require(:payment)
    else
      params.fetch(:payment, {})
    end.permit(:id, :user_id, :name, :account, :amount, :due_date, :optional)
  end
end
