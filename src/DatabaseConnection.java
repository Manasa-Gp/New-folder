import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Scanner;

public class DatabaseConnection {

  public static void main(String[] args) throws SQLException {

    Scanner sc = new Scanner(System.in);
    // JDBC URL, username, and password of MySQL server
    String url = "jdbc:mysql://localhost:3306/register_db";
    System.out.println("In case DB name is modified, please change the 'url' string in DatabaseConnection.java");
    System.out.println("Enter your username to connect to the database:");
    String user = sc.nextLine();
    System.out.println("Enter your password to connect to the database:");
    String password = sc.nextLine();
    Connection connection = null;

    try {
      // Register JDBC driver
      Class.forName("com.mysql.cj.jdbc.Driver");

      // Open a connection
      connection = DriverManager.getConnection(url, user, password);

      RegisterDatabase databaseExample = new RegisterDatabase(connection);
      databaseExample.selectAccessLevel();

      // Execute a query
      Statement statement = connection.createStatement();

      statement.close();
      connection.close();
    } catch (Exception e) {
      System.out.println("Error connecting to database");
    } finally {
      if (connection != null) {
        try {
          connection.close();
        } catch (SQLException e) {
          System.out.println("Error closing the connection");
        }
      }
    }
  }
}
