# atdict: Active Tcl Dictionaries

Atdict is an experiment to create Tcl dictionaries that behave somewhat
similarly to Javascript objects: keys can be accessed using "." notation
and methods are assigned to keys.

## Syntax examples

Create a dictionary:

`set myobj [@]`

Assign a value to a key:

`@ myobj.name = "Fred"`

Assign the value of an expression to a key:

`@ myobj.name := {$x + $y}`

Retrieving the value of a key:

`puts [@ myobj.name]`

Define a method on the object:

`@ myobj.greeting -> {who} { puts "Hello, $who!" }`

Calling a method:

`@ myobj.greeting: "World"`

Methods have access to the dictionary via the "this" variable:

```
@ myobj.double -> {key} {
    @ this.$key := {2*[@ this.$key]}  
}
```

## Method Implementation

Methods are implemented as lambda expressions and executed using
`apply`.

## Possible Enhancements

At present, atdict doesn't handle nested dictionaries, though it easily
could:

`@ myobj.record.first = "Joe"`

And of course it could all be faster, and error handling could be better.

## New Tcl syntax?

It would of course be much faster if it were implemented in C; and it
could be even better if it were a new Tcl syntax:

`@myobj.greeting: "World"`
