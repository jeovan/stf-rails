class ComandosController < ApplicationController
  def index

  end


  def motorista

    gr_identificacao = if params[:motorista][:cpf].present?
      "1#{params[:motorista][:cpf]}"
    elsif params[:motorista][:cnpj_proprietário].present?
      "2#{params[:motorista][:cnpj_proprietário]}"
    end

    motorista = Sitafe::SitafePessoa.exists?(
      :it_in_ultima_situacao => 9, 
      :gr_identificacao => gr_identificacao
    )

    @retorno = {
      :data => Time.now.strftime("%d/%m/%Y"),
      :status => '1'
    } if motorista

  end


  def veiculo
    @veiculo = Sitafe::SitafeVeiculo
    .find_by(:it_nu_placa => params[:veiculo][:placa])

    puts @veiculo.inspect
  end
end
