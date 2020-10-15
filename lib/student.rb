class Student
  def self.create_table
    sql = <<-SQL
      CREATE TABLE students (
        id INTEGER PRIMARY KEY,
        name TEXT,
        grade TEXT
    )
    SQL
    DB[:conn].execute(sql)
  end

  def self.drop_table
    sql = <<-SQL
      DROP TABLE students
    SQL
    DB[:conn].execute(sql)
  end

  def self.create(name:, grade:)
    student = Student.new(name, grade)
    student.save
    student
  end

  attr_accessor :name, :grade
  attr_reader :id

  def initialize(name, grade, id = nil)
    @name, @grade, @id = name, grade, id
  end

  def save
    #binding.pry
    sql = <<-SQL
      INSERT INTO students (name, grade) VALUES ('#{@name}', '#{@grade}')
      SQL
    DB[:conn].execute(sql)
    #binding.pry
    id = DB[:conn].execute("SELECT id FROM students WHERE name = '#{@name}' AND grade = '#{@grade}'")
    @id = id.flatten.shift
  end
end

#"SELECT MAX(id) FROM students"
#"SELECT id FROM students WHERE name = '#{@name}' AND grade = '#{@grade}'"
