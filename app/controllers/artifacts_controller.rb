class ArtifactsController < ApplicationController
	def get
		this_repo_base = "#{$REPO_BASE}/#{params[:name]}"
		if Dir.exists?(this_repo_base)
			if params[:version].upcase == "LATEST"
				send_file get_lastest this_repo_base
			else
				send_file get_with_version this_repo_base, params[:version]
			end
		else
			render status: 404, text: "artifact not found"
		end
	end

	private

	def get_lastest this_repo_base
		all_files = Dir.glob("#{this_repo_base}/*")
		file_versions = all_files.map do |file|
			file =~ /.*\/[^\/]*-(.*)\..*/
			$1
		end
		sorted_file_version = 
			all_files.zip(file_versions).sort_by {|tuple1, tuple2| tuple1[1] <=> tuple2[1]}
		sorted_file_version[-1][0]
	end

	def get_with_version this_repo_base, version
		Dir.glob("#{this_repo_base}/*").find do |file|
			file =~ /.*\/[^\/]*-(.*)\..*/
			$1 == version
		end
	end
end
