# jobs_controller.rb

# class Api::V01::JobsController < Api::V01::BaseController
#   # returns Routing Error: uninitialized constant Api::V01::BaseController
class Api::V01::JobsController < ApplicationController

  # automatically respond to json using the responders gem.
  respond_to :json

  # Job listing - app/javascript/components/job_listing.jsx
  def index
    # respond_with :api, :v01, Job.all
    # render :json => {Job.all.to_json}
    begin
      jobs = Job.all
    rescue
      # capture exception on destroy
      render :json => {}, status: 422
    else
      # if no errors, return 200 (OK with data)
      # else error return 422 - Unprocessable Entity
      render :json => jobs.to_json, status: (jobs ? 200 : 422)
    end
  end

  # Create Job - app/javascript/components/new_job.jsx
  def create
    # respond_with :api, :v01, Job.create(job_params)
    # render :json => {Job.create(job_params).to_json}
    begin
      job = Job.create(job_params)
    rescue
      # capture exception on destroy
      render :json => {}, status: 422
    else
      # if create has no errors, return 200 (OK with data)
      # else error return 422 - Unprocessable Entity
      render :json => job.to_json, status: (job ? 200 : 422)
    end
  end

  # Delete Job - app/javascript/components/body.jsx
  def destroy
    begin
      job = Job.destroy(params[:id])
    rescue
      # capture exception on destroy
      render :json => {}, status: 422
    else
      # if no errors (if job is returned as frozen/true), return 200 (OK with data)
      # else error return 422 - Unprocessable Entity
      # note HTTP destroy does not return data
      render :json => {}, status: (job ? 204 : 422)
    end
  end

  # Edit/Update Job - app/javascript/components/job.jsx
  def update
    begin
      job = Job.find(params[:id])
      job.update_attributes(job_params)
    rescue
      # capture exception on update
      render :json => {}, status: 422
    else
      # if no exception on update, return status based upon error count
      # note HTTP put does not return data
      # to do - return errors to user interface
      render :json => {}, status: (job.errors.count == 0 ? 204 : 422)
    end
  end

  private

  def job_params
    params.require(:job).permit(:id, :recruiter, :company)
  end

end
