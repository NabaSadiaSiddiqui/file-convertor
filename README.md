### File Convertor  
This is a small tool written in OO Perl that takes as input a file specified format, and converts it to another format (both the format and output file name need be specified by the user)  
  
  
usage: `bin/main.pl [<command>] [<args>]`
  
  	The valid, required commands are:
  	-o	original format. Currently supported formats are csv and xlsx. See note [1] below
  	-s	source file. This is the name of the file that needs to be converted
  	-t	target format. Currently supported formats are csv and xlsx. See note [1] below
  	-d	desitination file. This is the name of the converted, output file.
  
Example: `bin/main.pl -o csv -s input.csv -t xlsx -d output.xlsx`
  
note [1] - csv is comma separated value file format; xlsx is excel spreadsheet file format  
note [2] - currently, the utility can only read from the first, open worksheet when converting from xlsx to another format
