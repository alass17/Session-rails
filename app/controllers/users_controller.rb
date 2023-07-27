class UsersController < ApplicationController
    before_action :correct_user, only: [:show]
    skip_before_action :login_required, only: [:new, :create]
    def new
        @user=User.new
    end
  
    def create
        @user = User.new(user_params)
        if @user.save
        log_in(@user)
        redirect_to user_path(@user.id) , notice: "J'ai réussi à créer un compte"
        else
        render :new
        end
    end

    def show
        @user = User.find(params[:id])
    end

    def edit
        @user = User.find(params[:id])
    end

    def update
        @user = User.find(params[:id])
        if @user.update(user_params)
            redirect_to user_path(@user), notice: "J'ai mis à jour mon compte"
        else
            render :edit
        end
    end

    def destroy
        @user = User.find(params[:id])
        @user.destroy
        redirect_to new_session_path, notice: "L'utilisateur a été supprimé avec succès."
    end
      


    private

    def user_params
        params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end

    def correct_user
        @user = User.find(params[:id])
        redirect_to current_user unless current_user?(@user)
    end

end
