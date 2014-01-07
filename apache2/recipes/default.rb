package 'apache2'

cookbook_file '/etc/apache2/conf.d/headers' do
	source 'headers'
	notifies :restart, 'service[apache2]'
end

cookbook_file '/etc/apache2/conf.d/rax-maxclients' do
	source 'rax-maxclients'
	notifies :restart, 'service[apache2]'
end

cookbook_file '/etc/apache2/conf.d/reqtimeout.conf' do
	source 'reqtimeout.conf'
	notifies :restart, 'service[apache2]'
end

cookbook_file '/etc/apache2/conf.d/rewrite' do
	source 'rewrite'
	notifies :restart, 'service[apache2]'
end

cookbook_file '/etc/apache2/conf.d/security' do
	source 'security'
	notifies :restart, 'service[apache2]'
end

cookbook_file '/etc/apache2/ports.conf' do
	source 'ports.conf'
	notifies :restart, 'service[apache2]'
end

link '/etc/apache2/mods-enabled/expires.load' do
	to '../mods-available/expires.load'
	notifies :restart, 'service[apache2]'
end

service 'apache2' do
	action [:enable, :start]
end
