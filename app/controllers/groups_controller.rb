class GroupsController < ApplicationController
  before_filter :admin_required, :only => [:new, :create, :destroy]

  def index
    @groups = Group.scoped
    @groups = @groups.search_for(params[:q]) if params[:q].present?
    @groups = GroupDecorator.decorate(@groups)
  end

  def new
    @group = Group.new
  end

  def create
    @group = Group.new(params[:group])
    if @group.save
      redirect_to groups_path, notice: "Group has been added successfully."
    else
      render :new
    end
  end

  def destroy
    @group = Group.find(params[:id])
    @group.destroy

    redirect_to groups_path, notice: "Group has been deleted successfully."
  end

  # Submit new group
  def submit
    # Send email to administrator with params[:new_group]
    warn "==== Not implemented yet ===="

    redirect_to :back, notice: "The group will be moderated, and hopefully it will be added to site soon."
  end
end
