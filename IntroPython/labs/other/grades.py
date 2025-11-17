def getFinalGrade(final):
    if(final>= 93.0):
        return "A"
    elif(final>= 90.0):
        return "A-"
    elif(final>=87.0):
        return "B+"
    elif(final>=83.0):
        return "B"
    elif(final>=80.0):
        return "B-"
    elif(final>=77.0):
        return "C+"
    elif(final>=73.0):
        return "C"
    elif(final>=70.0):
        return "C-"
    elif(final>=66.0):
        return "D+"
    elif(final>=60.0):
        return "D"
    return "F"

def main():
    grades = []
    while(True):
        grade = float(input("Please input, negative to break "))
        if (grade < 0):
            break
        grades.append(grade)
    total = 0.0
    for gr in grades:
        total += gr
    finalGrade = total/len(grades)
    print(finalGrade)
    print(getFinalGrade(finalGrade))

main()