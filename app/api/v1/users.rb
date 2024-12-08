module V1
  class Users < Grape::API
    before { authenticate! }
    version 'v1', using: :path

    resource :users do
      desc 'Follow a user'
      route_param :id do
        post :follow do
          user = User.find(params[:id])

          error!({ error: 'Invalid user' }, 404) unless user.present?

          status 200
          if current_user.followees.include?(user)
            { message: "You are already following #{user.name}" }
          else
            current_user.followees << user
            { message: "You are now following #{user.name}" }
          end
        end
      end
    end
  end
end
