
# Add a pause to see the intermediate result in the script.
pause <- function(x = "---------------------------------------------")
{
	print(x)
	if (interactive())
	{
	    invisible(readline(prompt = "============= Press <Enter> to continue ============="))
	}
	else
	{
	    cat("============= Press <Enter> to continue =============")
	    invisible(readLines(file("stdin"), 1))
	}
}

# So that graphs fit inside atleast a window that is 1/4 of the screen.
show <- function(plot){
	X11(height = 5,width =6)
	print(plot)
	pause()
}

# Show plot in terminal.
## Dependencies: R package txtplot; self fun pause().
show_cli <- function(x,y){
	x <- as.numeric(x)
	y <- as.numeric(y)
	pause(txtplot::txtplot(x = x,y = y))
}

# Open up a X11 window to show plots.
# After each plot, there needs to be call to function pause,
# otherwise one doesn't see the plots.
show_initializer <- function(){
	X11(height = 5,width =6)
}
