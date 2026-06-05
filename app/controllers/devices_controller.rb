class DevicesController < ApplicationController
  before_action :set_device, only: %i[ show edit update destroy ]

  # GET /devices or /devices.json
  def index
    devices = params[:search].present? ? Device.where("hostname LIKE ? OR ip_address LIKE ? OR device_type LIKE ?", "%#{params[:search]}%", "%#{params[:search]}%", "%#{params[:search]}%") : Device.all
    respond_to do |format|
      format.html { @pagy, @devices = pagy(devices, limit: 20) }
      format.csv  { send_data devices.to_csv, filename: "geraete-#{Date.today}.csv", type: "text/csv" }
    end
  end

  # GET /devices/1 or /devices/1.json
  def show
  end

  # GET /devices/new
  def new
    @device = Device.new
  end

  # GET /devices/1/edit
  def edit
  end

  # POST /devices or /devices.json
  def create
    @device = Device.new(device_params)

    respond_to do |format|
      if @device.save
        format.html { redirect_to @device, notice: "Device was successfully created." }
        format.json { render :show, status: :created, location: @device }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @device.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /devices/1 or /devices/1.json
  def update
    respond_to do |format|
      if @device.update(device_params)
        format.html { redirect_to @device, notice: "Device was successfully updated.", status: :see_other }
        format.json { render :show, status: :ok, location: @device }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @device.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /devices/1 or /devices/1.json
  def destroy
    @device.destroy!

    respond_to do |format|
      format.html { redirect_to devices_path, notice: "Device was successfully destroyed.", status: :see_other }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_device
      @device = Device.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def device_params
      params.expect(device: [ :hostname, :ip_address, :mac_address, :device_type, :serial_number, :purchase_date, :warranty_until, :active, :notes ])
    end
end
