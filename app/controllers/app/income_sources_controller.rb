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
    # TODO
  end

  def edit
    # TODO
  end

  def update
    # TODO
  end
end
