require File.join(File.dirname(__FILE__), 'test_helper')

describe TaskManager do
  before(:each) do
    @tasks    = ['raker:awesome', 'raker:util', 'some_task']
    @rakefile = File.join(File.dirname(__FILE__), 'Rakefile')
    @manager  = TaskManager.new(@rakefile)
  end

  it 'should return an array of tasks' do
    @manager.tasks.should.equal @tasks
  end

  it 'should run the given task' do
    @manager.run(@tasks.first).should.not.be false
  end
end
