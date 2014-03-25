def insert_method_undef(original_code)
  undef_string = "undef :exec\nundef :system\nundef :`\n"
  code_first_line = original_code.split("\n")[0]
  if code_first_line && code_first_line.strip.start_with?("#encoding") then
    code_after_encoding = original_code.sub(/^#{code_first_line}\n/, '')
    code_first_line + "\n" + undef_string + code_after_encoding
  else
     undef_string + original_code
  end
end
  
def run_ruby(type, ruby_code, user, slide_index)
  file_name = "ruby_file_to_run.#{Time.now.to_f}.rb"
  file = File.new(file_name, 'w')
  ruby_code_with_method_undef = insert_method_undef(ruby_code)
  file << ruby_code_with_method_undef
  file.close
  result = `ruby #{file_name} 2>&1`
  File.delete(file)
  RunTimeEvent.new(user, type, slide_index, ruby_code, result).save
  result
end

require_relative '../db/Accesseur'  
$db = Accesseur.new

class RunTimeEvent
  attr_accessor :timestamp, :user, :type, :slide_index, :code_input, :code_output
  
  def initialize(user, type, slide_index, code_input, code_output, timestamp = nil)
    @timestamp = timestamp || Time.now.to_f
    @user = user
    @type = type
    @code_input = code_input
    @code_output = code_output
    @slide_index = slide_index
  end
  
  def save
    $db.execute_sql("insert into run_events values ('#{@timestamp}', '#{@user}', '#{@type}', '#{@slide_index}', '#{$db.format_to_sql(@code_input)}', '#{$db.format_to_sql(@code_output)}')")
  end
  
  def RunTimeEvent.find(user)
    RunTimeEvent.find_all.select { |event|  event.user == user }
  end

  def RunTimeEvent.find_last(slide_index, user_id = 0)
    (RunTimeEvent.find_all.select { |event|  event.slide_index == slide_index && ( user_id.nil? || user_id == 0 || event.user == user_id) && event.type == 'run'}).last
  end
  
  def RunTimeEvent.find_last_send(slide_index, user_id = 0)
    (RunTimeEvent.find_all.select { |event|  event.slide_index == slide_index && ( user_id.nil? || user_id == 0 || event.user == user_id) && event.type == 'send'}).last
  end  
  
  def RunTimeEvent.find_all
    events = $db.execute_sql("select timestamp, user_id, type, slide_index, code_input, code_output from run_events order by timestamp asc").values
    events.map { |tuple| RunTimeEvent.new(tuple[1], tuple[2], tuple[3], tuple[4], tuple[5], tuple[0]) }
  end
  
  def to_s
    ([@user, @type, @slide_index, @code_input, @code_output]).inspect
  end
  
end
