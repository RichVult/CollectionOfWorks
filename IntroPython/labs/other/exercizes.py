def get_maximum(a: float,b: float,c: float) -> float:
    max = a
    if b > a:
        max = b
    if c > max:
        c = max
    return max

def get_sum(numbers : list[float]) -> float:
    result = 0.0
    for n in numbers:
        if type(n) != int and type(n) != float:
            continue
        result += n
    return result

def reverse_string(s : str) -> str:
    return s[:: -1]
