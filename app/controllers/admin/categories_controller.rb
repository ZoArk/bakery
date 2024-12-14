class Admin::CategoriesController < Admin::BaseController
  before_action :set_category, only: [:show, :edit, :update, :destroy]


  # GET /admin/categories
  def index
    @categories = Category.all
  end

  # GET /admin/categories/:id
def show
  # The @category is already set by the set_category callback
end

  # GET /admin/categories/new
  def new
    @category = Category.new
  end

  # POST /admin/categories
  def create
    @category = Category.new(category_params)
    if @category.save
      redirect_to admin_categories_path, notice: 'Category was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  # GET /admin/categories/:id/edit
  def edit
  end

  # PATCH/PUT /admin/categories/:id
  def update
    @category = Category.find(params[:id])

    if @category.update(category_params)
      redirect_to admin_categories_path, notice: 'Category was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /admin/categories/:id
  def destroy
    @category.destroy
    redirect_to admin_categories_path, notice: 'Category was successfully deleted.'
  end

  private

  def set_category
    @category = Category.find(params[:id])
  end

  def category_params
    params.require(:category).permit(:name, :description)
  end
end
