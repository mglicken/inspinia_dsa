class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  belongs_to :person
  belongs_to :access
  has_many  :favorite_slides, :dependent => :destroy
  has_many :slides, :through => :favorite_slides
  has_many :slide_layouts, :dependent => :destroy
  has_many :company_follows, :dependent => :destroy  
  has_many :companies, :through => :company_follows  
  has_many :sponsor_follows, :dependent => :destroy  
  has_many :sponsors, :through => :sponsor_follows
  has_many :deal_follows, :dependent => :destroy  
  has_many :deals, :through => :deal_follows
end