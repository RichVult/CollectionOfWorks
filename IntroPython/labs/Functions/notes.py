def my_func(a: int, b = "Hello"):
    if type(a) != int:
        raise Exception("Wrong parameter type:", type(a))
    for i in range(a):
        print(b)

my_func(3)
my_func(True,"yes")
