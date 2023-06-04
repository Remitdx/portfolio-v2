class Game < ApplicationRecord
  has_many :players, dependent: :destroy # limiter nb joueur à 8

  validates :statut, presence: true,
            inclusion: { in: ["en préparation", "en cours", "terminée"] }
end
