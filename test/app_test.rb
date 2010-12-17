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
    get '/rake/'
    last_response.should.be.ok
  end

  it 'should list the tasks' do
    get '/rake/'
    @tasks.each do |task_name, task_desc|
      last_response.body.should.include?(task_name)
      last_response.body.should.include?(task_desc)
    end
  end

  it 'should run the given task' do
    task = @tasks.first.first
    get "/rake/#{task}/"
    last_response.should.be.ok
  end

  it 'should return 404 if task not found' do
    get "/rake/not_a_real_task/"
    last_response.should.be.not_found
  end

  it 'should redirect if not end with slash' do
    get "/rake/task"
    last_response.should.be.redirect
  end

  it 'should respond in different url' do
    custom_app = Rack::Raker::App.new(@rakefile, '/myapp/rack-rake/')
    resp = Rack::MockRequest.new(custom_app).get('/myapp/rack-rake/')
    resp.should.be.ok
  end

  it 'should link to tasks with new path' do
    custom_app = Rack::Raker::App.new(@rakefile, '/myapp/rack-rake/')
    resp = Rack::MockRequest.new(custom_app).get('/myapp/rack-rake/')
    resp.should.be.ok
    @tasks.each do |task, desc|
      resp.body.should.include?("/myapp/rack-rake/#{task}/")
    end
  end

  it 'should link to home with new path' do
    custom_app = Rack::Raker::App.new(@rakefile, '/myapp/rack-rake/')
    resp = Rack::MockRequest.new(custom_app).get("/myapp/rack-rake/#{@tasks.first.first}/")
    resp.should.be.ok
    resp.body.should.include?('"/myapp/rack-rake/"')
  end
end
