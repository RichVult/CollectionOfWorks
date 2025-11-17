def main():
    a = float(input("please input the principle "))
    b = float(input("please input the apr "))
    print(calc(a,b))
    
def calc(principle,apr):
    total = principle
    for i in range(10):
        total = total * (1.0 + apr)
    asStr = str(total)
    curChar = ""
    retStr = ""
    count = 0
    while True:
        curChar = asStr[count]
        retStr = retStr + curChar
        if(curChar == "."):
            break
        count = count + 1
    retStr = retStr + asStr[count + 1]
    retStr = retStr + asStr[count + 2]
    return retStr

main()