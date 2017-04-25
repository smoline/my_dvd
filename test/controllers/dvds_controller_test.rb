require 'test_helper'

class DvdsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @dvd = dvds(:one)
  end

  test "should get index" do
    get dvds_url
    assert_response :success
  end

  test "should get new" do
    get new_dvd_url
    assert_response :success
  end

  test "should create dvd" do
    assert_difference('Dvd.count') do
      post dvds_url, params: { dvd: { disc_type: @dvd.disc_type, title: @dvd.title } }
    end

    assert_redirected_to dvd_url(Dvd.last)
  end

  test "should show dvd" do
    get dvd_url(@dvd)
    assert_response :success
  end

  test "should get edit" do
    get edit_dvd_url(@dvd)
    assert_response :success
  end

  test "should update dvd" do
    patch dvd_url(@dvd), params: { dvd: { disc_type: @dvd.disc_type, title: @dvd.title } }
    assert_redirected_to dvd_url(@dvd)
  end

  test "should destroy dvd" do
    assert_difference('Dvd.count', -1) do
      delete dvd_url(@dvd)
    end

    assert_redirected_to dvds_url
  end
end
