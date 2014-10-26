json.array!(@schools) do |school|
  json.extract! school, :name
  json.teachers school.users.where(user_type: ['teacher', 'Teacher']), :lastname, :firstname
  json.students school.users.where(user_type: ['student', 'Student']), :lastname, :firstname
end