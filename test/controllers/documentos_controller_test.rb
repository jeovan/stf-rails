require "test_helper"

class DocumentosControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get documentos_index_url
    assert_response :success
  end

  test "should get show" do
    get documentos_show_url
    assert_response :success
  end

  test "should get edit" do
    get documentos_edit_url
    assert_response :success
  end

  test "should get new" do
    get documentos_new_url
    assert_response :success
  end
end
