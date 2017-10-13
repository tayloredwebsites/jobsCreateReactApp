# jobs_controller.rb

# class Api::V01::JobsController < Api::V01::BaseController
#   # returns Routing Error: uninitialized constant Api::V01::BaseController
class Api::V01::JobsController < ApplicationController

  # automatically respond to json using the responders gem.
  respond_to :json

  # Job listing - app/javascript/components/job_listing.jsx
  def index
    respond_with Job.all
  end

  # Create Job - app/javascript/components/new_job.jsx
  def create
    respond_with :api, :v01, Job.create(job_params)
  end

  # Delete Job - app/javascript/components/body.jsx
  def destroy
    respond_with Job.destroy(params[:id])
  end

  # Edit/Update Job - app/javascript/components/job.jsx
  def update
    job = Job.find(params[:id])
    job.update_attributes(job_params)
    respond_with job, json: job
  end

  private

  def job_params
    params.require(:job).permit(:id, :recruiter, :company)
  end

end
