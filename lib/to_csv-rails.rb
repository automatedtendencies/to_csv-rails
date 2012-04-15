class Array
  
  def fix_stupid_quotes!(s) 
    return s if s.class != String
    s.gsub! "\u2019", "'"
    s.gsub! "\u2018", "'"
    s.gsub! "\u201C","\""
    s.gsub! "\u201D","\""
    return s
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
      data << columns.map{ |column| fix_stupid_quotes!(obj.send(column)) }.join(',')
    end
    data = data.join("\n")
  end

  def csv_export(options = {})
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
      data << columns.map{ |column| fix_stupid_quotes!(obj.send(column)) }.join(',')
    end
    data = data.join("\n")
  end
  
end
