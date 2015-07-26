module SameAs
  extend self

  def compare(target, compared, &block)

    return 100.0 if (target.blank? and compared.blank?)

    return 100.0 if (target == compared)

    return block.call unless block.blank?

    return 0.0

  end

  def compare_fields(target, **fields)

    percentages = []

    puts target

    fields.each do |key, value|

      current = target.send("#{key}")
      percentages << compare_object(current, value)

    end

    percentages.inject(0, :+) / percentages.length

  end

  def compare_object(target, compared, **args)

    return compare(target, compared) do

      if target.is_a? String
        case_sensitive = args[:case_sensitive] if !args.blank? and args.has_key? :case_sensitive
        return compare_string(target, compared, case_sensitive)
      elsif target.is_a? Numeric
        max = args[:max] if !args.blank? and args.has_key? :max
        return compare_numeric(target, compared, max)
      elsif target.is_a? Date
        return compare_date(target, compared, args)
      elsif target.is_a? Time
        return compare_time(target, compared, args)
      elsif target.is_a? TrueClass or target.is_a? FalseClass
        return compare_boolean(target, compared)
      else
        target_fields = target.instance_values.symbolize_keys
        compared_fields = compared.instance_values.symbolize_keys

        matches = {}

        target_fields.each do |tk,tv|

          matches[tk] = 0.0 if matches[tk].blank?

          compared_fields.each do |ck,cv|

            matches[ck] = 0.0 if matches[ck].blank?

            next unless tk == ck

            matches[ck] = self.compare_object(tv, cv, args)

          end

        end

        if matches.values.length <= 0
          compare_string(target, compared, case_sensitive)
        else
          matches.values.length == 0 ? 0.0 : matches.values.inject(0, :+) / matches.values.length
        end

      end

    end

  end

  def compare_date(target, compared, **max)

    return compare(target, compared) do

      day = compare_date_day(target, compared, max[:days])
      month = compare_date_month(target, compared, max[:months])
      year = compare_date_year(target, compared, max[:years])

      (day+month+year) / 3

    end

  end

  def compare_time(target, compared, **args)

    return compare(target, compared) do

      day = compare_date_day(target, compared, args[:days])
      month = compare_date_month(target, compared, args[:months])
      year = compare_date_year(target, compared, args[:years])
      hour = compare_time_hour(target, compared, args[:hours])
      minute = compare_time_minute(target, compared, args[:minutes])
      second = compare_time_second(target, compared, args[:seconds])
      utc = compare_time_utc(target, compared, args[:offset])

      (day+month+year+hour+minute+second+utc) / 7

    end

  end

  def compare_time_hour(target, compared, hours)

    return compare(target, compared) do
      compare_numeric(target.hour, compared.hour, hours || 24)
    end

  end

  def compare_time_minute(target, compared, minutes)

    return compare(target, compared) do
      compare_numeric(target.min, compared.min, minutes || 60)
    end

  end

  def compare_time_second(target, compared, seconds)

    return compare(target, compared) do
      compare_numeric(target.sec, compared.sec, seconds || 60)
    end

  end

  def compare_time_utc(target, compared, offset)

    return compare(target, compared) do
      compare_numeric(target.utc_offset, compared.utc_offset, offset)
    end

  end

  def compare_date_day(target, compared, days)

    return compare(target, compared) do
      compare_numeric(target.day, compared.day, days || target.end_of_month.day)
    end

  end

  def compare_date_month(target, compared, months)

    return compare(target, compared) do
      compare_numeric(target.month, compared.month, months || 12)
    end

  end

  def compare_date_year(target, compared, years)

    return compare(target, compared) do
      compare_numeric(target.year, compared.year, years || 100)
    end

  end

  def compare_string(target, compared, case_sensitive=false)

    return compare(target, compared) do

      unless case_sensitive
        target = target.to_s.downcase
        compared = compared.to_s.downcase
      end

      distance = levenshtein_distance(target,compared)

      max = [target.length, compared.length].max

      percentage(distance, max)

    end

  end

  def compare_numeric(target, compared, max=nil)

    return compare(target, compared) do

      distance = ([target, compared].max.to_f - [target, compared].min.to_f)

      max = [target, compared].max.to_f if max.blank?

      percentage(distance, max)

    end

  end

  def compare_boolean(target, compared)

    return compare(target, compared) do

      (target == compared) ? 100.0 : 0.0

    end

  end

  private

  def clean_percentage(value)

    value = (value * 100.0)

    if value < 0.0
      0.0
    elsif value > 100.0
      100.0
    else
      value
    end

  end

  def percentage(distance, maximum)
    clean_percentage(((maximum.to_f - distance.to_f) / maximum.to_f))
  end

  def levenshtein_distance(target, compared)

    m = target.length
    n = compared.length

    return m if n == 0
    return n if m == 0

    d = Array.new(m+1) {Array.new(n+1)}

    (0..m).each {|i| d[i][0] = i}
    (0..n).each {|j| d[0][j] = j}
    (1..n).each do |j|
      (1..m).each do |i|
        d[i][j] = if target[i-1] == compared[j-1]  # adjust index into string
                    d[i-1][j-1]       # no operation required
                  else
                    [ d[i-1][j]+1,    # deletion
                      d[i][j-1]+1,    # insertion
                      d[i-1][j-1]+1,  # substitution
                    ].min
                  end
      end
    end

    d[m][n]

  end
end
