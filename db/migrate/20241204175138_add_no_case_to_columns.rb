class AddNoCaseToColumns < ActiveRecord::Migration[6.1]
  def up
    # Change the 'name' column to use NOCASE collation
    execute <<-SQL
      CREATE TABLE ai_tools_temp AS SELECT * FROM ai_tools;
      DROP TABLE ai_tools;
      CREATE TABLE ai_tools (
        id INTEGER PRIMARY KEY,
        name TEXT COLLATE NOCASE,
        features TEXT COLLATE NOCASE,
        description TEXT,
        created_at DATETIME NOT NULL,
        updated_at DATETIME NOT NULL
      );
      INSERT INTO ai_tools SELECT * FROM ai_tools_temp;
      DROP TABLE ai_tools_temp;
    SQL
  end

  def down
    # Revert the change (case sensitivity restored)
    execute <<-SQL
      CREATE TABLE ai_tools_temp AS SELECT * FROM ai_tools;
      DROP TABLE ai_tools;
      CREATE TABLE ai_tools (
        id INTEGER PRIMARY KEY,
        name TEXT,
        features TEXT,
        description TEXT,
        created_at DATETIME NOT NULL,
        updated_at DATETIME NOT NULL
      );
      INSERT INTO ai_tools SELECT * FROM ai_tools_temp;
      DROP TABLE ai_tools_temp;
    SQL
  end
end
