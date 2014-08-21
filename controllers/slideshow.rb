require 'sinatra'

set :public_folder, 'public'
set :views, 'views'
set :logging, false

set :bind, '0.0.0.0'
set :show_exceptions, false

enable :sessions; set :session_secret, 'secret'

require_relative 'slideshow_helper'

require_relative '../views/presentation/content'

# ---------
# GETs
# ---------

get '/' do
  session[:user_session_id] ||= next_session_id
  erb :slideshow_attendee  
end

get '/blackboard' do
  erb :slideshow_blackboard
end

get '/blackboard_hangout.xml' do
  content_type 'text/xml'
  erb :slideshow_blackboard_hangout
end

get '/teacher-x1973' do
  session[:user_session_id] = $teacher_session_id
  erb :slideshow_teacher
end

get '/admin/flip' do
  send_file "views/flip_page.html"
end

get '/teacher_current_slide' do
  response.headers['Access-Control-Allow-Origin'] = '*'  
  current_slide_id
end

get '/poll_response_*_rate_to_*' do
  PollQuestion.new(question_id).rate_for(answer).to_s
end

### POST and SAVE execution context
require 'json'

post '/code_save_execution_context/*' do
  json_string = request.env["rack.input"].read
  execution_context = JSON.parse(json_string)
  type = execution_context["type"]
  code = execution_context["code"]
  result = execution_context["code_output"]
  RunTimeEvent.new(user_session_id, type, slide_index, code, result).save
end

get '/code_last_execution/*' do
  last_execution = RunTimeEvent.find_last_user_execution_on_slide(session[:user_session_id], slide_index)
  return JSON.generate({}) if last_execution == nil
  JSON.generate({ :type => last_execution.type, :author => user_name_of(last_execution.user), :code => last_execution.code_input, :code_output => last_execution.code_output})   
end

###

get '/code_attendees_last_send/*' do
  response.headers['Access-Control-Allow-Origin'] = '*' 
  last_send = RunTimeEvent.find_attendees_last_send_on_slide(session[:user_session_id], slide_index)
  return  JSON.generate({}) if last_send == nil
  JSON.generate({ :type => last_send.type, :author => user_name_of(last_send.user), :code => last_send.code_input, :code_output => last_send.code_output})     
end

get '/code_get_last_send_to_blackboard/*' do
  response.headers['Access-Control-Allow-Origin'] = '*'    
  last_teacher_run = RunTimeEvent.find_last_send_to_blackboard(slide_index)
  return  JSON.generate({}) if last_teacher_run == nil
  JSON.generate({ :type => last_teacher_run.type, :author => user_name_of(last_teacher_run.user), :code => last_teacher_run.code_input, :code_output => last_teacher_run.code_output})       
end

get '/session_id' do
  response.headers['Access-Control-Allow-Origin'] = '*'  
  session[:user_session_id]
end

get '/session_id/user_name' do
  response.headers['Access-Control-Allow-Origin'] = '*'
  user_name_of(session[:user_session_id])
end

get '/admin/flip/*' do
  Flip.find(params[:splat][0]).value
end

# ---------
# POSTs
# ---------

post '/teacher_current_slide' do
  update_current_slide_id params[:index] + ';' + params[:ide_displayed] 
end

post '/poll_response_*_to_*' do
  PollQuestion.new(question_id).add_a_choice(user_session_id, answer)
end

post '/rating_input_*_to_*' do
  PollQuestion.new(question_id).add_a_choice(user_session_id, answer)
end

post '/select_input_*_to_*' do
  PollQuestion.new(question_id).add_a_choice(user_session_id, answer)
end

post '/code_run_result/*' do
  code = request.env["rack.input"].read
  run_ruby("run", code.force_encoding("UTF-8"), user_session_id, slide_index)
end

post '/code_run_result_blackboard/*' do
  response.headers['Access-Control-Allow-Origin'] = '*'    
  code = request.env["rack.input"].read
  run_ruby("run", code.force_encoding("UTF-8"), 'blackboard', slide_index)
end

post '/code_send_result/*' do
  code = request.env["rack.input"].read
  run_ruby("send", code.force_encoding("UTF-8"), user_session_id, slide_index)
end

post '/session_id/user_name' do
  session[:user_session_id] = session[:user_session_id].split('_')[0] + '_' + params[:user_name]
end

post '/admin/flip/*' do
  Flip.new(params[:splat][0], params[:value]).save
end