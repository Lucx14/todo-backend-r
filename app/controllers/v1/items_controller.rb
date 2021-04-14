module V1
  class ItemsController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :not_found
    rescue_from ActiveRecord::RecordInvalid, with: :invalid_transaction
    before_action :set_todo
    before_action :set_todo_item, only: %i[show update destroy]

    def index
      render json: @todo.items, status: :ok
    end

    def create
      @todo.items.create!(item_params)
      render json: @todo, status: :created
    end

    def show
      render json: @item, status: :ok
    end

    def update
      @item.update(item_params)
      head :no_content
    end

    def destroy
      @item.destroy
      head :no_content
    end

    private

    def set_todo
      @todo = Todo.find(params[:todo_id])
    end

    def set_todo_item
      @item = @todo.items.find(params[:id]) if @todo
    end

    def item_params
      params.permit(:name, :done)
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
