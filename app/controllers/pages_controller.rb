class PagesController < ApplicationController
  before_action :authenticate_user!

  def index
    @plans = current_user.lists.first.plans
    @list = current_user.lists.first
    @plan = Plan.new
    @all_plan = Plan.where.not(title: nil)
    @all_plan_order = @all_plan.sort.reverse[0..14]
    @uncompleted_plan = Plan.where(:completion => false).sort[0..2]
    @completed_plan = Plan.where(:completion => true).sort[0..2]

    User.all.each do |user|
      if user.has_role? :admin
        @admin = user
        @admin_list = @admin.lists.first.plans
      end
    end
  end

end
