class ReqresImporter
  # Load data from ReqresIn API
  def load_users
    first_page = ReqresIn.new(1).users
    users = first_page['data']
    total_pages = first_page['total_pages']
    (2..total_pages).each do |page|
      users += ReqresIn.new(page).users['data']
    end
    users
  end

  # Create users from the data loaded from ReqresIn API
  def create_users
    users = load_users
    users.each do |user|
      User.where(email: user['email']).first_or_create(
        first_name: user['first_name'],
        last_name: user['last_name'],
        avatar: user['avatar'],
        reqres_id: user['id']
      )
    end
  end
end
