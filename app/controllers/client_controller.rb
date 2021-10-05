class ClientController < ApplicationController

  def index
    response = RestClient.get(
      "http://localhost:3000/pessoas/index.json"
    )

    @pessoas = JSON.parse(response.body)

    # puts response.code


  end
end
