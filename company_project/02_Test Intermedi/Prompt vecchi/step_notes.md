# Step 1 -> Step 2

### General
Ulimited max_length

### SAS to Python
- Do not use any syntax of SAS in the Python code (presence of one %include ... in the translation)
- Make sure that the file path has the correct syntax, with forward slashes or adding r before the string (some paths where defined with \ and without initial r, in this way they do not define a path but specify special characters)
- Return all the code in one single block (some codes where returned with comments insiede and import not at the begin, compromising a good readibility and structure of the code)
- Make sure to close al the parenthesis
- Try to make the operation in a more efficient way (see CodeQwen file_6_v2)
- Translate do not skipping any part of the input code and defining or importing all the variables before using them (see CodeQwen file_5_v2 "quadrato")
- Translate all the parts of the code that i give you and allow it to do the same operations

### SQL to PySpark 
- Do not use the function sqprk.sql() and convert all the code in PySpark without writing SQL code
- Make sure to close all the parenthesis
- Try to make the operation in a more efficient way (see CodeQwen file_6_v1)
- You need to use proper column operations and the correct syntax for casting and aliasing, you may need to use a different approach to select a constant value, such as using the lit() (see OpenCode 6.7B file_5_v1, line 166-167)
- Promote a better readibility of the code breaking in smaller pieces big parts of code




# Step 2 -> Step 3

### General
Same prompts but temperature = 1
Limited max_length