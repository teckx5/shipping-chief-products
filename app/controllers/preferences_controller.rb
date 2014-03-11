require 'savon'

class PreferencesController < ApplicationController
  include ApplicationHelper
  include CarrierHelper

  around_filter :shopify_session
  before_filter :check_payment

  def show
    @preference = get_preference
    @free_shipping_options = get_collection_shipping_options

    Rails.logger.info("session[:shopify].url: #{session[:shopify].url.inspect}")
    respond_to do |format|
      format.html { render :action => "edit"}
      format.json { render json: @preference }
    end
  end

  # GET /preference/edit
  def edit
    @preference = get_preference
    @free_shipping_options = get_collection_shipping_options
    
  end

  # PUT /preference
  # PUT /preference
  def update
    
    @preference = get_preference()

    @preference.shop_url = session[:shopify].shop.domain

    respond_to do |format|
      @preference.attributes = params[:preference]
      
      #get free shipping option
    if @preference.free_shipping_by_collection
      colls = ShopifyAPI::CustomCollection.find(:all)

      colls.each do |col|
        free_shipping = (params["#{col.title}"] == "1")
        
         update_coll_metafield(col, free_shipping)
       end

       colls = ShopifyAPI::SmartCollection.find(:all)
       colls.each do |col|
         free_shipping = params["#{col.title}"] == "1"
         
         update_coll_metafield(col, free_shipping)
        end
      end

      installer_class = carrier_installer_class_for(@preference.carrier)
      installer = installer_class.new( session[:shopify].shop, @preference)
      installer.port = request.port if Rails.env.development?
      installer.configure(params)

      if @preference.save
        installer.preference = @preference
        installer.install

        format.html { redirect_to preferences_url, notice: 'Preference was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @preference.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def carrier_selected
    @preference = get_preference
    @free_shipping_options = get_collection_shipping_options
    
    if (params[:carrier].blank?)
      render :text => ""
    else
      render :partial => carrier_partial_for( params[:carrier] )
    end
  end
  
  def shipping_by_collection_selected    
    options = get_collection_shipping_options()
    render :json => shipping_options
  end
  
  

  def hide_welcome_note
    @preference = get_preference 
    @preference.hide_welcome_note = true
    @preference.save
    render :json =>{:result => "ok"}
  end

  private
  
  def update_coll_metafield(col, free_shipping)
    fields = col.metafields
    field = fields.find { |f| f.key == 'free_shipping' && f.namespace ='AusPostShipping'}
    if field.nil?              
      field = ShopifyAPI::Metafield.new({:namespace =>'AusPostShipping',:key=>'free_shipping', :value=>free_shipping.to_s, :value_type=>'string' })
    else
      field.destroy
      field = ShopifyAPI::Metafield.new({:namespace =>'AusPostShipping',:key=>'free_shipping', :value=>free_shipping.to_s, :value_type=>'string' })
    end
    col.add_metafield(field)
  end
  
  def get_coll_free_shipping(col)
    free_shipping = false    
    fields = col.metafields
    
    field = fields.find { |f| f.key == 'free_shipping' && f.namespace ='AusPostShipping'}
    unless field.nil?
      free_shipping = (field.value == "true")
    end
    free_shipping
  end

  def get_collection_shipping_options
    colls = ShopifyAPI::CustomCollection.find(:all)
    
    shipping_options = Array.new
    
    colls.each do |col|
       free_shipping = get_coll_free_shipping(col)
       shipping_options << {:collection_name => col.title, :free => free_shipping, :collection_id => col.id}
     end
     
     colls = ShopifyAPI::SmartCollection.find(:all)
     colls.each do |col|
        free_shipping = get_coll_free_shipping(col)
        shipping_options << {:collection_name => col.title, :free => free_shipping, :collection_id => col.id}
      end
           
    shipping_options
  end

  def get_preference
    preference = Preference.find_by_shop(current_shop)    
    preference ||= Preference.new
  end
  

end
