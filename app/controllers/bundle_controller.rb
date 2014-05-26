class BundleController < ApplicationController
	def create
		package_meta_data = []
		params[:versions].each do |versions|
			package_meta_data << {
				name: versions[:name],
				version: versions[:version],
				path: "/artifacts/#{versions[:name]}/#{versions[:version]}"
			}
		end
		file_name = Time.now().strftime("%Y-%m-%d-%H-%M-%S")
		f = File.new("#{$REPO_BASE}/bundle/#{file_name}", "w")
		f.write(package_meta_data.to_s)
		f.close
		Dir.chdir("#{$REPO_BASE}/bundle/") do 
			system("rm latest; ln -s #{file_name} latest")	
		end

		render text: "created"
	end
end
