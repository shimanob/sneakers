class SneakersController < ApplicationController
  before_action :authenticate_user!, except: [:index]
  def index
    @sneakers = Sneaker.all
  end

  def show
    @sneaker = Sneaker.find(params[:id])
  end

  def new
    @sneaker = Sneaker.new
  end

  def create
    @sneaker =Sneaker.new(sneaker_params)
    @sneaker.user_id =current_user.id
    if @sneaker.save
    redirect_to sneaker_path(@sneaker), notice: "投稿に成功しました。"
    else
      render :new
    end
  end

  def edit
    @sneaker = Sneaker.find(params[:id])
    if @sneaker.user != current_user
      redirect_to sneakers_path, alert: "不正なアクセスです。"
    end
  end

  def update
    @sneaker = Sneaker.find(params[:id])
    if @sneaker.update(sneaker_params)
    redirect_to sneaker_path(@sneaker), notice: "更新に成功しました。"
    else
      render :edit
    end
  end

  def destroy
   sneaker = Sneaker.find(params[:id])
   sneaker.destroy
   redirect_to sneakers_path
  end

  private
  def sneaker_params
    params.require(:sneaker).permit(:title, :body, :image)
  end

end
