# SameAs

##API

####Object

```
same_as_part?(**fields)
same_as?(other)
```

*Example 1:*
```
@christopher = Person.new(name: "Chris", gender: "Male")
@christina = Person.new(name: "Chris", gender: "Female")

@chirstopher.same_as? @christina # 83.33% because we comparing the gender words
```

*Example 2:*
```
@christopher = Person.new(name: "Chris", is_female: false)
@christina = Person.new(name: "Chris", is_female: true)

@chirstopher.same_as? @christina # 50% because we comparing booleans for gender
```

*Example 3:*
```
@christopher = Person.new(name: "Chris", gender: 0)
@christina = Person.new(name: "Chris", gender: 1)

@chirstopher.same_as? @christina # 50% because we comparing between two options
```

####String

```
same_as?(other, case_sensitive=false)
```

####Numeric (Float, Interger)

```
same_as?(other, max=nil)
```

####Boolean

```
same_as?(other)
```
* Technically this is on TrueClass and FalseClass

####DateTime

```
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

```
same_as?(other, **args)
same_as_day?(other, days=nil)
same_as_month?(other, months=nil)
```

####Time

```
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
