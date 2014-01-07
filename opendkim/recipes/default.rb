package 'opendkim'

cookbook_file '/etc/opendkim.conf' do
	source 'opendkim.conf'
	mode '0644'
	notifies :restart, 'service[opendkim]'
end

directory '/etc/opendkim' do
	action :create
	owner 'opendkim'
	group 'opendkim'
end

cookbook_file '/etc/opendkim/TrustedHosts' do
	source 'TrustedHosts'
	mode '0644'
	notifies :restart, 'service[opendkim]'
end

template '/etc/opendkim/SigningTable' do
	source 'SigningTable.erb'
	variables({
		:domains => [ "xxoo.ws", "xywyt.com", "applehq.eu"]
	})
	notifies :restart, 'service[opendkim]'
end

template '/etc/opendkim/KeyTable' do
	source 'KeyTable.erb'
	variables({
		:domains => node.default['keys']
	})
	notifies :restart, 'service[opendkim]'
end

service 'opendkim' do
	action [:enable]
end

