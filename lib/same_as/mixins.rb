require 'same_as/methods'

class Object

  def same_as_part?(**fields)
    SameAs.compare_fields(self, fields)
  end

  def same_as?(other)
    0.0 if other.blank?
    SameAs.compare_object(self, other)
  end

end

class String

  def same_as?(other, case_sensitive=false)
    0.0 if other.blank?
    SameAs.compare_string(self, other, case_sensitive)
  end

end

class TrueClass
  def same_as?(other)
    0.0 if other.blank?
    SameAs.compare_boolean(self, other)
  end
end

class FalseClass
  def same_as?(other)
    0.0 if other.blank?
    SameAs.compare_boolean(self, other)
  end
end

class DateTime
  def same_as?(other, **args)
    0.0 if other.blank?
    SameAs.compare_time(self, other, args)
  end

  def same_as_day?(other, days=nil)
    0.0 if other.blank?
    SameAs.compare_date_day(self, other, days)
  end

  def same_as_month?(other, months=nil)
    0.0 if other.blank?
    SameAs.compare_date_month(self, other, months)
  end

  def same_as_year?(other, years=nil)
    0.0 if other.blank?
    SameAs.compare_date_year(self, other, years)
  end

  def same_as_hour?(other, hours=nil)
    0.0 if other.blank?
    SameAs.compare_time_hour(self, other, hours)
  end

  def same_as_min?(other, mins=nil)
    0.0 if other.blank?
    SameAs.compare_time_minute(self, other, mins)
  end

  def same_as_sec?(other, secs=nil)
    0.0 if other.blank?
    SameAs.compare_time_second(self, other, secs)
  end

  def same_as_utc?(other, offset=nil)
    0.0 if other.blank?
    SameAs.compare_time_utc(self, other, offset)
  end
end

class Date

  def same_as?(other, **args)
    0.0 if other.blank?
    SameAs.compare_date(self, other, args)
  end

  def same_as_day?(other, days=nil)
    0.0 if other.blank?
    SameAs.compare_date_day(self, other, days)
  end

  def same_as_month?(other, months=nil)
    0.0 if other.blank?
    SameAs.compare_date_month(self, other, months)
  end

  def same_as_year?(other, years=nil)
    0.0 if other.blank?
    SameAs.compare_date_year(self, other, years)
  end

end

class Time

  def same_as?(other, **args)
    0.0 if other.blank?
    SameAs.compare_date(self, other, args)
  end

  def same_as_day?(other, days=nil)
    0.0 if other.blank?
    SameAs.compare_date_day(self, other, days)
  end

  def same_as_month?(other, months=nil)
    0.0 if other.blank?
    SameAs.compare_date_month(self, other, months)
  end

  def same_as_year?(other, years=nil)
    0.0 if other.blank?
    SameAs.compare_date_year(self, other, years)
  end

  def same_as_hour?(other, hours=nil)
    0.0 if other.blank?
    SameAs.compare_time_hour(self, other, hours)
  end

  def same_as_min?(other, mins=nil)
    0.0 if other.blank?
    SameAs.compare_time_minute(self, other, mins)
  end

  def same_as_sec?(other, secs=nil)
    0.0 if other.blank?
    SameAs.compare_time_second(self, other, secs)
  end

  def same_as_utc?(other, offset=nil)
    0.0 if other.blank?
    SameAs.compare_time_utc(self, other, offset)
  end

end

class Numeric

  def same_as?(other, max=nil)
    0.0 if other.blank?
    SameAs.compare_numeric(self, other, max)
  end

end

# class Array
#
# end

# class Hash
#
# end
