#joinig string with seperator
colors = ';'.join(['abc', 'fijf', 'fff'])
print(colors)

#split string into three parts: before the argument, argument, and after argument
part = "unforgetable".partition('forget')
print(part)

#detuppling
departrue, seperator, arrival = "London:Edinburgh".partition(':')
print('Departure:', departrue)
print('Arrival:', arrival)

# _ means dummy variable; it's just a convention
origin, _, destination = "Seattle-Boston".partition('-')

#Like -f in Powershell
X = "The age of {0} is {1}".format('Jim', 32)
print(X)

#string literals
value = 4 * 20
f'The value is {value}'

import datetime
f'The current time is {datetime.datetime.now().isoformat()}'

import math
f'Math constants: pi={math.pi}, e={math.e}'