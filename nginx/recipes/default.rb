package 'nginx'

cookbook_file '/etc/nginx/conf.d/backend.conf' do
	source 'backend.conf'
	notifies :restart, 'service[nginx]'
end

cookbook_file '/etc/nginx/conf.d/proxy.conf' do
	source 'proxy.conf'
	notifies :restart, 'service[nginx]'
end

cookbook_file '/etc/nginx/conf.d/ssl.conf' do
	source 'ssl.conf'
	notifies :restart, 'service[nginx]'
end

cookbook_file '/etc/nginx/conf.d/tokens.conf' do
	source 'tokens.conf'
	notifies :restart, 'service[nginx]'
end

service 'nginx' do
	action [:enable, :start]
end
