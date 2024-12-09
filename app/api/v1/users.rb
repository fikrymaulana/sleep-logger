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
          error!({ error: 'Cannot follow yourself' }, 422) if user.id == current_user.id

          status 200
          begin
            if current_user.followees.include?(user)
              { message: "You are already following #{user.name}" }
            else
              # Check for soft-deleted follow record first
              deleted_follow = Follow.only_deleted.find_by(follower: current_user, followee: user)
              if deleted_follow
                deleted_follow.recover
                { message: "You are now following #{user.name} again" }
              else
                Follow.create!(follower: current_user, followee: user)
                { message: "You are now following #{user.name}" }
              end
            end
          rescue ActiveRecord::RecordNotUnique
            # Handle race condition by restoring soft-deleted record
            deleted_follow = Follow.only_deleted.find_by(follower: current_user, followee: user)
            deleted_follow&.restore
            { message: "You are already following #{user.name}" }
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
