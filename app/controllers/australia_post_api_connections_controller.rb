class AustraliaPostApiConnectionsController < ApplicationController
  # GET /australia_post_api_connections
  # GET /australia_post_api_connections.json
  def index
    @australia_post_api_connections = AustraliaPostApiConnection.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @australia_post_api_connections }
    end
  end

  # GET /australia_post_api_connections/1
  # GET /australia_post_api_connections/1.json
  def show
    @australia_post_api_connection = AustraliaPostApiConnection.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @australia_post_api_connection }
    end
  end

  # GET /australia_post_api_connections/new
  # GET /australia_post_api_connections/new.json
  #
  # Initialize the API connection with dimensions
  #   weight -- should have been received as a param
  #   heigh, length, width -- should be supplied by prefs
  # Perform an API call to get a list of country codes
  # The form we present should contain a list of countries, as well as an option
  #   to enter the postcode instead (for domestic).
  def new
    @weight = params[:weight]
    @australia_post_api_connection = AustraliaPostApiConnection.new(dimensions_supplied_by_preferences)
    @australia_post_api_connection.weight = @weight

    # get country list from the API
    @countries = @australia_post_api_connection.data_oriented_methods(:country)

    # format the response how we like it
    @countries = @countries[1]['country'].inject([]) do |list, country|
      list.append([country['name'].capitalize, country['code'].capitalize])
      list
    end

    @countries.prepend([ "Australia", "AUS" ])

    @calculated = false

    respond_to do |format|
      format.html { render layout: false } # new.html.erb 
      format.json { render json: @australia_post_api_connection }
    end
  end

  # GET /australia_post_api_connections/1/edit
  def edit
    @australia_post_api_connection = AustraliaPostApiConnection.find(params[:id])
  end

  # POST /australia_post_api_connections
  # POST /australia_post_api_connections.json
  def create
    @australia_post_api_connection = AustraliaPostApiConnection.new(params[:australia_post_api_connection])
    @australia_post_api_connection.domestic = ( @australia_post_api_connection.country_code == "AUS" )

    # TODO we are repeating this code here (and making an expensive API call) because the countries
    # list won't fit in the flash (CookieOVERFLOW).

    # get country list from the API
    @countries = @australia_post_api_connection.data_oriented_methods(:country)

    # format the response how we like it
    @countries = @countries[1]['country'].inject([]) do |list, country|
      list.append([country['name'].capitalize, country['code'].capitalize])
      list
    end

    @calculated = true

    respond_to do |format|
      if @australia_post_api_connection.save
        format.html { flash.now[:notice] = @australia_post_api_connection.domestic.to_s; render action: "new", layout: false }
        # format.html { redirect_to @australia_post_api_connection, notice: 'Australia post api connection was successfully created.' }
        format.json { render json: @australia_post_api_connection, status: :created, location: @australia_post_api_connection }
      else
        format.html { render action: "new" }
        format.json { render json: @australia_post_api_connection.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /australia_post_api_connections/1
  # PUT /australia_post_api_connections/1.json
  def update
    @australia_post_api_connection = AustraliaPostApiConnection.find(params[:id])

    respond_to do |format|
      if @australia_post_api_connection.update_attributes(params[:australia_post_api_connection])
        format.html { redirect_to @australia_post_api_connection, notice: 'Australia post api connection was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @australia_post_api_connection.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /australia_post_api_connections/1
  # DELETE /australia_post_api_connections/1.json
  def destroy
    @australia_post_api_connection = AustraliaPostApiConnection.find(params[:id])
    @australia_post_api_connection.destroy

    respond_to do |format|
      format.html { redirect_to australia_post_api_connections_url }
      format.json { head :no_content }
    end
  end

  private

  def dimensions_supplied_by_preferences

    {
      height: 16,
      width: 16,
      length: 16
    }
  end
end