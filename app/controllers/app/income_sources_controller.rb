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
      redirect_to (params[:back_to_url] || {action: :index}), notice: "Income Source #{@income_source.name} created successfully!"
    else
      flash.alert = @income_source.errors.full_messages.map{ |m| "• #{m}".html_safe }.join("<br/>").html_safe
      render :new
    end
  end

  def edit
    # TODO
  end

  def update
    # TODO
  end

  private

  def income_source_params
    params.require(:income_source).permit(:id, :user_id, :name, :amount, :frequency_id)
  end
end
