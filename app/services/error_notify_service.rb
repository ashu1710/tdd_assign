class ErrorNotifyService
	def initialize(error_message)
		@error_message = error_message
		manage_error_in_file
	end


	def manage_error_in_file
      	txt_content = "Error Time: #{Time.now}\t Error: #{@error_message}\n"
	    
	    file_name = "error_message.txt"
	    file_path = "#{Rails.root}/public/#{file_name}"
	    
	    File.open(file_path, 'a') do |file|
	      file.write(txt_content)
	    end

	    file_name
	end
end