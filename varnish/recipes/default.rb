package 'varnish'

cookbook_file '/etc/varnish/default.vcl' do
	source 'default.vcl'
	notifies :restart, 'service[varnish]'
end

cookbook_file '/etc/default/varnish' do
	source 'varnish'
	notifies :restart, 'service[varnish]'
end

service 'varnish' do
	action [:enable, :start]
end
