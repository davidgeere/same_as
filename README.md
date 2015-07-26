# SameAs

##API

####Object

```ruby
same_as_part?(**fields)
same_as?(other)
```

#####same_as
**Example 1:**
```ruby
@christopher = Person.new(name: "Chris", gender: "Male")
@christina = Person.new(name: "Chris", gender: "Female")

@chirstopher.same_as? @christina # 83.33% because we comparing the gender words
```

**Example 2:**
```ruby
@christopher = Person.new(name: "Chris", is_female: false)
@christina = Person.new(name: "Chris", is_female: true)

@chirstopher.same_as? @christina # 50% because we comparing booleans for gender
```

**Example 3:**
```ruby
@christopher = Person.new(name: "Chris", gender: 0)
@christina = Person.new(name: "Chris", gender: 1)

@chirstopher.same_as? @christina # 50% because we comparing between two options
```
#####same_as_part
This method is actually the reason why this gem was created. We wanted to be able to compare parts of things. Example #1 is the simplest we are just seeing if this person is a "Chris" and ignoring their last name.
**Example 1:**
```ruby
@christopher = Person.new(fname: "Chris", lname: "Smith")
@christina = Person.new(fname: "Chris", lname: "Richards")

@chirstopher.same_as_part? fname: "Chris" # 100% because we comparing only variables name fname on @christopher
```
However in example #2 we know a persons possible names and definite last name but we aren't sure which of them is the first name, so we try them all and the closest match wins.
**Example 2:**
```ruby
@person = Person.new("William", "Henry", "Bill", "Gates")
@person.same_as_part? fname: ["Will", "Bill", "William", "Henry"], lname: "Gates"
# 100% because inside of the fname options we found a 100% match to it and also a 100% match to the last name.
```
**Example 2.1:**
```ruby
@person.same_as_part? fname: ["Will", "Bill", "Henry"], lname: "Gates"
# 78.5% because the closest we got was Will (57%) and the last name is a full match
```
There comes a time when you want to compare the same value to multiple fields in this case we have a name but we aren't sure what kind of name it is. Is it the first, middle or nickname? So we created an "Or" grouping you can use.
**Example 3:**
```ruby
@person.same_as_part? or: {fname: "Bill", mname: "Bill", nname: "Bill"}, lname: "Gates"
# 100% match because Bill is 100% a nickname of this person and with the last name matching too we get a perfect score.
```

**Example 3.1:**
```ruby
@person.same_as_part? or: {fname: "Will", mname: "Will", nname: "Will"}, lname: "Gates"
# 87.5% match because Will is a 75% match with the nickname of this person and with the last name matching too we get a perfect score.
```

We created an "And" grouping for aesthetic reasons but it is no different to just listing them all out.
**Example 4:**
```ruby
@person.same_as_part? and: {fname: "William", mname: "Henry", nname: "Bill"}, lname: "Gates"
# 100% match because everything matches
```

####String

```ruby
same_as?(other, case_sensitive=false)
```

**Example:**
```ruby
"Aluminium".same_as? "Aluminum" #88.88%
```

####Numeric (Float, Interger)

```ruby
same_as?(other, max=nil)
```

**Example 1:**
```ruby
1.same_as? 100 #1%
```

**Example 2:**
```ruby
1965.same_as? 1985 #98.99%
```

**Example 3:**
```ruby
2015.same_as? 2010, 10 #50%
```
* What example #3 is doing is it is limiting the range of the dates. So instead of comparing since the year 0 we are comparing within the last 10 years.

####Boolean

```ruby
same_as?(other)
```
* Technically this is on TrueClass and FalseClass

**Example:**
```ruby
true.same_as? false #0%
```

####DateTime

```ruby
same_as?(other, **args)
same_as_day?(other, days=nil)
same_as_month?(other, months=nil)
same_as_year?(other, years=nil)
same_as_hour?(other, hours=nil)
same_as_min?(other, mins=nil)
same_as_sec?(other, secs=nil)
same_as_utc?(other, offset=nil)
```

####Date

```ruby
same_as?(other, **args)
same_as_day?(other, days=nil)
same_as_month?(other, months=nil)
```

####Time

```ruby
same_as?(other, **args)
same_as_day?(other, days=nil)
same_as_month?(other, months=nil)
same_as_year?(other, years=nil)
same_as_hour?(other, hours=nil)
same_as_min?(other, mins=nil)
same_as_sec?(other, secs=nil)
same_as_utc?(other, offset=nil)
```

####Array

Not implemented yet

####Hash

Not implemented yet
