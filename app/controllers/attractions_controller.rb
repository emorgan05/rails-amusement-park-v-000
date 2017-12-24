class AttractionsController < ApplicationController
  def index
    @attractions = Attraction.all
  end

  def show
    @attraction = Attraction.find(params[:id])
  end

  def new
    @attraction = Attraction.new
  end

  def create
    @attraction = Attraction.new(attraction_params)
    if @attraction.save
      redirect_to attraction_path(@attraction)
    else
      render 'new'
    end
  end

  def edit
    @attraction = Attraction.find(params[:id])
  end

  def update
    @attraction = Attraction.find(params[:id])
    @attraction.update(attraction_params)
    if @attraction.save
      redirect_to attraction_path(@attraction)
    else
      render 'edit'
    end
  end

  def ride
    attraction = Attraction.find(params[:id])
    ride = Ride.new(user_id: current_user.id, attraction_id: attraction.id)
    ride.save
    if ride.take_ride == true
      flash[:notice] = "Thanks for riding the #{attraction.name}!"
      redirect_to user_path(current_user)
    elsif ride.take_ride == "Sorry. You do not have enough tickets to ride the #{attraction.name}. You are not tall enough to ride the #{attraction.name}."
      flash[:notice] = "Sorry. You do not have enough tickets to ride the #{attraction.name}. You are not tall enough to ride the #{attraction.name}."
      redirect_to user_path(current_user)
    elsif ride.take_ride == "Sorry. You do not have enough tickets to ride the #{attraction.name}."
      flash[:notice] = "Sorry. You do not have enough tickets to ride the #{attraction.name}."
      redirect_to user_path(current_user)
    elsif ride.take_ride == "Sorry. You are not tall enough to ride the #{attraction.name}."
      flash[:notice] = "Sorry. You are not tall enough to ride the #{attraction.name}."
      redirect_to user_path(current_user)
    end
  end

  private
  def attraction_params
    params.require(:attraction).permit(:name, :tickets, :nausea_rating, :happiness_rating, :min_height)
  end
end
