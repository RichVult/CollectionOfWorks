import os
def main():
    print(os.getcwd())
    file = open("wo.txt", "r")
    #user1 = " our words "
    print(file.read())
    


main()