class GroupsController < ApplicationController
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

	def created_by_me
		@groups = Group.owned_group(current_user)
	end

	def join_group
		membership = Membership.new(group_id: params[:id], user_id: current_user.id)
		if membership.save
			redirect_to groups_path
		end
	end

	def where_i_am_member
		@groups = current_user.groups
	end

	private

	def group_params
		params.require(:group).permit(:name)
	end		
end
