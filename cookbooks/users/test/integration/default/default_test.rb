# # encoding: utf-8

# Inspec test for recipe users::default

describe user('chef') do
  it { should exist }
end

describe sshd_config do
  its('PasswordAuthentication') { should eq 'yes' }
end
