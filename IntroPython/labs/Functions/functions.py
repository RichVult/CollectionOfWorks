def get_value() -> str:
    return "words"

def find_smallest(theList):
    if len(theList) == 0:
        return None
    curSmall = theList[0]
    for num in theList:
        if curSmall > num:
            curSmall = num
    return curSmall

def square(*args):
    retList = []
    for num in args:
        retList.append(num**2)
    return retList

def average(theList):
    if len(theList) == 0:
        return None
    total = 0
    for num in theList:
        total += num
    return total/len(theList)

def count_vowels(word):
    count = 0
    for i in range(len(word)):
        if word[i] == "a" or word[i] == "e" or word[i] == "i" or word[i] == "o" or word[i] == "u":
            count += 1
    return count

print(get_value())
print(find_smallest([3,4,1]))
print(square(4,12,9))
print(average([5,10]))
print(count_vowels("some vowels"))