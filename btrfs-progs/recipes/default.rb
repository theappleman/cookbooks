if node['platform_family'] == 'debian' then
	package 'btrfs-tools'
else
	package 'btrfs-progs'
end

