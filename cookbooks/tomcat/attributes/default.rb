# OpenJDK 7
default['tomcat']['openjdk']['package'] = 'java-1.7.0-openjdk-devel'

# Tomcat user/group
default['tomcat']['user'] = 'tomcat'
default['tomcat']['group'] = 'tomcat'

# Tomcat binary
default['tomcat']['binary']['source'] = 'http://mirror.reverse.net/pub/apache/tomcat/tomcat-8/v8.5.31/bin/apache-tomcat-8.5.31.tar.gz'
default['tomcat']['binary']['checksum'] = '5849489ef163ef116085f3aad68197070211698b14c7fba1f1e0a7eddbd6b1c3'
default['tomcat']['binary']['local_path'] = "#{Chef::Config['file_cache_path']}/apache-tomcat-8.5.31.tar.gz"

# Sample WAR file
default['tomcat']['sample_war']['source'] = 'https://github.com/johnfitzpatrick/certification-workshops/raw/master/Tomcat/sample.war'
default['tomcat']['sample_war']['checksum'] = '89b33caa5bf4cfd235f060c396cb1a5acb2734a1366db325676f48c5f5ed92e5'
default['tomcat']['sample_war']['local_path'] = "#{Chef::Config['file_cache_path']}/sample.war"

# Tomcat install directory
default['tomcat']['install_directory'] = '/opt/tomcat'
