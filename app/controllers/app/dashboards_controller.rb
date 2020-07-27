class App::DashboardsController < AuthenticatedController
  layout 'app'

  def show
    @next_pay = IncomeSource.where(user: current_user).next_source
    @paycycle_payments = current_user.payments.due
    @upcoming_payments = current_user.payments.in_cycle(@next_pay.frequency)
  end
end
