#encoding: utf-8

require 'rspec'
require 'capybara/rspec'

require_relative '../../controllers/slideshow.rb'

Capybara.app = Sinatra::Application.new

teacher_coding_presentation = '/teacher-x1973'
attendee_IDE_with_NO_code_to_display = '/'

describe 'Teacher IDE', :type => :feature, :js => true do
	
  before(:each) do
    $db.execute_sql("delete from run_events") 
    $db.execute_sql("delete from teacher_current_slide")    
  end	
  
  it 'should show welcome message when IDE is shown' do

    visit teacher_coding_presentation
    
    expect(page).to have_no_field 'code_input', :with => "", :visible => true
    expect(page).to have_no_field 'code_output', :with => "", :visible => true
    
    find(:css, 'div.presentation').native.send_key(:arrow_down)

    expect(page.find('#code_input').text).to eq "1 puts \"CONNEXION REUSSIE, BIENVENUE\""
    expect(page).to have_field 'code_output', :with => "CONNEXION REUSSIE, BIENVENUE\n"
    
  end
  
  after(:each) do
    $db.execute_sql("delete from run_events") 
    $db.execute_sql("delete from teacher_current_slide")    
  end  

end

describe 'Attendee IDE', :type => :feature, :js => true do
	
  before(:each) do
    $db.execute_sql("delete from run_events") 
    $db.execute_sql("delete from teacher_current_slide")    
  end	
  
  it 'should show welcome message when initialized' do

    visit attendee_IDE_with_NO_code_to_display

    expect(page.find('#code_input').text).to eq "1 puts \"CONNEXION REUSSIE, BIENVENUE\""
    expect(page).to have_field 'code_output', :with => "CONNEXION REUSSIE, BIENVENUE\n"
    
  end
  
  after(:each) do
    $db.execute_sql("delete from run_events") 
    $db.execute_sql("delete from teacher_current_slide")    
  end  

end


