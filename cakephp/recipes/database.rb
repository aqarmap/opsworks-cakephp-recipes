node[:deploy].each do |application, deploy|
	if deploy[:application_type] != 'php'
		Chef::Log.debug("Skipping cakephp::database application #{application} as it is not an PHP app")
		next
	end

	template "#{deploy[:deploy_to]}/current/app/Config/database.php" do
		source "database.php.erb"
		group deploy[:group]

		if platform?("ubuntu")
			owner "www-data"
		elsif platform?("amazon")   
			owner "apache"
		end

		mode "0644"
		variables(
			:db_host		=> (deploy[:database][:host] rescue nil),
			:db_name		=> (deploy[:database][:database] rescue nil),
			:db_user		=> (deploy[:database][:username] rescue nil),
			:db_password	=> (deploy[:database][:password] rescue nil)
		)
	end
end
