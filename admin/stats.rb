require "../db/Accesseur"

db = Accesseur.new
#~ db.execute_sql("select * from run_events order by timestamp").each do |tuple|
  #~ p Time.at(tuple['timestamp'].to_i).to_s + ' ; ' +  tuple["user_id"] + ' ; ' +  tuple["type"] + ' ; ' +  tuple["code_input"] if tuple["user_id"] =~ /71.*/
#~ end

db.execute_sql("update run_events set user_id = '72_Maxime' where timestamp <= '1400679609.267595' and user_id = ''")

s = db.execute_sql("select * from run_events order by timestamp").select do |tuple|
  tuple["user_id"] =~ /^$/ && tuple["type"] =~ /.*/   &&  tuple["code_output"] =~ /ruby_file_to_run.*/
end

p s.size

s.each do |tuple|
  p Time.at(tuple['timestamp'].to_i).to_s + ' ; ' +  tuple["user_id"] + ' ; ' +  tuple["type"] + ' ; ' +  tuple["code_input"]
end


