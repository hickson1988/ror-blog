require 'spec_helper'

describe UsersController do

  describe "GET #new" do
    it "creates a new user instance" do
      get :new
      expect(assigns(:user)).to be_instance_of(User)
    end
  end

  describe "GET #edit" do
    it "finds the user to be edited" do
     user = FactoryGirl.create(:user)
     get :edit, id: user
     expect(assigns(:user)).to eq(user)
    end
  end

   describe "POST #create" do
    context "with valid attributes" do
        it "creates a new user and saves him in the database" do
          expect{ post :create, user: FactoryGirl.attributes_for(:user) }.to change(User,:count).by(1)
        end

        it "redirects to the home page" do
          post :create, user: FactoryGirl.attributes_for(:user)
          expect(response).to redirect_to '/'
        end
    end

    context "with invalid attributes" do
      it "does not save the new user" do
        expect{ post :create, user: FactoryGirl.attributes_for(:invalid_user) }.to_not change(User,:count)
      end

      it "re-renders the new method" do
        post :create, user: FactoryGirl.attributes_for(:invalid_user)
        expect(response).to render_template :new
      end
    end
  end

    describe 'PUT #update' do

      before :each do
        @user = FactoryGirl.create(:user, first_name: "Test first name", last_name: "Test last name",email: "test@test.com", password: "12345")
      end

      context "valid attributes" do
        it "located the requested @user" do
          put :update, id: @user, user: FactoryGirl.attributes_for(:user)
          expect(assigns(:user)).to eq(@user)
        end

        it "changes @user's attributes" do
          put :update, id: @user, user: FactoryGirl.attributes_for(:user, first_name: "Test first name updated", last_name: "Test last name updated")
          @user.reload
          expect(@user.first_name).to eq("Test first name updated")
          expect(@user.last_name).to eq("Test last name updated")
        end

        it "redirects to the updated user" do
          put :update, id: @user, user: FactoryGirl.attributes_for(:user)
          expect(response).to redirect_to edit_user_path @user
        end
      end

      context "invalid attributes" do
        it "locates the requested @user" do
          put :update, id: @user, user: FactoryGirl.attributes_for(:invalid_user)
          expect(assigns(:user)).to eq(@user)
        end

         it "does not change @user's attributes" do
          put :update, id: @user, user: FactoryGirl.attributes_for(:user, first_name: "Test first name updated", last_name: nil)
          @user.reload
          expect(@user.first_name).to_not eq("Test first name updated")
          expect(@user.last_name).to eq("Test last name")
        end

        it "re-renders the edit method" do
          put :update, id: @user, user: FactoryGirl.attributes_for(:invalid_user)
          expect(response).to render_template :edit
        end
      end
    end

end
