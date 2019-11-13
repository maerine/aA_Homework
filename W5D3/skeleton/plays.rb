require 'sqlite3'
require 'singleton'

class PlayDBConnection < SQLite3::Database
  include Singleton

  def initialize
    super('plays.db')
    self.type_translation = true
    self.results_as_hash = true
  end
end

class Play
  attr_accessor :id, :title, :year, :playwright_id

  def self.all
    data = PlayDBConnection.instance.execute("SELECT * FROM plays")
    data.map { |datum| Play.new(datum) }
  end

  def self.find_by_title(title)

  end

  # def self.find_by_playwright(name)
  #   raise "Not in database" if self.id == nil
  #   PlayDBConnection.instance.execute(<<-SQL, self.title, self.year, self.playwright_id)
  #     SELECT *
  #     FROM plays
  #     LEFT JOIN playwrights
  #       on plays.playwright_id = playwrights.id
  #     WHERE 
  #       plays (title, year, playwright_id)
  #   SQL
  #   self.id = PlayDBConnection.instance.last_insert_row_id
  # end

  def initialize(options)
    @id = options['id']
    @title = options['title']
    @year = options['year']
    @playwright_id = options['playwright_id']
  end

  def create
    raise "#{self} already in database" if self.id
    PlayDBConnection.instance.execute(<<-SQL, self.title, self.year, self.playwright_id)
      INSERT INTO
        plays (title, year, playwright_id)
      VALUES
        (?, ?, ?)
    SQL
    self.id = PlayDBConnection.instance.last_insert_row_id
  end

  def update
    raise "#{self} not in database" unless self.id
    PlayDBConnection.instance.execute(<<-SQL, self.title, self.year, self.playwright_id, self.id)
      UPDATE
        plays
      SET
        title = ?, year = ?, playwright_id = ?
      WHERE
        id = ?
    SQL
  end
end

class Playwright
  attr_accessor :id, :name, :birth_year
  def self.all
    data = PlayDBConnection.instance.execute("SELECT * FROM playwrights")
    data.map { |datum| Playwright.new(datum) }
  end

  def self.find_by_name(name)
    raise "#{self} not in database" unless self.id
    PlayDBConnection.instance.execute(<<-SQL, self.name, self.birth_year)
      SELECT name, birth_year
      FROM playwrights
      WHERE name = ?
    SQL
  end

  def initialize(options)
    @id = options['id']
    @title = options['name']
    @year = options['birth_year']
  end

  def create
    raise "#{self} already in database" if self.id
    PlayDBConnection.instance.execute(<<-SQL, self.name, self.birth_year)
      INSERT INTO
        playwrights (name, birth_year)
      VALUES
        (?, ?, ?)
    SQL
    self.id = PlayDBConnection.instance.last_insert_row_id
  end

  def update
    raise "#{self} not in database" unless self.id
    PlayDBConnection.instance.execute(<<-SQL, self.name, self.birth_year, self.id)
      UPDATE
        playwrights
      SET
        name = ?, birth_year = ?
      WHERE
        id = ?
    SQL
  end

  def get_plays

  end

end