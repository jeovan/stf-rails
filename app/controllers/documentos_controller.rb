class DocumentosController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
    response = RestClient.get(
      "https://api-test-09.herokuapp.com/documentos",{
      }
    )
    @documentos = JSON.parse(response.body)
  end

  def show
  end

  def edit
  end

  def new
  end

  def create
    response = RestClient.post(
      "https://api-test-09.herokuapp.com/documentos",
      {:nome => params[:nome], :blob => params[:arquivo].tempfile }
    )
    redirect_to :action => "index"
  rescue RestClient::ExceptionWithResponse => e
    @error = e.response
    render :new
  rescue Exception => e
    @error = e.message
    render :new
  end

  def download
    response = RestClient.get(
      
      %Q{https://api-test-09.herokuapp.com/documentos/#{params[:id]}/download}
    )

    send_data(response.body, :filename => params[:nome])
  end
  
  def destroy
    response = RestClient.delete(
      %Q{https://api-test-09.herokuapp.com/documentos/#{params[:id]}}
    )
    redirect_to :action => "index"
  end

end
