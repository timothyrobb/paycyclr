class App::PaymentSchedulesController < AuthenticatedController
  layout 'app'

  def index
    @schedules = current_user.payment_schedules
  end

  def show
    @schedule = current_user.payment_schedules.find(params[:id])
  end

  def new
    # Change Payment "Due Date" to Schedule's Frequency Start Date
    if params.fetch(:payment, {}).has_key?("due_date(1i)")
      params[:payment_schedule] ||= params[:payment]
      params[:payment_schedule][:frequency_attributes] ||= {}
      params[:payment_schedule][:frequency_attributes]["start_date(1i)"] = params[:payment].delete("due_date(1i)")
      params[:payment_schedule][:frequency_attributes]["start_date(2i)"] = params[:payment].delete("due_date(2i)")
      params[:payment_schedule][:frequency_attributes]["start_date(3i)"] = params[:payment].delete("due_date(3i)")
    end

    @schedule = current_user.payment_schedules.build(schedule_params(required: false))
    @frequency = @schedule.frequency || @schedule.build_frequency(frequency_params)
  end

  def create
    @schedule = PaymentSchedule.new(schedule_params)

    if @schedule.save
      url = current_user.payment_schedules.one? ? app_dashboard_path : {action: :index}
      redirect_to url, notice: "Payment Schedule '#{@schedule.name}' created successfully!"
    else
      errors = @schedule.errors.full_messages.map{ |m| "• #{m}" }.join("<br/>")
      redirect_to params.merge(action: :new).permit!.to_h, alert: errors
    end
  end

  def edit
    @schedule = current_user.payment_schedules.find(params[:id])
    @schedule.assign_attributes(schedule_params(required: false))
  end

  def update
    @schedule = current_user.payment_schedules.find(params[:id])

    if @schedule.update_attributes(schedule_params)
      redirect_to app_payments_path, notice: "Payment Schedule '#{@schedule.name}' saved successfully!"
    else
      errors = @schedule.errors.full_messages.map{ |m| "• #{m}" }.join("<br/>")
      redirect_to params.merge(action: :edit).permit!.to_h, alert: errors
    end
  end

  private

  def schedule_params(required: true)
    if required
      params.require(:payment_schedule)
    else
      params.fetch(:payment_schedule, {})
    end.permit(:id, :user_id, :name, :account, :amount, :optional, frequency_attributes: [:id, :amount, :slug, :start_date])
  end

  def frequency_params
    params.fetch(:payment_schedule, {}).fetch(:frequency_attributes, {})
  end
end
