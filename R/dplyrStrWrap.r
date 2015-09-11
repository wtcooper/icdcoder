# Helper functions that allow string arguments for  dplyr's data modification 
# functions like arrange, select etc. 
# Author: Sebastian Kranz
# https://gist.github.com/skranz/9681509

# Can also install complete set as package from install_github("wtcooper/dplyrStrWrap")


#' Modified version of dplyr's select that uses string arguments
s_select = function(.data, ...) {
	eval.string.dplyr(.data,"select", ...)
}


#' Internal function used by s_filter, s_select etc.
eval.string.dplyr = function(.data, .fun.name, ...) {
	args = list(...)
	args = unlist(args)
	code = paste0(.fun.name,"(.data,", paste0(args, collapse=","), ")")
	df = eval(parse(text=code,srcfile=NULL))
	df  
}