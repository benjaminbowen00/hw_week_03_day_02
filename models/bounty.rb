require('pg')

class Bounty
attr_accessor :name, :species, :value, :location
attr_reader :id

  def initialize(bounty_options)
    @id = bounty_options['id'].to_i if bounty_options['id']
    @name = bounty_options['name']
    @species = bounty_options['species']
    @value = bounty_options['value']
    @location = bounty_options['location']
  end

  def self.create(name, species, value, location)
    db = PG.connect( { dbname: 'bounties', host: 'localhost'})
    sql = 'INSERT INTO bounties (name, species, value, location) VALUES ($1, $2, $3, $4) Returning *'
    values = [name, species, value, location]
    db.prepare("create", sql)
    @id = db.exec_prepared("create", values)[0]['id'].to_i
    db.close
  end

  def save
    db = PG.connect( { dbname: 'bounties', host: 'localhost'})
    sql = 'INSERT INTO bounties
    (name,
      species,
      value,
      location)
      VALUES (
        $1, $2, $3, $4)
        Returning *'
    values = [@name, @species, @value, @location]
    db.prepare("save", sql)
    @id = db.exec_prepared("save", values)[0]["id"].to_i

    db.close
  end



  def delete
    db = PG.connect ( {dbname: 'bounties', host: 'localhost'})
    sql = 'DELETE FROM bounties WHERE id = $1'
    values = [@id]
    db.prepare('delete_bounty', sql)
    db.exec_prepared('delete_bounty', values)
    db.close
  end

  def update
    db = PG.connect ({dbname: 'bounties', host: 'localhost'})
    sql = "UPDATE bounties SET
    (name, species, value, location)
    = ($1, $2, $3, $4)
    WHERE id = $5"
    values = [@name, @species, @value, @location, @id]
    db.prepare("my_update", sql)
    db.exec_prepared("my_update", values)
    db.close
  end

  def self.return_by_id(id)
    db = PG.connect({dbname: 'bounties', host: 'localhost'} )
    sql = "SELECT * FROM bounties WHERE id = $1"
    values = [id]
    db.prepare("chosen", sql)
    chosen_bounty = db.exec_prepared("chosen", values)
    db.close
    # return chosen_bounty[0]["name"]
    return chosen_bounty[0]
    # The db returns an array where each object is a hash of a row from the table!!!
    result = chosen_bounty.map {|bounty| Bounty.new(bounty)}
    #This is creating an array of 1 bounty objects !!!
    #so now we can call the class methods on it
    return result[0].name

  end

  def self.return_by_location(place)
    db = PG.connect({dbname: 'bounties', host: 'localhost'} )
    sql = "SELECT * FROM bounties WHERE location = $1"
    values = [place]
    db.prepare("chosen", sql)
    chosen_bounty = db.exec_prepared("chosen", values)
    db.close
    return chosen_bounty.map {|bounty| Bounty.new(bounty)}
    # return chosen_bounty[0][@name]

  end

  def self.update_location_by_id(id, location)
    db = PG.connect({dbname: 'bounties', host: 'localhost'} )
    sql = "UPDATE bounties SET location = $2 WHERE id = $1"
    values = [id, location]
    db.prepare('update', sql)
    db.exec_prepared('update', values)
    db.close
  end

#Couldn't get this to work
  # def self.update_anything_by_id(id, attribute, value)
  #   db = PG.connect({dbname: 'bounties', host: 'localhost'} )
  #   sql = "UPDATE bounties SET $2 = $3 WHERE id = $1"
  #   values = [id, attribute, value]
  #   db.prepare('update', sql)
  #   db.exec_prepared('update', values)
  #   db.close
  # end


end
