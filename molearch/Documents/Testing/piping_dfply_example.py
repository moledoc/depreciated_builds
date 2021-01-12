from dfply import *
from pipeop import pipes 
from self_funs import *


# dfply example
diamonds >>= head(3)
print(diamonds),pause()

# pipeop examples
## Example 1
def add(a, b):
    return a + b

def times(a, b):
    return a * b

@pipes
def calc():
    print (1 >> add(2) >> times(3)),pause()  # prints 9
calc()

## Example 2
@pipes
def pretty_pipe():
  print (
      range(-5, 0)
      << map(lambda x: x + 1)
      << map(abs)
      << map(str)
      >> tuple
  ),pause()  # prints ('4', '3', '2', '1', '0')
pretty_pipe()

## Example 3 
@pipes
def tst():
    return [1,2,3] >> sum 
print(tst()),pause()
