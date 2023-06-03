class Game < ApplicationRecord
  has_many :players, dependent: :destroy # limiter nb joueur à 10
end
