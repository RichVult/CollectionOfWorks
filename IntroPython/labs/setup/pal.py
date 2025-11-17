def if_palindrome(theInput):
    if len(theInput) % 2 == 0:
        return theInput[: int(len(theInput)/2)] == ((theInput[int(len(theInput)/2) :])[::-1])
    else:
        return theInput[: int(len(theInput)/2)+1] == ((theInput[int(len(theInput)/2) :])[::-1])
def check_if_pal(theInput):
    for i in range(len(theInput)//2):
        if theInput[i] != theInput[len(theInput) - i - 1]:
            return False
    return True

print(if_palindrome("racecar"))
print(if_palindrome("abba"))
print(if_palindrome("123"))
print(if_palindrome("1234"))
print(check_if_pal("racecar"))
print(check_if_pal("abba"))
print(check_if_pal("123"))
print(check_if_pal("1234"))