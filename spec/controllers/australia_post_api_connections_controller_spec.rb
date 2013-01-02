require 'spec_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to specify the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator.  If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails.  There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.
#
# Compared to earlier versions of this generator, there is very limited use of
# stubs and message expectations in this spec.  Stubs are only used when there
# is no simpler way to get a handle on the object needed for the example.
# Message expectations are only used when there is no simpler way to specify
# that an instance is receiving a specific message.

describe AustraliaPostApiConnectionsController do

  # This should return the minimal set of attributes required to create a valid
  # AustraliaPostApiConnection. As you add validations to AustraliaPostApiConnection, be sure to
  # update the return value of this method accordingly.
  def valid_attributes
    { "domestic" => "false" }
  end

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # AustraliaPostApiConnectionsController. Be sure to keep this updated too.
  def valid_session
    {}
  end

  describe "GET index" do
    it "assigns all australia_post_api_connections as @australia_post_api_connections" do
      australia_post_api_connection = AustraliaPostApiConnection.create! valid_attributes
      get :index, {}, valid_session
      assigns(:australia_post_api_connections).should eq([australia_post_api_connection])
    end
  end

  describe "GET show" do
    it "assigns the requested australia_post_api_connection as @australia_post_api_connection" do
      australia_post_api_connection = AustraliaPostApiConnection.create! valid_attributes
      get :show, {:id => australia_post_api_connection.to_param}, valid_session
      assigns(:australia_post_api_connection).should eq(australia_post_api_connection)
    end
  end

  describe "GET new" do
    it "assigns a new australia_post_api_connection as @australia_post_api_connection" do
      get :new, {}, valid_session
      assigns(:australia_post_api_connection).should be_a_new(AustraliaPostApiConnection)
    end
  end

  describe "GET edit" do
    it "assigns the requested australia_post_api_connection as @australia_post_api_connection" do
      australia_post_api_connection = AustraliaPostApiConnection.create! valid_attributes
      get :edit, {:id => australia_post_api_connection.to_param}, valid_session
      assigns(:australia_post_api_connection).should eq(australia_post_api_connection)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new AustraliaPostApiConnection" do
        expect {
          post :create, {:australia_post_api_connection => valid_attributes}, valid_session
        }.to change(AustraliaPostApiConnection, :count).by(1)
      end

      it "assigns a newly created australia_post_api_connection as @australia_post_api_connection" do
        post :create, {:australia_post_api_connection => valid_attributes}, valid_session
        assigns(:australia_post_api_connection).should be_a(AustraliaPostApiConnection)
        assigns(:australia_post_api_connection).should be_persisted
      end

      it "redirects to the created australia_post_api_connection" do
        post :create, {:australia_post_api_connection => valid_attributes}, valid_session
        response.should redirect_to(AustraliaPostApiConnection.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved australia_post_api_connection as @australia_post_api_connection" do
        # Trigger the behavior that occurs when invalid params are submitted
        AustraliaPostApiConnection.any_instance.stub(:save).and_return(false)
        post :create, {:australia_post_api_connection => { "domestic" => "invalid value" }}, valid_session
        assigns(:australia_post_api_connection).should be_a_new(AustraliaPostApiConnection)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        AustraliaPostApiConnection.any_instance.stub(:save).and_return(false)
        post :create, {:australia_post_api_connection => { "domestic" => "invalid value" }}, valid_session
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested australia_post_api_connection" do
        australia_post_api_connection = AustraliaPostApiConnection.create! valid_attributes
        # Assuming there are no other australia_post_api_connections in the database, this
        # specifies that the AustraliaPostApiConnection created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        AustraliaPostApiConnection.any_instance.should_receive(:update_attributes).with({ "domestic" => "false" })
        put :update, {:id => australia_post_api_connection.to_param, :australia_post_api_connection => { "domestic" => "false" }}, valid_session
      end

      it "assigns the requested australia_post_api_connection as @australia_post_api_connection" do
        australia_post_api_connection = AustraliaPostApiConnection.create! valid_attributes
        put :update, {:id => australia_post_api_connection.to_param, :australia_post_api_connection => valid_attributes}, valid_session
        assigns(:australia_post_api_connection).should eq(australia_post_api_connection)
      end

      it "redirects to the australia_post_api_connection" do
        australia_post_api_connection = AustraliaPostApiConnection.create! valid_attributes
        put :update, {:id => australia_post_api_connection.to_param, :australia_post_api_connection => valid_attributes}, valid_session
        response.should redirect_to(australia_post_api_connection)
      end
    end

    describe "with invalid params" do
      it "assigns the australia_post_api_connection as @australia_post_api_connection" do
        australia_post_api_connection = AustraliaPostApiConnection.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        AustraliaPostApiConnection.any_instance.stub(:save).and_return(false)
        put :update, {:id => australia_post_api_connection.to_param, :australia_post_api_connection => { "domestic" => "invalid value" }}, valid_session
        assigns(:australia_post_api_connection).should eq(australia_post_api_connection)
      end

      it "re-renders the 'edit' template" do
        australia_post_api_connection = AustraliaPostApiConnection.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        AustraliaPostApiConnection.any_instance.stub(:save).and_return(false)
        put :update, {:id => australia_post_api_connection.to_param, :australia_post_api_connection => { "domestic" => "invalid value" }}, valid_session
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested australia_post_api_connection" do
      australia_post_api_connection = AustraliaPostApiConnection.create! valid_attributes
      expect {
        delete :destroy, {:id => australia_post_api_connection.to_param}, valid_session
      }.to change(AustraliaPostApiConnection, :count).by(-1)
    end

    it "redirects to the australia_post_api_connections list" do
      australia_post_api_connection = AustraliaPostApiConnection.create! valid_attributes
      delete :destroy, {:id => australia_post_api_connection.to_param}, valid_session
      response.should redirect_to(australia_post_api_connections_url)
    end
  end

end