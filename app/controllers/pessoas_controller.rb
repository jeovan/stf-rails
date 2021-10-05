class PessoasController < ApplicationController
  def index
    @pessoas = Sitafe::SitafePessoa.all.limit(10)


    # @pessoas = Pessoa.all.limit(10)
  end
end
