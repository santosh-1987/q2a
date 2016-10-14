# Wraps +text+ to +wrap+ characters and optionally indents by +indent+ characters
class TextFormatter
  def self.format_text(text, wrap=50, indent=2)
    result = []
    work = text.dup
    while work.length > wrap do
      # binding.pry
      if work =~ %r(^(.{0,#{wrap}})[ \n]) then
        result << $1.rstrip
        work.slice!(0, $&.length)
      else
        result << work.slice!(0, wrap)
      end
    end
    result << work if work.length.nonzero?
    puts result.join("\n").gsub(/^/, " " * indent)
    result.join("\n").gsub(/^/, " " * indent)
  end

  def self.format_ruby_text(text,wrap=50)
    output = []
    new_text = text
    while new_text.length > wrap
      wrapped_text = new_text[0..wrap]
      binding.pry
      if wrapped_text.include?("\n")
        scrapped = fetch_original_text(wrapped_text.split("\n"),"\n")
        output << scrapped.strip
        new_text.slice!(0,scrapped.length)
        new_text.strip!
      elsif wrapped_text[-1] != " "
        scrapped = fetch_original_text(wrapped_text.split()," ")
        output << scrapped.strip
        new_text.slice!(0,scrapped.length)
        new_text.strip!
      elsif wrapped_text[-1] == " "
        scrapped =  wrapped_text
        output << scrapped.strip
        new_text.slice!(0,scrapped.length)
        new_text.strip!
      else
        output << output
      end
    end
    output << new_text unless new_text.length.zero?
    return output.join("\n")
  end

  def self.fetch_original_text(text,limiter)
    return text[0...-1].join(limiter)
  end
end

