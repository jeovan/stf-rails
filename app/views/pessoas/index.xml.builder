xml.tag!('pessoas') do
  @pessoas.each do |pessoa|
    xml.tag!('pessoa') do
    xml.it_no_pessoa pessoa.it_no_pessoa
    xml.gr_identificacao pessoa.gr_identificacao
    xml.it_nu_inscricao_estadual pessoa.it_nu_inscricao_estadual
    end
  end
end
