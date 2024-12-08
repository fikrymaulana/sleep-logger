module V1
  class Users < Grape::API
    before { authenticate! }
    version 'v1', using: :path

    resource :users do
      route_param :id do
        desc 'Follow a user'
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

        desc 'Unfollow a user'
        delete :unfollow do
          user = User.find(params[:id])

          error!({ error: 'Invalid user' }, 404) unless user.present?

          follow = current_user.follows.find_by(followee_id: user.id)
          follow&.destroy
          status 200
          { message: "You unfollowed #{user.name}" }
        end
      end
    end
  end
end
