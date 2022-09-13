class GroupsController < ApplicationController
	before_action :find_group, only: [:show, :edit]
	def index
		@groups = Group.all
	end

	def new
		@group = Group.new
	end	

	def create
		@group = Group.new(group_params)
		@group.owner_id = current_user.id
		if @group.save
			 Membership.create(group_id: @group.id, user_id: current_user.id)
			redirect_to groups_path
		else
			render :new	
		end
	end

	def edit
	end

  def update
    @group = Group.find_by_id(params[:id])
    if @group.update(group_params)
      redirect_to groups_path
    else
      render :new 
    end
  end  

	def show

	end

	def created_by_me
		@groups = Group.owned_group(current_user)
	end

	def join_group
		membership = Membership.new(group_id: params[:id], user_id: current_user.id)
		if membership.save
			redirect_to groups_path
		end
	end

  def remove_member
    membership = Membership.find_by(user_id: params[:user_id], group_id: params[:id])
    if membership.delete
      redirect_to group_path(params[:id])
    end
  end 

	def where_i_am_member
		@groups = current_user.groups
	end

	private

	def group_params
		params.require(:group).permit(:name)
	end	

	def find_group
		@group = Group.find_by_id(params[:id])
	end	
end
