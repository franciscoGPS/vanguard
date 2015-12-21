class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  # La siguiente línea sirve para bloquear.
  before_action :authenticate_user!, :verify_is_admin?, only:[:new, :index, :show, :edit, :update, :destroy]




  # GET /users
  # GET /users.json
  def index
    @users = User.all
  end

  # GET /users/1
  # GET /users/1.json
  def show
  end

  # GET /users/new
  def new
      @user = User.new
      @role_list = Role.all
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create

    if current_user.admin?
    #if current_user.try(:admin?)



      generated_password = Devise.friendly_token.first(8)


      @user = User.new(:email => user_params[:email], :password => generated_password,
       :name => user_params[:name], :role_id => user_params[:role_id],
       :phone => user_params[:phone], :job =>user_params[:job])


      #@user = User.new(:email => "ejemplo@agaveti.com", :password => generated_password)

      respond_to do |format|
        if @user.save

          UserMailer.welcome_email(@user, generated_password).deliver

          format.html { redirect_to @user, notice: 'User was successfully created. \n'}
          #format.json { render :show, status: :created, location: @user }




        else
          format.html { render :new, notice: 'Nada, nada.--> \n'  + generated_password}
          #format.json { render json: @user.errors, status: :unprocessable_entity }
        end
      end
    else #####else del if de current_user.try(:admin?) -############

      redirect_to :back, notice: "No tiene permisos "
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        #format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        #format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      #format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      accessible = [:name, :phone, :role_id, :job, :email,
        :password_confirmation, :remember_me, :encrypted_password]
      accessible << [role_attributes: [:id, :name]]
      params.require(:user).permit(accessible)
    end

protected
  def verify_is_admin?
      (current_user.nil?) ? redirect_to(root_path) : (redirect_to(admin_path) unless current_user.admin?)
  end

end

























