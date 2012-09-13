class CreateMessages < ActiveRecord::Migration
  def up
    conn = MassiveRecord::Wrapper::Base.connection
    table = MassiveRecord::Wrapper::Table.new(conn, :users)
    column = MassiveRecord::Wrapper::ColumnFamily.new(:row)
    table.column_families.push(column)
    table.save
    
    table = MassiveRecord::Wrapper::Table.new(conn, :messages)
    column = MassiveRecord::Wrapper::ColumnFamily.new(:row)
    table.column_families.push(column)
    table.save
    
  end

  def down
  end
end
