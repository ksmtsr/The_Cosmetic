class User < ApplicationRecord

  def self.guest
    find_or_create_by!(email: 'guest@test.com') do |user|
      user.password = SecureRandom.urlsafe_base64 # ランダムなパスワードを生成
    end
  end

end
