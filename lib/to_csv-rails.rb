class Array
  
  def fix_stupid_quotes!(s) 
    s.gsub!(/\x82/,',') 
    s.gsub!(/\x84/,',,') 
    s.gsub!(/\x85/,'...') 
    s.gsub!(/\x88/,'^') 
    s.gsub!(/\x89/,'o/oo') 
    s.gsub!(/\x8b/,'<') 
    s.gsub!(/\x8c/,'OE') 
    s.gsub!(/\x91|\x92/,"'") 
    s.gsub!(/\x93|\x94/,'"') 
    s.gsub! "\342\200\230", "'"
    s.gsub! "\342\200\231", "'"
    s.gsub! "\342\200\234", '"'
    s.gsub! "\342\200\235", '"'
    s.gsub!(/\x95/,'*') 
    s.gsub!(/\x96/,'-') 
    s.gsub!(/\x97/,'--') 
    s.gsub!(/\x98/,'~') 
    s.gsub!(/\x99/,'TM') 
    s.gsub!(/\x9b/,'>') 
    s.gsub!(/\x9c/,'oe') 
  end

  def to_csv(options = {})
    return '' if self.empty?

    options.reverse_merge!(:header => true)

    #columns = self.first.class.content_columns # not include the ID column
    if options[:only]
      columns = Array(options[:only]).map(&:to_sym)
    else
      columns = self.first.class.column_names.map(&:to_sym) - Array(options[:except]).map(&:to_sym)
    end
    
    return '' if columns.empty?
    
    data = []
    # header
    data << columns.map(&:to_s).map(&:humanize).join(',') if options[:header]

    self.each do |obj|
      data << columns.map{ |column| obj.send(fix_stupid_quotes!(column)) }.join(',')
    end
    data.join("\n")
  end
  
end
