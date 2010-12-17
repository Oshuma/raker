require File.join(File.dirname(__FILE__), 'test_helper')

describe 'TaskManager' do
  before(:each) do
    @tasks    = [
      ['raker:awesome','Namespaced awesome task'],
      ['raker:util','Do some utility stuff'],
      ['some_task','Some other task']
    ]
    @rakefile = File.join(File.dirname(__FILE__), 'Rakefile')
    @manager  = TaskManager.new(@rakefile)
  end

  it 'should return an array of tasks' do
    @manager.tasks.should.equal @tasks
  end

  it 'should run the given task' do
    @manager.run(@tasks.first.first).should.not.be false
  end

  it 'should raise RakefileNotFound' do
    lambda do
      TaskManager.new('/not_a_real/Rakefile')
    end.should.raise TaskManager::RakefileNotFound
  end

  it 'should return true if the given task exists' do
    @manager.has?(@tasks.first.first).should.be true
  end

  it 'should return false if the given task does not exists' do
    @manager.has?('no_one').should.be false
  end
end
