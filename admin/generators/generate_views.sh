echo "ruby generate_teacher_presentation.rb > ../../views/slideshow-teacher.1973x.html"
ruby generate_teacher_presentation.rb > ../../views/slideshow-teacher.1973x.html 
echo "ruby generate_attendee_presentation.rb > ../../views/slideshow-attendee.html"
ruby generate_attendee_presentation.rb > ../../views/slideshow-attendee.html

echo "ruby generate_blackboard.rb > ../../views/blackboard.html"
ruby generate_blackboard.rb > ../../views/blackboard.html

echo "ruby generate_blackboard_hangout.rb > ../../views/blackboard_hangout.xml"
ruby generate_blackboard_hangout.rb > ../../views/blackboard_hangout.xml
