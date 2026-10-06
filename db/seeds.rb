# Очищаем старые данные
Company.delete_all
Job.delete_all
Geek.delete_all
Apply.delete_all

# Сбрасываем счётчики ID (для PostgreSQL)
ActiveRecord::Base.connection.reset_pk_sequence!('companies')
ActiveRecord::Base.connection.reset_pk_sequence!('jobs')
ActiveRecord::Base.connection.reset_pk_sequence!('geeks')
ActiveRecord::Base.connection.reset_pk_sequence!('applies')

# Компании
Company.create([
  { name: 'MoGo', location: 'New York' },
  { name: 'Wirkkle', location: 'London' },
  { name: 'Artesis', location: 'Saint-Petersburg' },
  { name: 'BuildEmpire', location: 'London' }
])

# Вакансии
Job.create([
  { name: 'Sinatra React', place: 'Remote', company_id: 1 },
  { name: 'Ruby React', place: 'Contract', company_id: 2 },
  { name: 'React', place: 'Remote', company_id: 3 },
  { name: 'Node React', place: 'Permanent', company_id: 1 },
  { name: 'Ruby on Rails', place: 'Remote', company_id: 4 },
  { name: 'Node', place: 'Permanent', company_id: 4 },
  { name: 'Javascript CSS HTML', place: 'Permanent', company_id: 4 }
])

# Соискатели
Geek.create([
  { name: 'Mike', stack: 'Sinatra React', resume: 'Опыт 3 года' },
  { name: 'Alex', stack: 'Ruby React', resume: 'Опыт 5 лет' },
  { name: 'Martha', stack: 'Rails', resume: 'Опыт 2 года' },
  { name: 'Juri', stack: 'Java', resume: 'Опыт 7 лет' },
  { name: 'Andrew', stack: 'PHP', resume: 'Опыт 4 года' },
  { name: 'Nina', stack: 'Node', resume: 'Опыт 3 года' },
  { name: 'Bob', stack: 'Front end', resume: 'Опыт 1 год' },
  { name: 'Kate', stack: 'PHP', resume: 'Опыт 6 лет' },
  { name: 'Boris', stack: 'Full stack', resume: 'Опыт 8 лет' }
])

# Заявления
Apply.create([
  { job_id: 1, geek_id: 1, read: true, invited: true },
  { job_id: 1, geek_id: 2, read: false, invited: false },
  { job_id: 5, geek_id: 5, read: true, invited: false },
  { job_id: 6, geek_id: 8, read: false, invited: false }
])

puts "Создано: #{Company.count} компаний, #{Job.count} вакансий, #{Geek.count} соискателей, #{Apply.count} заявлений"