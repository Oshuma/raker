require File.join(File.dirname(__FILE__), 'test_helper')

describe 'App' do
  include Rack::Test::Methods

  before(:each) do
    @tasks    = [
      ['raker:awesome','Namespaced awesome task'],
      ['raker:util','Do some utility stuff'],
      ['some_task','Some other task']
    ]
    @rakefile = File.join(File.dirname(__FILE__), 'Rakefile')
  end

  def app(raker_app = nil)
    raker_app || Rack::Raker::App.new(@rakefile)
  end

  it 'should respond to the default index path' do
    get '/rake'
    last_response.should.be.ok
  end

  it 'should list the tasks' do
    get '/rake'
    @tasks.each do |task_name, task_desc|
      last_response.body.should.include?(task_name)
      last_response.body.should.include?(task_desc)
    end
  end

  it 'should run the given task' do
    task = @tasks.first.first
    get "/rake/#{task}"
    last_response.should.be.ok
  end

  it 'should redirect if task not found' do
    get '/rake/not_a_real_task'
    last_response.should.be.redirect
  end
end
