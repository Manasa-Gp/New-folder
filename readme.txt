Programming Language used: Java, jdk version 11.0.20.
IDE used: IntelliJ.
OS: Windows
Steps to follow to add the JDBC jar file to IntelliJ:
1. Click 'File' in the top navigation bar and choose 'Project Structure'.
2. Go to 'Modules' from the left pane.
3. Click on + and select the option 'JARs or directories'.
4. Choose the JDBC jar file from your system.
5. Click on Apply and then OK.
Steps to run the program:

1. Unzip SQLregister.zip - this contains the Java source code.
2. Open the IntelliJ application in your system.
3. Click 'File' in the top navigation bar, select 'Open', and choose the code directory.
4. Make sure the JDBC jar file is added to the project by following the steps provided above.
5. Run DatabaseConnection.java, note program assumes the server Name is "localhost" , port Number is "3306" and server name is “register_db”, if it’s not the same in your system please change the ‘url’ string accordingly.
6. Once the program is run, it asks for the server username and password. 
7. Once the database connection is successful, please follow the instructions on the console to execute the program.

SQL Dump:

register_db_final_dump.sql is the export of our register_db database, please ensure that this is run before the execution of the program.
