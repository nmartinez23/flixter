class LessonsController < ApplicationController
	before_action :authenticate_user!		
	before_action :require_authorized_for_current_lesson, :only => [:show]

	def require_authorized_for_current_lesson
		if ! current_user.enrolled_in?(current_lesson.section.course)
			redirect_to course_path(current_lesson.section.course), :alert => 'Please enroll to access this course'
		end
	end

	def show
	end

	private

	helper_method :current_lesson
	def current_lesson
		@current_lesson ||= Lesson.find(params[:id])
	end
end
