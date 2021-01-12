import matplotlib

# Pause the program to be able to inspect outputs.
def pause(x = ""):
    print(x)
    input("=========== Press the <ENTER> key to continue ===========")

# Show graphs in separate window when program ran in terminal.
def show():
   return matplotlib.pyplot.show(block=True)
