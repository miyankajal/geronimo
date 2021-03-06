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

describe ClassSectionsController do

  # This should return the minimal set of attributes required to create a valid
  # ClassSection. As you add validations to ClassSection, be sure to
  # update the return value of this method accordingly.
  def valid_attributes
    {}
  end
  
  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # ClassSectionsController. Be sure to keep this updated too.
  def valid_session
    {}
  end

  describe "GET index" do
    it "assigns all class_sections as @class_sections" do
      class_section = ClassSection.create! valid_attributes
      get :index, {}, valid_session
      assigns(:class_sections).should eq([class_section])
    end
  end

  describe "GET show" do
    it "assigns the requested class_section as @class_section" do
      class_section = ClassSection.create! valid_attributes
      get :show, {:id => class_section.to_param}, valid_session
      assigns(:class_section).should eq(class_section)
    end
  end

  describe "GET new" do
    it "assigns a new class_section as @class_section" do
      get :new, {}, valid_session
      assigns(:class_section).should be_a_new(ClassSection)
    end
  end

  describe "GET edit" do
    it "assigns the requested class_section as @class_section" do
      class_section = ClassSection.create! valid_attributes
      get :edit, {:id => class_section.to_param}, valid_session
      assigns(:class_section).should eq(class_section)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new ClassSection" do
        expect {
          post :create, {:class_section => valid_attributes}, valid_session
        }.to change(ClassSection, :count).by(1)
      end

      it "assigns a newly created class_section as @class_section" do
        post :create, {:class_section => valid_attributes}, valid_session
        assigns(:class_section).should be_a(ClassSection)
        assigns(:class_section).should be_persisted
      end

      it "redirects to the created class_section" do
        post :create, {:class_section => valid_attributes}, valid_session
        response.should redirect_to(ClassSection.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved class_section as @class_section" do
        # Trigger the behavior that occurs when invalid params are submitted
        ClassSection.any_instance.stub(:save).and_return(false)
        post :create, {:class_section => {}}, valid_session
        assigns(:class_section).should be_a_new(ClassSection)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        ClassSection.any_instance.stub(:save).and_return(false)
        post :create, {:class_section => {}}, valid_session
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested class_section" do
        class_section = ClassSection.create! valid_attributes
        # Assuming there are no other class_sections in the database, this
        # specifies that the ClassSection created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        ClassSection.any_instance.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, {:id => class_section.to_param, :class_section => {'these' => 'params'}}, valid_session
      end

      it "assigns the requested class_section as @class_section" do
        class_section = ClassSection.create! valid_attributes
        put :update, {:id => class_section.to_param, :class_section => valid_attributes}, valid_session
        assigns(:class_section).should eq(class_section)
      end

      it "redirects to the class_section" do
        class_section = ClassSection.create! valid_attributes
        put :update, {:id => class_section.to_param, :class_section => valid_attributes}, valid_session
        response.should redirect_to(class_section)
      end
    end

    describe "with invalid params" do
      it "assigns the class_section as @class_section" do
        class_section = ClassSection.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        ClassSection.any_instance.stub(:save).and_return(false)
        put :update, {:id => class_section.to_param, :class_section => {}}, valid_session
        assigns(:class_section).should eq(class_section)
      end

      it "re-renders the 'edit' template" do
        class_section = ClassSection.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        ClassSection.any_instance.stub(:save).and_return(false)
        put :update, {:id => class_section.to_param, :class_section => {}}, valid_session
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested class_section" do
      class_section = ClassSection.create! valid_attributes
      expect {
        delete :destroy, {:id => class_section.to_param}, valid_session
      }.to change(ClassSection, :count).by(-1)
    end

    it "redirects to the class_sections list" do
      class_section = ClassSection.create! valid_attributes
      delete :destroy, {:id => class_section.to_param}, valid_session
      response.should redirect_to(class_sections_url)
    end
  end

end
