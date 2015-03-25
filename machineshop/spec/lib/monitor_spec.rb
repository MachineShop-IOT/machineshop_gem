require_relative '../spec_helper'

MachineShop.api_base_url= 'localhost:3000/api/v1'
publisher_username = 'publisher@csr.com'
publisher_password = 'password'

auth_token, user = MachineShop::Users.authenticate(
:email => publisher_username,
:password => publisher_password
)

element_data=nil
describe MachineShop::Monitor do

  it "should get all monitor data" do
    element_data = MachineShop::Monitor.all({}, auth_token)

    # puts "element_data from all: #{element_data}"

    expect(element_data).not_to be_nil
    expect(element_data).not_to be_empty
  end

  it "should get monitor by id " do

    monitor_id = element_data[0].id
    ap "retrieving monitor for id #{monitor_id}"

    # element_data = MachineShop::Monitor.retrieve(monitor_id, auth_token)
    element_data = MachineShop::Monitor.retrieve(monitor_id, auth_token)
    # puts "monitor by id : #{element_data}"
    expect(element_data).not_to be_nil
    # element_data.should_not be_nil
  end

it "rule_last_run_summary" do
  summary = MachineShop::Monitor.rule_last_run_summary(auth_token)
  ap "rule last run summary"
  ap summary
  expect(summary).not_to be_nil
end

it "total_reports_per_day" do
  total_reports_per_day = MachineShop::Monitor.total_reports_per_day("2014-06-01", "2014-08-01",auth_token)
  ap "rule total_reports_per_day"
  ap total_reports_per_day
  expect(total_reports_per_day).not_to be_nil
end

end