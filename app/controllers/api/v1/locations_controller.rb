class Api::V1::LocationsController < ApplicationController
  def towns
    towns = [
      "Gbanikola", "Bimbo", "Damara", "Boy-Rabe", "Kokoro",
      "Gobongo", "Malimaka", "Sica 1", "Sica 2", "Sica 3"
    ]
    render json: { towns: towns }
  end
end
