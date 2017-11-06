require 'test_helper'

class Api::V01::JobsControllerTest < ActionDispatch::IntegrationTest

  fixtures :jobs

  setup do
    Rails.logger.debug("+++ setup completed +++")
  end

  test "should get jobs list from jobs index" do

    # note jobs fixture is empty array, even though test data is populated with the fixture
    assert_equal 0, jobs.count

    get api_v01_jobs_url(:format => :json)
    assert_response :success
    jobs = JSON.parse(@response.body)
    assert_equal 2, jobs.count

    # add a new job
    post api_v01_jobs_url(:format => :json), params: { job: { recruiter: 'Recruiter 3', company: 'Company 3' } }
    assert_response :success
    job = JSON.parse(@response.body)
    assert_equal('Recruiter 3', job['recruiter'])
    assert_equal('Company 3', job['company'])

    # confirm index returns third job
    get api_v01_jobs_url(:format => :json)
    assert_response :success
    jobs = JSON.parse(@response.body)
    assert_equal 3, jobs.count
    assert_equal('MyString', jobs[0]['recruiter'])
    assert_equal('MyString', jobs[1]['recruiter'])
    assert_equal('Recruiter 3', jobs[2]['recruiter'])
    assert_equal('Company 3', jobs[2]['company'])

    addedJobId = jobs[2]['id']

    # edit newly added job
    put api_v01_job_url(:format => :json, id: addedJobId), params: { job: { recruiter: 'Recruiter 3b', company: 'Company 3b' } }
    assert_response :success

    # confirm index returns updated third job
    get api_v01_jobs_url(:format => :json)
    assert_response :success
    jobs = JSON.parse(@response.body)
    assert_equal 3, jobs.count
    assert_equal('MyString', jobs[0]['recruiter'])
    assert_equal('MyString', jobs[1]['recruiter'])
    assert_equal('Recruiter 3b', jobs[2]['recruiter'])
    assert_equal('Company 3b', jobs[2]['company'])

    # try to edit job that doesn't exist (addedJobId + 9999)
    put api_v01_job_url(:format => :json, id: addedJobId+9999), params: { job: { recruiter: 'Recruiter 3z', company: 'Company 3z' } }
    assert_response 422

    # delete newly added job
    delete api_v01_job_url(:format => :json, id: jobs[2]['id'])
    assert_response :success

    # confirm index returns no third job (that was just deleted)
    get api_v01_jobs_url(:format => :json)
    assert_response :success
    jobs = JSON.parse(@response.body)
    assert_equal 2, jobs.count
    assert_equal('MyString', jobs[0]['recruiter'])
    assert_equal('MyString', jobs[1]['recruiter'])

    # try to delete job that doesn't exist (addedJobId + 9999)
    delete api_v01_job_url(:format => :json, id: addedJobId+9999)
    assert_response 422

  end

end
