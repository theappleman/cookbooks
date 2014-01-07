if node['platform'] == "gentoo" then
	service 'chef-client' do
		action [ :enable, :start ]
	end
end
