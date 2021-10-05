json.array! @pessoas do |pessoa|
  json.it_no_pessoa(pessoa.it_no_pessoa)
  json.gr_identificacao(pessoa.gr_identificacao)
  json.it_nu_inscricao_estadual pessoa.it_nu_inscricao_estadual
end
