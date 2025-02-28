class CatsController < ApplicationController
  before_action :set_cat, only: %i[ show edit update destroy ]

=begin
  def htmxtest
    logger.debug("=== log ===")
    #request.headers.sort.map {|k, v| logger.debug "#{k}:#{v}" }
    out = " HTTP_HX_REQUEST : " + request.headers["HTTP_HX_REQUEST"]
    render plain: "==== #{out} =====", layout: false
  end

  def index
    render layout: false
    @cats = Cat.all
    @cats = Cat.page( params[:page] )
    request.headers.sort.map {|k,v| logger.debug "#{k} : #{v}" }
  end
=end

  # GET /cats or /cats.json
  def index
    @search = Cat.ransack( params[:q] )
    @search.sorts = 'id desc' if @search.sorts.empty?
    @cats = @search.result.page( params[:page] )
    #rendaring_range
  end

  # GET /cats/1 or /cats/1.json
  def show
  end

  # GET /cats/new
  def new
    @cat = Cat.new
  end

  # GET /cats/1/edit
  def edit
  end

  # POST /cats or /cats.json
  def create
    @cat = Cat.new(cat_params)

    respond_to do |format|
      if @cat.save
        format.html { redirect_to @cat, notice: "Cat was successfully created." }
        format.json { render :show, status: :created, location: @cat }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @cat.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /cats/1 or /cats/1.json
  def update
    respond_to do |format|
      if @cat.update(cat_params)
        format.html { redirect_to @cat, notice: "Cat was successfully updated." }
        format.json { render :show, status: :ok, location: @cat }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @cat.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /cats/1 or /cats/1.json
  def destroy
    @cat.destroy!

    respond_to do |format|
      format.html { redirect_to cats_path, status: :see_other, notice: "Cat was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_cat
      @cat = Cat.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def cat_params
      params.require(:cat).permit(:name, :age)
    end
end
