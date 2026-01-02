class PhilosophersController < ApplicationController
  before_action :set_philosopher, only: %i[ show edit update destroy ]


  def index
    @philosophers = Philosopher.all
  end


  def show
  end

 
  def new
    @philosopher = Philosopher.new
  end

  def edit
  end

  
  def create
    @philosopher = Philosopher.new(philosopher_params)

    respond_to do |format|
      if @philosopher.save
        format.html { redirect_to @philosopher, notice: "Philosopher was successfully created." }
        format.json { render :show, status: :created, location: @philosopher }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @philosopher.errors, status: :unprocessable_entity }
      end
    end
  end

 
  def update
    respond_to do |format|
      if @philosopher.update(philosopher_params)
        format.html { redirect_to @philosopher, notice: "Philosopher was successfully updated.", status: :see_other }
        format.json { render :show, status: :ok, location: @philosopher }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @philosopher.errors, status: :unprocessable_entity }
      end
    end
  end

  
  def destroy
    @philosopher.destroy!

    respond_to do |format|
      format.html { redirect_to philosophers_path, notice: "Philosopher was successfully destroyed.", status: :see_other }
      format.json { head :no_content }
    end
  end

  private
   
    def set_philosopher
      @philosopher = Philosopher.find(params.expect(:id))
    end

    def philosopher_params
      params.expect(philosopher: [ :phil_first_name, :phil_last_name, :birth_year, :death_year, :biography ])
    end
end
