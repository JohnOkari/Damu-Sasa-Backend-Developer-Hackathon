require "test_helper"

class PrescriptionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @prescription = prescriptions(:one)
  end

  test "should get index" do
    get prescriptions_url, as: :json
    assert_response :success
  end

  test "should create prescription" do
    assert_difference("Prescription.count") do
      post prescriptions_url, params: { prescription: { appointment_id: @prescription.appointment_id, instructions: @prescription.instructions, medication: @prescription.medication, user_id: @prescription.user_id } }, as: :json
    end

    assert_response :created
  end

  test "should show prescription" do
    get prescription_url(@prescription), as: :json
    assert_response :success
  end

  test "should update prescription" do
    patch prescription_url(@prescription), params: { prescription: { appointment_id: @prescription.appointment_id, instructions: @prescription.instructions, medication: @prescription.medication, user_id: @prescription.user_id } }, as: :json
    assert_response :success
  end

  test "should destroy prescription" do
    assert_difference("Prescription.count", -1) do
      delete prescription_url(@prescription), as: :json
    end

    assert_response :no_content
  end
end
