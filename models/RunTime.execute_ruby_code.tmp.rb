post '/execute_code' do
	begin
	  code = request.env["rack.input"].read # => obligatoire à ce jour car params[...] remplace les + par des espaces (traduction html)
		code = "begin
		  #{code}
		rescue Exception => e
		  puts e.backtrace[0] + ': ' + e.to_s
			 # puts e.backtrace[1..-1].each { |trace| \"\tfrom \" + trace }
		end"
		eval("begin $stdout = StringIO.new; #{code}; $stdout.string;ensure $stdout = STDOUT end")
	rescue Exception=>e
		e.message
	end
end