# HTTParty's get request to the reqres.in API
class ReqresIn
  include HTTParty
  base_uri 'https://reqres.in/api'

  # Initialize the class object with the given options
  def initialize(page)
    @options = { query: { page: page } }
  end

  # GET /api/users
  # Returns a json list of users per page, containing 6 main keys: page, per_page, total, total_pages,
  # data(id, email, first_name, last_name, avatar), support(url, text)
  def users
    self.class.get('/users', @options)
  end
end
