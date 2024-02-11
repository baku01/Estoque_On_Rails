class RedirectMiddleware
  def initialize(app)
    @app = app
  end

  def call(env)
    status, headers, response = @app.call(env)

    if status == 404
      [302, {'Location' => '/admin/login', 'Content-Type' => 'text/html'}, ['Moved Permanently']]
    else
      [status, headers, response]
    end
  end
end