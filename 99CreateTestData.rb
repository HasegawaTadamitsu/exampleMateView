module Sql
  def to_insert_sql
   keys =   self.instance_variables.map do |k|
     if k =~ /^@col_(.*)/
       $1
     end
   end
   values = keys.map do | k |
     va = self.instance_variable_get( "@col_" + k )
     if va.instance_of? String
       va = "'%s'" % va
     end
     va
   end
   ret = "INSERT INTO %s " % self.class
   ret += "( %s ) " % keys.join(", ")
   ret += "values( %s );" % values .join(", ")
  end
end

class BigData1
  include Sql
  attr_accessor :col_id, :col_seq, :col_inx, :col_value
  def initialize id
   @col_id = id
  end
end

class Inx
  include Sql
  attr_accessor :col_inx, :col_liveFlg
  def initialize id
   @col_inx = id
  end
end

class Bigdata2
  include Sql
  attr_accessor :col_id, :col_delFlg, :col_value
  def initialize id
   @col_id = id
  end
end


#######################################3
class Main
  def random_str length=100
    ("A".."Z").to_a.sample(length).join
  end

  def create_bigdata2 key
    a = Bigdata2.new key
    a.col_delFlg = (rand(100)< 90)?'0':'1'
    a.col_value = random_str 100
    return a
  end

  def create_inx key
    inx = Inx.new key
    inx.col_liveFlg = (rand(100)< 50)?'0':'1'
    return inx
  end


  def initialize count,start_count
    @count  = count
    @start_count = start_count
  end

  def main 

    seq_inx = @start_count
    @count.times do | id |
      id = id + @start_count
      main = BigData1.new id
      main.col_inx = 0
      main.col_seq = 0
      main.col_value = random_str 100
      puts main.to_insert_sql

      if  rand(100)  < 20
        seq_inx += 1
        main.col_seq = 1
        main.col_inx = seq_inx
        main.col_value = random_str 100
        puts main.to_insert_sql

        inx = create_inx seq_inx
        puts inx.to_insert_sql
      end
      if rand(100)  < 90
        d = create_bigdata2 id
        puts d.to_insert_sql
      end
      if id % (@count / 10) == 0
        puts "commit;\n"
      end
   end
   puts "commit;\n"
  end
end

srand 100 # <= fix this!

co = ARGV[0]
co = 1000 if co.nil?
st_co =ARGV[1]
st_co = 0 if st_co.nil?
co=co.to_i
st_co=st_co.to_i

a=Main.new co, st_co
a.main


