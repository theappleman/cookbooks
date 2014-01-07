if node['platform_family'] == 'debian' then
	package 'glusterfs-server'
	service 'glusterd'
else
	package 'glusterfs'
	service 'glusterd' do
		action [:enable, :start]
	end
end


