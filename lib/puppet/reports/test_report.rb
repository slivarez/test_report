require 'puppet'
require 'facter' 

Puppet::Reports.register_report(:test_report) do

desc <<-DESC
Test report processor.
DESC

  def process
	destination = "/tmp/test_report.log"
	host = self.host
	ipaddress = Facter.value('ipaddress')
	nodeip = open("/var/lib/puppet/yaml/facts/#{self.host}.yaml").grep(/^(\s+)?ipaddress:(\s+)/).first.gsub(/.*\s+(\d+\.\d+\.\d+\.\d+).*/, '\1') 
        debug = "DEBUG: host = #{host} ipaddress = #{ipaddress} nodeip = #{nodeip}"
	File.open(destination,"a") do |f| 
		f.write(debug)
	end
  end
end
