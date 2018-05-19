# # encoding: utf-8

# Inspec test for recipe tomcat::server

describe package('java-1.7.0-openjdk-devel') do
  it { should be_installed }
end

describe group('tomcat') do
  it { should exist }
end

describe user('tomcat') do
  it { should exist }
  its('group') { should eq 'tomcat' }
end

describe directory('/opt/tomcat/conf') do
  it { should exist }
  its('group') { should eq 'tomcat' }
  its('mode') { should cmp '0700' }
end

directories = [
  '/opt/tomcat/webapps',
  '/opt/tomcat/work',
  '/opt/tomcat/temp',
  '/opt/tomcat/logs',
]

directories.each do |directory|
  describe directory(directory) do
    it { should exist }
    its('group') { should eq 'tomcat' }
    its('mode') { should cmp '0750' }
  end
end

systemd_unit_content = <<-EOH
# Systemd unit file for tomcat
[Unit]
Description=Apache Tomcat Web Application Container
After=syslog.target network.target

[Service]
Type=forking

Environment=JAVA_HOME=/usr/lib/jvm/jre
Environment=CATALINA_PID=/opt/tomcat/temp/tomcat.pid
Environment=CATALINA_HOME=/opt/tomcat
Environment=CATALINA_BASE=/opt/tomcat
Environment='CATALINA_OPTS=-Xms512M -Xmx1024M -server -XX:+UseParallelGC'
Environment='JAVA_OPTS=-Djava.awt.headless=true -Djava.security.egd=file:/dev/./urandom'

ExecStart=/opt/tomcat/bin/startup.sh
ExecStop=/bin/kill -15 $MAINPID

User=tomcat
Group=tomcat

[Install]
WantedBy=multi-user.target
EOH

describe file('/etc/systemd/system/tomcat.service') do
  it { should exist }
  its('content') { should eq systemd_unit_content }
end

describe port(8181) do
  it { should be_listening }
end

describe command('curl http://localhost:8181') do
  its('stdout') { should match /Apache Tomcat/ }
end
