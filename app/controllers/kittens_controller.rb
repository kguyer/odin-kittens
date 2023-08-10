class KittensController < ApplicationController
    def index
        @kittens = Kitten.all

        respond_to do |format|
            format.html
            format.json { render json: @kittens }
        end
    end

    def show
        @kitten = Kitten.find(params[:id])

        respond_to do |format|
            format.html    
            format.json { render json: @kitten }
        end
    end

    def new 
        @kitten = Kitten.new
    end

    def create
        @kitten = Kitten.new(kitten_params)

        if @kitten.save
            flash[:notice] = "Congratulations! You created a new kitten!"
            redirect_to @kitten
        else
            render :new, status: :unprocessable_entity
        end
    end

    def edit
        @kitten = Kitten.find(params[:id])
    end

    def update
        @kitten = Kitten.find(params[:id])

        if @kitten.update(kitten_params)
            flash[:notice] = "Your kitten has been updated!"
            redirect_to @kitten
        else  
            render :edit, status: :unprocessable_entity
        end
    end

    def destroy
        @kitten = Kitten.find(params[:id])
        @kitten.destroy

        flash[:notice] = "What was wrong with that kitten?"
        redirect_to root_path
    end

    private

    def kitten_params
        params.require(:kitten).permit(:name, :age, :cuteness, :softness)
    end
end
