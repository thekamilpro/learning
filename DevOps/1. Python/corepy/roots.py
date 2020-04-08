import sys

def sqrt(x):
    if x < 0:
        raise ValueError(f"Cannot computer square root of negative number {x}")

    guess = x
    i = 0
    while guess * guess != x and i < 20:
        guess = (guess + x / guess) / 2.0
        i += 1
    return guess

def main():
    try:
        print(sqrt(9))
        print(sqrt(2))
        print(sqrt(-1)) #this will cause an error as dividing by 0
        print("This is never printer")
    except ValueError as e:
            print(e, file=sys.stderr)

    print("Program execution continues normally here.")

if __name__ == '__main__':
    main()