class BatchesController < ApplicationController
  before_action :set_batch, only: [:show, :edit, :update, :destroy]
  authorize_resource
  # GET /batches
  def index
    @batches = Batch.all
  end

  # GET /batches/1
  def show
    human_time = @batch.created_at.localtime.strftime('%m_%d_%Y_%H_%M_%S')
    send_data @batch.to_csv, :filename => "Batch#{@batch.id}_#{human_time}.csv"
  end

  # GET /batches/new
  def new
    @batch = Batch.new
  end

  # POST /batches
  def create
    @batch = Batch.new
    @batch.qty = params[:qty][:n].andand.to_i

    if @batch.save
      redirect_to @batch, notice: 'Batch was successfully created.'
    else
      render :new
    end
  end

  # DELETE /batches/1
  def destroy
    @batch.destroy
    redirect_to batches_url, notice: 'Batch was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_batch
      @batch = Batch.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def batch_params
      params.fetch(:batch, {})
    end
end
