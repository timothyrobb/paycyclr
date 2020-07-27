class App::IncomeSourcesController < AuthenticatedController
  layout 'app'

  def index
    @income_sources = current_user.income_sources
  end

  def show
    @income_source = current_user.income_sources.find(params[:id])
  end

  def new
    @income_source = current_user.income_sources.build
  end

  def create
    @income_source = IncomeSource.new(income_source_params)

    if @income_source.save
      url = current_user.income_sources.one? ? app_dashboard_path : {action: :index}
      redirect_to url, notice: "Income Source #{@income_source.name} created successfully!"
    else
      flash.alert = @income_source.errors.full_messages.map{ |m| "• #{m}".html_safe }.join("<br/>").html_safe
      render :new
    end
  end

  def edit
    @income_source = current_user.income_sources.find(params[:id])
    @income_source.assign_attributes(income_source_params(required: false))
  end

  def update
    @income_source = current_user.income_sources.find(params[:id])

    if @income_source.update_attributes(income_source_params)
      redirect_to action: :index, notice: "Income Source '#{@income_source.name}' saved successfully!"
    else
      errors = @income_source.errors.full_messages.map{ |m| "• #{m}" }.join("<br/>")
      redirect_to params.merge(action: :edit).permit!.to_h, alert: errors
    end
  end

  private

  def income_source_params(required: true)
    if required
      params.require(:income_source)
    else
      params.fetch(:income_source, {})
    end.permit(:id, :user_id, :name, :amount, :frequency)
  end
end
