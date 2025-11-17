def email_maker(first,last):
    return (first[0] + "." + last[:5] +  "@marist.edu")

def main():
    first_name = input("Please input your first name ") #get first name with input
    last_name = input("Please input your last name ") #get last name with input
    print(email_maker(first_name,last_name))


main()