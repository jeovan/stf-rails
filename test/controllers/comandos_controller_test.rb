require "test_helper"

class ComandosControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get comandos_index_url
    assert_response :success
  end
end
