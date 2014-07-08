class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  ## Database authenticatable
  #field :email,              :type => String, :default => ""
  #field :encrypted_password, :type => String, :default => ""

  ## Recoverable
  #field :reset_password_token,   :type => String
  #field :reset_password_sent_at, :type => Time

  ## Rememberable
  #field :remember_created_at, :type => Time

  #field :admin,    type: Boolean, default: false
  #field :approved, type: Boolean, default: false

  def active_for_authentication?
    super && approved?
  end

  def inactive_message
    if !approved?
      :not_approved
    else
      super # Use whatever other message
    end
  end

  def self.send_reset_password_instructions(attributes={})
    recoverable = find_or_initialize_with_errors(reset_password_keys, attributes, :not_found)
    if !recoverable.approved?
      recoverable.errors[:base] << I18n.t("devise.failure.not_approved")
    elsif recoverable.persisted?
      recoverable.send_reset_password_instructions
    end
    recoverable
  end
end
