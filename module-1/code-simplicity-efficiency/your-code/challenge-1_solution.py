def cal_num(num1, num2, oper):
    num_opt = ['zero', 'one', 'two', 'three', 'four', 'five']
    operands= ['plus', 'minus']
    results = ['zero', 'one', 'two', 'three', 'four', 'five', 'six', 'seven', 'eight', 'nine', 'ten']

    if num1 and num2 not in num_opt or oper not in operands:
        print("I am not able to answer this question. Check your input.")

    else:
        if oper == 'plus':
            print(num1, oper, num2, 'equals', results[num_opt.index(num1) + num_opt.index(num2)])

        if b == 'minus':
            if num_opt.index(num1) >= num_opt.index(num2):
                print(num1, oper, num2, 'equals', results[num_opt.index(num1) - num_opt.index(num2)])
            else:
                print(num1, oper, num2, 'equals', 'negative', results[num_opt.index(num2) - num_opt.index(num1)])


print("Thanks for using this calculator, goodbye :)")

print('Welcome to this calculator!')
print('It can add and subtract whole numbers from zero to five')

a = input('Please choose your first number (zero to five): ').lower()
b = input('What do you want to do? plus or minus: ').lower()
c = input('Please choose your second number (zero to five): ').lower()

cal_num(a, c, b)