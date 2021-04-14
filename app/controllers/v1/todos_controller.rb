module V1
  class TodosController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :not_found
    rescue_from ActiveRecord::RecordInvalid, with: :invalid_transaction
    before_action :set_todo, only: %i[show update destroy]

    def index
      @todos = current_user.todos.paginate(page: params[:page], per_page: 100)
      render json: @todos, status: :ok
    end

    def create
      @todo = current_user.todos.create!(todo_params)
      render json: @todo, status: :created
    end

    def show
      render json: @todo, status: :ok
    end

    def update
      @todo.update(todo_params)
      head :no_content
    end

    def destroy
      @todo.destroy
      head :no_content
    end

    private

    def set_todo
      @todo = Todo.find(params[:id])
    end

    def todo_params
      params.permit(:title)
    end

    def not_found(err)
      render json: {
        message: err.message
      }, status: :not_found
    end

    def invalid_transaction(err)
      render json: {
        message: err.message
      }, status: :unprocessable_entity
    end
  end
end
