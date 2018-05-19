# # encoding: utf-8

# Inspec test for recipe tomcat::default

describe package('java-1.7.0-openjdk-devel') do
  it { should be_installed }
end

describe user('tomcat') do
  it { should exist }
  its('group') { should eq 'tomcat' }
end
