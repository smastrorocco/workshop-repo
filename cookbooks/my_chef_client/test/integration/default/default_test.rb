# # encoding: utf-8

# Inspec test for recipe my_chef_client::default

describe service('chef-client') do
  it { should be_running }
end
