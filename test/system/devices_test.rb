require "application_system_test_case"

class DevicesTest < ApplicationSystemTestCase
  setup do
    @device = devices(:one)
  end

  test "visiting the index" do
    visit devices_url
    assert_selector "h1", text: "Devices"
  end

  test "should create device" do
    visit devices_url
    click_on "New device"

    check "Active" if @device.active
    fill_in "Device type", with: @device.device_type
    fill_in "Hostname", with: @device.hostname
    fill_in "Ip address", with: @device.ip_address
    fill_in "Mac address", with: @device.mac_address
    fill_in "Notes", with: @device.notes
    fill_in "Purchase date", with: @device.purchase_date
    fill_in "Serial number", with: @device.serial_number
    fill_in "Warranty until", with: @device.warranty_until
    click_on "Create Device"

    assert_text "Device was successfully created"
    click_on "Back"
  end

  test "should update Device" do
    visit device_url(@device)
    click_on "Edit this device", match: :first

    check "Active" if @device.active
    fill_in "Device type", with: @device.device_type
    fill_in "Hostname", with: @device.hostname
    fill_in "Ip address", with: @device.ip_address
    fill_in "Mac address", with: @device.mac_address
    fill_in "Notes", with: @device.notes
    fill_in "Purchase date", with: @device.purchase_date
    fill_in "Serial number", with: @device.serial_number
    fill_in "Warranty until", with: @device.warranty_until
    click_on "Update Device"

    assert_text "Device was successfully updated"
    click_on "Back"
  end

  test "should destroy Device" do
    visit device_url(@device)
    click_on "Destroy this device", match: :first

    assert_text "Device was successfully destroyed"
  end
end
