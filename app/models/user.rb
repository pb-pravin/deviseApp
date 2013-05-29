class User
  attr_accessor :org_id, :id, :password, :name, :acl, :term_id
  
  include ActiveModel::Validations #required because some before_validations are defined in devise
  extend ActiveModel::Callbacks #required to define callbacks
  extend Devise::Models

  define_model_callbacks :validation #required by Devise
  
  devise :remote_authenticatable, :timeoutable
  
  def initialize(org_id = nil, term_id = nil, id = nil, password = nil, name = nil, acl = nil)
    @org_id = org_id
    @term_id = term_id
    @id = id
    @password = password
    @name = name
    @acl = acl
  end
  
#class User < ActiveRecord::Base
#  # Include default devise modules. Others available are:
#  # :token_authenticatable, :confirmable,
#  # :lockable, :timeoutable and :omniauthable
#  devise :database_authenticatable, :registerable,
#         :recoverable, :rememberable, :trackable, :validatable
#
#  # Setup accessible (or protected) attributes for your model
#  attr_accessible :email, :password, :password_confirmation, :remember_me
#  # attr_accessible :title, :body
end
