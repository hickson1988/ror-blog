require 'spec_helper'

describe ArticlesController do

  describe "GET #index" do
    it "finds the category" do
      category=FactoryGirl.create(:category)
      get :index, category_id: category
      expect(assigns(:category)).to eq(category)
    end

     it "finds the category's articles" do
      category=FactoryGirl.create(:category_with_articles)
      articles=category.articles
      get :index, category_id: category
      expect(assigns(:articles)).to eq(articles)
    end
  end

  describe "GET #show" do
    it "finds the article" do
      article=FactoryGirl.create(:article)
      get :show, id: article
      expect(assigns(:article)).to eq(article)
    end
  end

  describe "GET #new" do
    context "with logged in user" do
       before :each do
          user=FactoryGirl.create(:user)
          login(user)
        end

        it "finds the category" do
          category=FactoryGirl.create(:category)
          get :new, category_id: category
          expect(assigns(:category)).to eq(category)
        end

        it "creates a new article instance" do
          category=FactoryGirl.create(:category)
          get :new, category_id: category
          expect(assigns(:article)).to be_instance_of(Article)
        end
    end

    context "with not logged in user" do
        it "does not find the category and redirects to login page" do
          category=FactoryGirl.create(:category)
          get :new, category_id: category
          expect(response).to redirect_to '/login'
        end

        it "does not create a new article instance and redirects to login page" do
          category=FactoryGirl.create(:category)
          get :new, category_id: category
          expect(response).to redirect_to '/login'
        end
    end
  end

  describe "GET #newuncategorized" do
    context "with logged in user" do
     before :each do
        user=FactoryGirl.create(:user)
        login(user)
      end

      it "creates a new article instance" do
        get :newuncategorized
        expect(assigns(:article)).to be_instance_of(Article)
      end

      it "gets all categories" do
        category=FactoryGirl.create(:category)
        get :newuncategorized
        expect(assigns(:categories)).to eq([category])
      end
    end

    context "with not logged in user" do
      it "does not creates a new article instance and redirects to login page" do
        get :newuncategorized
        expect(response).to redirect_to '/login'
      end

      it "does not get all categories and redirects to login page" do
        category=FactoryGirl.create(:category)
        get :newuncategorized
        expect(response).to redirect_to '/login'
      end
    end
  end

  describe "GET #edit" do
   context "with logged in user and with resource ownership" do
      it "gets all categories" do
        article = FactoryGirl.create(:article_with_user)
        categories = FactoryGirl.create(:category)
        login(article.user)
        current_user_resource_owner(article)
        get :edit, id: article
        expect(assigns(:allcategories)).to eq([categories])
      end

      it "finds the article to be edited" do
        article = FactoryGirl.create(:article_with_user)
        login(article.user)
        current_user_resource_owner(article)
        get :edit, id: article
        expect(assigns(:article)).to eq(article)
      end
    end

    context "with logged in user and without resource ownership" do
      it "does not get all categories and redirects to restricted" do
        user=FactoryGirl.create(:user)
        login(user)
        article = FactoryGirl.create(:article)
        current_user_resource_owner(article)
        categories = FactoryGirl.create(:category)
        get :edit, id: article
        expect(response).to redirect_to '/restricted'
      end

      it "does not find the article to be edited and redirects to restricted" do
        article = FactoryGirl.create(:article_with_user)
        user=FactoryGirl.create(:user)
        login(user)
        current_user_resource_owner(article)
        get :edit, id: article
        expect(response).to redirect_to '/restricted'
      end
    end

    describe "GET #create" do
      before :each do
          user=FactoryGirl.create(:user)
          login(user)
          @category=FactoryGirl.create(:category)
      end

     context "valid attributes" do
        it "creates a new article and saves it in the database" do
          expect{ post :create, category_id: @category, article: FactoryGirl.attributes_for(:article) }.to change(Article,:count).by(1)
        end

        it "redirects to the home page" do
          post :create, category_id: @category, article: FactoryGirl.attributes_for(:article)
          expect(response).to redirect_to category_articles_path(@category)
        end
      end

      context "invalid attributes" do
        it "does not save the new article" do
          expect{ post :create, category_id: @category, article: FactoryGirl.attributes_for(:invalid_article) }.to_not change(Article,:count)
        end

        it "re-renders the new method" do
          post :create, category_id: @category, article: FactoryGirl.attributes_for(:invalid_article)
          expect(response).to render_template :new
        end
      end
    end
   end

  describe "GET #createuncategorized" do
      before :each do
          user=FactoryGirl.create(:user)
          login(user)
          @category=FactoryGirl.create(:category)
      end

     context "valid attributes" do
        it "creates a new article and saves it in the database" do
          expect{ post :createuncategorized, article: FactoryGirl.attributes_for(:article) }.to change(Article,:count).by(1)
        end

        it "redirects to categories" do
          post :createuncategorized, article: FactoryGirl.attributes_for(:article, category_ids: @category.id)
          expect(response).to redirect_to categories_path
        end
      end

      context "with invalid attributes" do
        it "does not save the new article" do
          expect{ post :createuncategorized, article: FactoryGirl.attributes_for(:invalid_article) }.to_not change(Article,:count)
        end

        it "re-renders the newuncategorized method" do
          post :createuncategorized, article: FactoryGirl.attributes_for(:invalid_article)
          expect(response).to render_template :newuncategorized
        end
      end
  end

  describe 'PUT #update' do
      before :each do
        @article = FactoryGirl.create(:article_with_user, title: "Initial title", text: "Initial text")
        login(@article.user)
        current_user_resource_owner(@article)
      end

      context "valid attributes" do
        it "located the requested @article" do
          put :update, id: @article, article: FactoryGirl.attributes_for(:article)
          expect(assigns(:article)).to eq(@article)
        end

        it "changes @article's attributes" do
          put :update, id: @article, article: FactoryGirl.attributes_for(:article, title: "Initial title updated", text: "Initial text updated")
          @article.reload
          expect(@article.title).to eq("Initial title updated")
          expect(@article.text).to eq("Initial text updated")
        end

        it "redirects to the updated article" do
          put :update, id: @article, article: FactoryGirl.attributes_for(:article)
          expect(response).to redirect_to @article
        end
      end

      context "invalid attributes" do
        it "locates the requested @article" do
          put :update, id: @article, article: FactoryGirl.attributes_for(:invalid_article)
          expect(assigns(:article)).to eq(@article)
        end

         it "does not change @article's attributes" do
          put :update, id: @article, article: FactoryGirl.attributes_for(:article, title: nil, text: "Initial text updated")
          @article.reload
          expect(@article.title).to eq("Initial title")
          expect(@article.text).to_not eq("Initial text updated")
        end

        it "re-renders the edit method" do
          put :update, id: @article, article: FactoryGirl.attributes_for(:invalid_article)
          expect(response).to render_template :edit
        end
      end
  end

  describe 'DELETE #destroy' do
    before :each do
      @article = FactoryGirl.create(:article_with_user)
      login(@article.user)
      current_user_resource_owner(@article)
    end

    it "deletes the article" do
      expect{ delete :destroy, id: @article }.to change(Article,:count).by(-1)
    end

    it "redirects to /" do
      delete :destroy, id: @article
      expect(response).to redirect_to root_path
    end

    it "redirects to category_articles" do
      @category=FactoryGirl.create(:category)
      delete :destroy, id: @article, category_id: @category.id
      expect(response).to redirect_to category_articles_path(@category.id)
    end
  end

end
