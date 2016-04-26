class StudentGroupsController < ApplicationController
  def index
    @student_groups = StudentGroup.all
  end

  def new
    @student_group = StudentGroup.new
  end

  def create
    @student_group = StudentGroup.new(student_group_params)
    if @student_group.save
      redirect_to student_groups_path
    else
      render :new
    end
  end

  def edit
    @student_group = StudentGroup.find(params[:id])
  end

  def update
    @student_group = StudentGroup.find(params[:id])
    if @student_group.update_attributes(student_group_params)
      redirect_to student_groups_path
    else
      render :edit
    end
  end

  def destroy
    student_group = StudentGroup.find(params[:id])
    student_group.destroy
    render nothing: true
  end

  private

  def student_group_params
    params.require(:student_group).
      permit(
        :suffix,
        :promotion,
        :profile_slug,
        :main_teacher_id
      )
  end
end
