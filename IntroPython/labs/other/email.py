def main():
    first_name = input("Please input your first name ") #get first name with input
    last_name = input("Please input your last name ") #get last name with input
    first_initial = first_name[0]
    last_five = last_name[:5]
    the_email = (first_initial + "." + last_five +  "@marist.edu")
    print(the_email)


main()