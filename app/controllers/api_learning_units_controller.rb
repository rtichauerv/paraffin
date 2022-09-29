class ApiLearningUnitsController < ApiApplicationController
  def index
    learning_units = Curriculum
                     .find(params[:curriculum_id])
                     .learning_units
    render json: learning_units, only: %i[id name]
  end

  def show
    learning_unit = Curriculum
                    .find(params[:curriculum_id])
                    .learning_units
                    .find(params[:learning_unit_id])
    render json: learning_unit, only: %i[id name description]
  end
end
