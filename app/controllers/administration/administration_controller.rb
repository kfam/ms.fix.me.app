class Administration::AdministrationController < ApplicationController
	layout 'administration/application'

	def archive
		@model = params[:klass].constantize.find(params[:id])

		@model.archive!

		redirect_to :back
	end

	def publish
		@model = params[:klass].constantize.find(params[:id])

		@model.publish!

		redirect_to :back
	end

	def remove
		@model = params[:klass].constantize.find(params[:id])

		@model.remove!

		redirect_to :back
	end

	def unarchive
		@model = params[:klass].constantize.find(params[:id])

		@model.unarchive!

		redirect_to :back
	end

	def undelete
		@model = params[:klass].constantize.find(params[:id])

		@model.undelete!

		redirect_to :back
	end
end