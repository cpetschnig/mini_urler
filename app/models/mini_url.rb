class MiniUrl

  include ActiveModel::Validations

  attr_accessor :url
  attr_reader :key

  validates_format_of :url, :with => /^https?:\/\/.*/
  validates_presence_of :key

  def initialize(params = {})
    @key = params[:key]
    @url = params[:url]
    #  if only the key is given, fetch the value from the database
    @url = RedisMod.conn[@key] if @url.nil? && @key
  end

  def self.all(*args)
    #  get an array of all keys
    RedisMod.conn.lrange('USER00', 0, -1).collect do |key|
      #  construct object by only passing the key
      MiniUrl.new(:key => key)
    end
  end

  def self.find(id)
    url = RedisMod.conn[id]
    raise "Couldn't find record with key=#{id}" unless url
    MiniUrl.new(:key => id, :url => url)
  end

  # Returns this record's primary key value wrapped in an Array
  # or nil if the record is a new_record?
  def to_key
    nil
  end

  #  Rails needs the method to determine between an update and create,
  #  i.e. in < %= f.submit %>. For now, we answer with "No, this object is
  #  not yet stored in the database"
  def persisted?
    !@key.nil?
  end

  def save
    generate_key unless @key      # using ActiveModel::Callbacks in this case is way too complicated
    #  leave if validation fails
    return false unless valid?
    #  store the key/value pair
    RedisMod.conn[@key] = @url
    # also store key to a list that we will retrieve on MiniUrl.all
    RedisMod.conn.lpush('USER00', @key)
    true
  end

  def update_attributes(attributes)
    @url = attributes.delete(:url)
    #  leave if validation fails
    return false unless valid?
    #  update the key/value pair
    RedisMod.conn[@key] = @url
    true
  end

  def destroy
    #  delete db entry
    RedisMod.conn.del(@key)
    #  delete from list
    RedisMod.conn.lrem('USER00', 1, @key)
  end

  # this is needed by f.error_messages to get the name of the class variable
  def to_s
    self.class.to_s.underscore
  end

  # let's us create the the edit_path
  def to_param
    @key
  end

  #  auto-generate a key
  def generate_key
    while true
      @key = rand_char.chr + rand_char.chr + rand_char.chr + rand_char.chr
      break unless RedisMod.conn[@key]
    end
  end

  #  get a random alphanumeric character
  def rand_char
    # 48..57 65..90 97..122
    # 0..9 17..42 49..74
    i = rand(62)
    i += 7 if i > 9     # skip first gap
    i += 6 if i > 42    # skip second gap
    i + 48
  end

end
