

f = open("SoCNow.v", "r")
contents = f.readlines()
f.close()

count = 2
for i in contents:
    # print(i[0:26])
    if i[0:26] == "  reg [31:0] mem [0:1023];":
        print(i)
        break
    else:
        count = count + 1

contents.insert(count, 'initial begin\n $readmemh("program.mem", mem); \n end\n')
f = open("SoCNow.v", "w")
contents = "".join(contents)
f.write(contents)
f.close()

print(count)
