# Wraps +text+ to +wrap+ characters and optionally indents by +indent+ characters
class TextFormatter
  def self.format_ruby_text(text,wrap=50)
    output = []
    new_text = text
    while new_text.length > wrap
      wrapped_text = new_text[0..wrap]
      if wrapped_text.include?("\n")
        scrapped = fetch_original_text(wrapped_text.split("\n"),"\n")
      elsif wrapped_text[-1] != " "
        scrapped = fetch_original_text(wrapped_text.split()," ")
      else
        scrapped = wrapped_text
      end
      output << scrapped.strip
      new_text.slice!(0,scrapped.length)
      new_text.strip!
    end
    output << new_text unless new_text.length.zero?
    return output.map{ |line| arrange_line(line,50)}.join("\n")
  end

  def self.fetch_original_text(text,limiter)
    return text[0...-1].join(limiter)
  end

  def self.arrange_line(line,max_length)
    line_length = line.length
    remaining_length = max_length-line_length
    if remaining_length > 0
      count = 0
      while true
        break if line.length >= 50
        line.insert(compute_index(line)[count],' ')
        count = count == 2 ? 0 : count+= 1
      end
    end
    return line
  end

  def self.compute_index(line)
    indexes = line.enum_for(:scan,/ /).map { Regexp.last_match.begin(0) }
    new_indexes = []
    while !indexes.empty?
      new_indexes << indexes.delete(indexes[0])
      new_indexes << indexes.delete(indexes[-1])
      new_indexes << indexes.delete(indexes[indexes.length/2])
    end
    return new_indexes
  end
end


# def self.format_text(text, wrap=50, indent=2)
#   result = []
#   work = text.dup
#   while work.length > wrap do
#     # binding.pry
#     if work =~ %r(^(.{0,#{wrap}})[ \n]) then
#       result << $1.rstrip
#       work.slice!(0, $&.length)
#     else
#       result << work.slice!(0, wrap)
#     end
#   end
#   result << work if work.length.nonzero?
#   puts result.join("\n").gsub(/^/, " " * indent)
#   result.join("\n").gsub(/^/, " " * indent)
# end
