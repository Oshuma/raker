require File.join(File.dirname(__FILE__), 'test_helper')

describe 'Raker' do
  before(:each) do
    @rakefile = File.join(File.dirname(__FILE__), 'Rakefile')
  end

  it 'should require authentication' do
    app = Rack::Raker.new(@rakefile, '/rake', { 'user' => 'raker' })
    res = Rack::MockRequest.new(app).get('/rake/')
    res.status.should.be 401
  end

  it 'should authenticate user' do
    app = Rack::Raker.new(@rakefile, '/rake', { 'user' => 'raker' })
    @request = Rack::MockRequest.new(app)

    request_with_digest_auth('GET', '/rake/', 'user', 'raker') do |response|
      response.status.should.be 200
    end
  end
end

def request(method, path, headers = {}, &block)
  response = @request.request(method, path, headers)
  block.call(response) if block
  return response
end

def request_with_digest_auth(method, path, username, password, options = {}, &block)
  request_options = {}
  request_options[:input] = options.delete(:input) if options.include? :input

  response = request(method, path, request_options)

  return response unless response.status == 401

  if wait = options.delete(:wait)
    sleep wait
  end

  challenge = response['WWW-Authenticate'].split(' ', 2).last

  params = Rack::Auth::Digest::Params.parse(challenge)

  params['username'] = username
  params['nc'] = '00000001'
  params['cnonce'] = 'nonsensenonce'
  params['uri'] = path

  params['method'] = method

  params.update options

  params['response'] = MockDigestRequest.new(params).response(password)

  request(method, path, request_options.merge('HTTP_AUTHORIZATION' => "Digest #{params}"), &block)
end

class MockDigestRequest
  def initialize(params)
    @params = params
  end
  def method_missing(sym)
    if @params.has_key? k = sym.to_s
      return @params[k]
    end
    super
  end
  def method
    @params['method']
  end
  def response(password)
    Rack::Auth::Digest::MD5.new(nil).send :digest, self, password
  end
end
