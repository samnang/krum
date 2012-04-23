class GroupsController < ApplicationController
  before_filter :admin_required, :only => [:new, :create, :destroy]

  def index
    @groups = Group.search_for(params[:q])
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

  def submit
    new_group = Group.new(params[:new_group])
    if new_group.valid?
      NotifierMailer.new_group(new_group).deliver
      flash[:notice] = "The group will be moderated, and hopefully it will be added to site soon."
    else
      flash[:error] = "You didn't complete all required information on form."
    end

    redirect_to :back
  end
end
