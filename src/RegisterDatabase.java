import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Types;
import java.util.ArrayList;
import java.util.Scanner;

public class RegisterDatabase {

  private Connection connection;

  private Scanner scanner;

  private Table table;

  public RegisterDatabase(Connection connection) {
    this.connection = connection;
    scanner = new Scanner(System.in);
    table = new Table();
  }

  public void selectAccessLevel() throws SQLException {
    System.out.println("Please select your role to perform operations");
    System.out.println("1. Admin");
    System.out.println("2. Student");
    System.out.println("3. Professor");

    Scanner scanner = new Scanner(System.in);
    System.out.print("Enter your choice (1, 2, or 3): ");

    int choice = scanner.nextInt();

    switch (choice) {
      case 1:
        adminAccess();
        break;
      case 2:
        studentAccess();
        break;
      case 3:
        professorAccess();
        break;
      default:
        System.out.println("Invalid choice");
    }
  }

  private void professorAccess() {
    int maxAttempts = 3;

    while (maxAttempts > 0) {
      System.out.println("Enter your email ID: ");
      String email = scanner.next();
      System.out.println("Enter password: ");
      String password = scanner.next();
      try {

        if (isValidUser(email, password, "professor")) {

          CallableStatement cs = connection.prepareCall("{ ? = CALL get_professor_id(?) }");
          cs.registerOutParameter(1, Types.INTEGER);
          cs.setString(2, email);
          cs.execute();
          int professorID = cs.getInt(1);
          cs.close();
          while (true) {
            System.out.println("Professor options:");
            System.out.println("1. View Sections Teaching");
            System.out.println("2. View Students");
            System.out.println("3. Update my password");
            System.out.println("4. Exit");
            System.out.print("Enter option number: ");

            int option = scanner.nextInt();
            scanner.nextLine();

            switch (option) {
              case 1:
                getSections(professorID);
                break;
              case 2:
                getSectionStudents(professorID);
                break;
              case 3:
                updatePassword(email,"professor");
                break;
              case 4:
                exit();
              default:
                System.out.println("Invalid option");
            }
          }
        } else {
          System.out.println("Invalid Professor credentials. Please try again.");
        }

      } catch (SQLException e) {
        if (e.getSQLState().equals("45000")) {
          System.out.println(e.getMessage());
        }
        maxAttempts--;
      }


    }
    System.out.println("Maximum attempts reached, exiting the application.");

  }

  private void getSectionStudents(int professorID) throws SQLException {
    ArrayList<Integer> sections = new ArrayList<>();
    String sqlQuery = "{CALL get_sections(?)}";
    try (CallableStatement callableStatement = connection.prepareCall(sqlQuery)) {
      callableStatement.setInt(1, professorID);

      callableStatement.execute();

      ResultSet resultSet = callableStatement.getResultSet();

      // Process the result set
      System.out.println("Professor Sections Data:");
      while (resultSet.next()) {
        int sectionId = resultSet.getInt("section_id");
        sections.add(sectionId);
        String departmentName = resultSet.getString("department_name");
        String collegeName = resultSet.getString("college_name");

        System.out.println("Department: " + departmentName);
        System.out.println("College: " + collegeName);
        System.out.println("Section ID: " + sectionId);
      }
      System.out.println("Select the sections you want to see the student list for");
      int getSection = scanner.nextInt();
      scanner.nextLine();
      if (sections.contains(getSection)) {
        String query = "{CALL get_students_from_section(?)}";
        try (CallableStatement cs2 = connection.prepareCall(query)) {
          cs2.setInt(1, getSection);

          cs2.execute();

          ResultSet rs2 = cs2.getResultSet();

          table.populateTable(rs2);
          waitForInput();
          cs2.close();
          rs2.close();
        }
        callableStatement.close();
        resultSet.close();

      } else {
        System.out.println("Invalid selection:");
      }
    } catch (SQLException e) {
      if ("45000".equals(e.getSQLState())) {
        System.out.println(e.getMessage());
      } else {
        System.out.println("Error retrieving sections of professor.");
      }
    }
  }

  private void getSections(int professorID) {
    String sqlQuery = "{CALL get_sections(?)}";

    try (CallableStatement callableStatement = connection.prepareCall(sqlQuery)) {
      callableStatement.setInt(1, professorID);

      callableStatement.execute();

      ResultSet resultSet = callableStatement.getResultSet();
      table.populateTable(resultSet);
      waitForInput();

    } catch (SQLException e) {
      if ("45000".equals(e.getSQLState())) {
        System.out.println(e.getMessage());
      } else {
        System.out.println("Error retrieving sections of professor.");
      }
    }
  }

  private void studentAccess() throws SQLException {
    System.out.println("Enter your Student Email:");
    String studentEmail = scanner.nextLine();
    System.out.println("Enter your Password:");
    String studentPass = scanner.nextLine();

    if (isValidUser(studentEmail, studentPass, "student")) {

      String studentName = "{ ? = CALL get_student_name(?) }";
      CallableStatement cs = connection.prepareCall(studentName);

      String studentLevel = "{ ? = CALL get_student_level(?) }";
      CallableStatement cs2 = connection.prepareCall(studentLevel);

      String studentHold = "{ ? = CALL get_student_hold(?) }";
      CallableStatement cs3 = connection.prepareCall(studentHold);

      CallableStatement cs4 = connection.prepareCall("{ ? = CALL get_student_id(?) }");


      cs.registerOutParameter(1, Types.VARCHAR);
      cs2.registerOutParameter(1, Types.VARCHAR);
      cs3.registerOutParameter(1, Types.BOOLEAN);
      cs4.registerOutParameter(1, Types.INTEGER);

      cs.setString(2, studentEmail);
      cs2.setString(2, studentEmail);
      cs3.setString(2, studentEmail);
      cs4.setString(2, studentEmail);

      cs.execute();
      cs2.execute();
      cs3.execute();
      cs4.execute();

      String name = cs.getString(1);
      String level = cs2.getString(1);
      Boolean hold = cs3.getBoolean(1);
      int studentID = cs4.getInt(1);

      System.out.println("Welcome, " + name);
      System.out.println("Your level is " + level);
      System.out.println("Hold prohibiting registration: " + hold);
      System.out.println("Below are the available operations for you to choose from:");

      cs.close();
      cs2.close();
      cs3.close();

      while (true) {
        System.out.println("1. Search course sections by number");
        System.out.println("2. Display all sections of courses at my level");
        System.out.println("3. Register for a section");
        System.out.println("4. Drop a section");
        System.out.println("5. Display my registered sections");
        System.out.println("6. Update my password");
        System.out.println("7. Exit");
        System.out.println("Enter your choice:");
        int choice = scanner.nextInt();
        switch (choice) {
          case 1:
            System.out.println("Enter the course number:");
            int cno = scanner.nextInt();
            scanner.nextLine();
            searchCourseByNumber(cno);
            break;
          case 2:
            displayAllCourseSections(level);
            break;
          case 3:
            System.out.println("Enter section number you want to register for:");
            int sno = scanner.nextInt();
            scanner.nextLine();
            registerForSection(sno, studentID);
            break;
          case 4:
            System.out.println("Enter section number you want to drop from:");
            int secno = scanner.nextInt();
            scanner.nextLine();
            dropSection(secno, studentID);
            break;
          case 5:
            displayMySections(studentID);
            break;
          case 6:
            updatePassword(studentEmail,"student");
            break;
          case 7:
            exit();
          default:
            System.out.println("Invalid choice:");
        }
      }
    } else {
      System.out.println("Invalid username or password");
    }
  }

  private void displayMySections(int studentID) {
    try {
      CallableStatement cs = connection.prepareCall("{CALL display_my_sections(?)}");
      cs.setInt(1, studentID);
      ResultSet rs = cs.executeQuery();
      table.populateTable(rs);
      waitForInput();
    } catch (SQLException e) {
      System.out.println("Error retrieving registered sections");
    }
  }

  private void dropSection(int secno, int studentID) {
    try {
      CallableStatement cs = connection.prepareCall("{CALL drop_section(?, ?)}");
      cs.setInt(1, secno);
      cs.setInt(2, studentID);
      cs.executeQuery();
      System.out.println("Successfully dropped the section");
      cs.close();
      waitForInput();

    } catch (SQLException e) {
      if ("45000".equals(e.getSQLState())) {
        System.out.println(e.getMessage());
      } else {
        System.out.println("Error dropping a section.");
      }
    }
  }

  private void registerForSection(int sno, int studentID) {
    try {
      CallableStatement cs = connection.prepareCall("{CALL register(?, ?)}");
      cs.setInt(1, sno);
      cs.setInt(2, studentID);
      cs.executeQuery();
      System.out.println("Successfully registered for the section");
      cs.close();
      waitForInput();

    } catch (SQLException e) {
      if ("45000".equals(e.getSQLState())) {
        System.out.println(e.getMessage());
      } else {
        System.out.println("Error registering for section.");
      }
    }
  }

  private void displayAllCourseSections(String level) {
    try {
      CallableStatement cs = connection.prepareCall("{CALL get_sections_at_level(?)}");
      cs.setString(1, level);
      ResultSet rs = cs.executeQuery();
      table.populateTable(rs);
      waitForInput();
    } catch (SQLException e) {
      System.out.println("Error retrieving sections by level");
    }
  }

  private void searchCourseByNumber(int cno) {
    try {
      CallableStatement cs = connection.prepareCall("{CALL get_course_sections(?)}");
      cs.setInt(1, cno);
      ResultSet rs = cs.executeQuery();
      table.populateTable(rs);
      waitForInput();
    } catch (SQLException e) {
      if ("45000".equals(e.getSQLState())) {
        System.out.println(e.getMessage());
      } else {
        System.out.println("Error retrieving course details from database.");
      }
    }
  }


  private void adminAccess() throws SQLException {
    int maxAttempts = 3;

    while (maxAttempts > 0) {
      System.out.println("Enter your email ID:");
      String email = scanner.nextLine();
      System.out.println("Enter password:");
      String password = scanner.nextLine();

      try {
        if (isValidUser(email, password, "admin")) {
          while (true) {
            System.out.println("Admin options:");
            System.out.println("1. Display all Students");
            System.out.println("2. Place Hold");
            System.out.println("3. Remove Hold");
            System.out.println("4. Manage College");
            System.out.println("5. Manage Department");
            System.out.println("6. Manage Courses");
            System.out.println("7. Manage Prerequisites");
            System.out.println("8. Manage Professor");
            System.out.println("9. Manage Section");
            System.out.println("10. Manage Students");
            System.out.println("11. Add Semester");
            System.out.println("12. Update my password");
            System.out.println("13. Exit");
            System.out.print("Enter option number: ");

            int option = scanner.nextInt();
            scanner.nextLine();

            switch (option) {
              case 1:
                getStudents();
                break;
              case 2:
                placeHoldOnStudent("place_hold");
                break;
              case 3:
                placeHoldOnStudent("remove_hold");
                break;
              case 4:
                manageCollege();
                break;
              case 5:
                manageDepartment();
                break;
              case 6:
                manageCourse();
                break;
              case 7:
                managePrerequisite();
                break;
              case 8:
                manageProfessor();
                break;
              case 9:
                manageSection();
                break;
              case 10:
                manageStudents();
                break;
              case 11:
                addSemester();
                break;
              case 12:
                updatePassword(email,"admin");
                break;
              case 13:
                exit();
              default:
                System.out.println("Invalid option");
            }
          }
        }
      } catch (NumberFormatException e) {
        System.out.println("Invalid input. Please enter a valid ID.");
      }

      maxAttempts--;
    }

    System.out.println("Maximum attempts reached, exiting the application.");
  }

  private void addSemester() {
    try {
      PreparedStatement ps = connection.prepareStatement("CALL add_semester(?, ?)");
      scanner.nextLine();
      System.out.println("Enter Term(Fall/Spring/Summer):");
      String term = scanner.nextLine();
      System.out.println("Enter year:");
      int year = scanner.nextInt();

      ps.setString(1, term);
      ps.setInt(2, year);

      ps.executeUpdate();
      ps.close();
      System.out.println("Semester has been added!");
      waitForInput();

    } catch (SQLException e) {
      if ("45000".equals(e.getSQLState())) {
        System.out.println(e.getMessage());
      } else {
        System.out.println("Error adding semester to the database");
      }
    }
  }

  private void manageStudents() {
    while (true) {
      System.out.println("1. Display all Students");
      System.out.println("2. Add a Student");
      System.out.println("3. Update Student details");
      System.out.println("4. Delete a student");
      System.out.println("5. Return to Main Menu");
      System.out.println("Enter your choice:");
      int choice = scanner.nextInt();
      scanner.nextLine();
      switch (choice) {
        case 1:
          displayStudents();
          break;
        case 2:
          addStudent();
          break;
        case 3:
          updateStudent();
          break;
        case 4:
          deleteStudent();
          break;
        case 5:
          return;
        default:
          System.out.println("Invalid choice");
      }
    }
  }

  private void displayStudents() {
    try {
      CallableStatement cs = connection.prepareCall("{call get_all_students()}");
      ResultSet rs = cs.executeQuery();
      table.populateTable(rs);
      waitForInput();
    } catch (SQLException e) {
      System.out.println("Error displaying students");
    }
  }

  private void deleteStudent() {
    try {

      PreparedStatement ps = connection.prepareStatement("CALL delete_student(?)");
      System.out.println("Enter student ID:");
      int id = scanner.nextInt();
      scanner.nextLine();
      ps.setInt(1, id);
      ps.executeUpdate();
      ps.close();
      System.out.println("Student details are deleted");
      waitForInput();

    } catch (SQLException e) {
      if ("45000".equals(e.getSQLState())) {
        System.out.println(e.getMessage());
      } else {
        System.out.println("Error deleting student details from database.");
      }
    }
  }

  private void updateStudent() {
    try {
      PreparedStatement ps = connection.prepareStatement("CALL update_student(?, ?, ?, ?)");
      System.out.println("Enter the ID of the student");
      int studentId = scanner.nextInt();
      scanner.nextLine();
      System.out.println("Enter new email:");
      String email = scanner.nextLine();

      System.out.println("Enter new credits acquired:");
      int creditsAcquired = scanner.nextInt();
      scanner.nextLine();

      System.out.println("Enter new credits registered:");
      int creditsRegistered = scanner.nextInt();
      scanner.nextLine();

      ps.setInt(1, studentId);
      ps.setString(2, email);
      ps.setInt(3, creditsAcquired);
      ps.setInt(4, creditsRegistered);

      ps.executeUpdate();
      ps.close();
      System.out.println("Student record has been updated");
      waitForInput();

    } catch (SQLException e) {
      if ("45000".equals(e.getSQLState())) {
        System.out.println(e.getMessage());
      } else {
        System.out.println("Error updating student data to the database");
      }
    }
  }

  private void addStudent() {
    try {
      PreparedStatement ps = connection.prepareStatement("CALL add_student(?, ?, ?, ?, ?, ?,?,?)");
      System.out.println("Enter name of the Student:");
      String name = scanner.nextLine();
      System.out.println("Enter email:");
      String email = scanner.nextLine();
      System.out.println("Enter temporary password:");
      String password = scanner.nextLine();
      System.out.println("Enter level of student:");
      String level = scanner.nextLine();
      System.out.println("Enter credits acquired by the student:");
      int creditsAcquired = scanner.nextInt();
      scanner.nextLine();
      System.out.println("Enter credits registered by the student:");
      int creditsRegistered = scanner.nextInt();
      scanner.nextLine();
      System.out.println("Enter hold status on student(True or False):");
      boolean hold = scanner.nextBoolean();
      System.out.println("Enter the ID of the college the student should be mapped to");
      int collegeID = scanner.nextInt();
      scanner.nextLine();

      ps.setString(1, name);
      ps.setString(2, email);
      ps.setString(3, level);
      ps.setInt(4, creditsAcquired);
      ps.setInt(5, creditsRegistered);
      ps.setBoolean(6, hold);
      ps.setInt(7, collegeID);
      ps.setString(8, password);
      ps.executeUpdate();
      ps.close();
      System.out.println("Student record has been added");
      waitForInput();

    } catch (SQLException e) {
      if ("45000".equals(e.getSQLState())) {
        System.out.println(e.getMessage());
      } else {
        System.out.println("Error adding student data to the database");
      }
    }
  }

  private void manageSection() {
    while (true) {
      System.out.println("1. Display all sections");
      System.out.println("2. Add a section");
      System.out.println("3. Update a section");
      System.out.println("4. Delete a section");
      System.out.println("5. Return to Main Menu");
      System.out.println("Enter your choice:");
      int choice = scanner.nextInt();
      scanner.nextLine();
      switch (choice) {
        case 1:
          displaySections();
          break;
        case 2:
          addSection();
          break;
        case 3:
          updateSection();
          break;
        case 4:
          deleteSection();
          break;
        case 5:
          return;
        default:
          System.out.println("Invalid choice");
      }
    }
  }

  private void deleteSection() {
    try {
      CallableStatement cs = connection.prepareCall("{CALL delete_section(?)}");
      System.out.println("Enter section ID:");
      int sectionId = scanner.nextInt();
      scanner.nextLine();

      cs.setInt(1, sectionId);
      cs.executeUpdate();
      cs.close();

      System.out.println("Section details are deleted");
      waitForInput();

    } catch (SQLException e) {
      if ("45000".equals(e.getSQLState())) {
        System.out.println(e.getMessage());
      } else {
        System.out.println("Error deleting section details from the database.");
      }
    }
  }


  private void updateSection() {
    try {
      CallableStatement cs = connection.prepareCall("{CALL update_section(?, ?, ?, ?)}");
      System.out.println("Enter section ID to update:");
      int sectionId = scanner.nextInt();
      scanner.nextLine();
      System.out.println("Enter available seats:");
      int availableSeats = scanner.nextInt();
      scanner.nextLine();
      System.out.println("Enter available waitlist seats:");
      int availableWaitlist = scanner.nextInt();
      scanner.nextLine();
      System.out.println("Enter professor ID:");
      int professorId = scanner.nextInt();
      scanner.nextLine();
      cs.setInt(1, sectionId);
      cs.setInt(2, availableSeats);
      cs.setInt(3, availableWaitlist);
      cs.setInt(4, professorId);

      cs.executeUpdate();
      cs.close();

      System.out.println("Section has been updated successfully");
      waitForInput();
    } catch (SQLException e) {
      if ("45000".equals(e.getSQLState())) {
        System.out.println(e.getMessage());
      } else {
        System.out.println("Error updating section data in the database");
      }
    }
  }


  private void addSection() {
    try {
      CallableStatement cs = connection.prepareCall("{CALL add_section(?, ?, ?, ?, ?, ?, ?)}");
      System.out.println("Enter available seats:");
      int availableSeats = scanner.nextInt();
      scanner.nextLine();
      System.out.println("Enter available waitlist seats:");
      int availableWaitlist = scanner.nextInt();
      scanner.nextLine();
      System.out.println("Enter timings:");
      String timings = scanner.nextLine();
      System.out.println("Enter course number:");
      int courseNumber = scanner.nextInt();
      scanner.nextLine();
      System.out.println("Enter professor ID:");
      int professorId = scanner.nextInt();
      scanner.nextLine();
      System.out.println("Enter term (Fall/Spring/Summer):");
      String term = scanner.nextLine();
      System.out.println("Enter year:");
      int year = scanner.nextInt();
      scanner.nextLine();
      cs.setInt(1, availableSeats);
      cs.setInt(2, availableWaitlist);
      cs.setString(3, timings);
      cs.setInt(4, courseNumber);
      cs.setInt(5, professorId);
      cs.setString(6, term);
      cs.setInt(7, year);

      cs.executeUpdate();
      cs.close();

      System.out.println("Section has been added successfully");
      waitForInput();
    } catch (SQLException e) {
      if ("45000".equals(e.getSQLState())) {
        System.out.println(e.getMessage());
      } else {
        System.out.println("Error adding section data to the database");
      }
    }
  }


  private void displaySections() {
    try {
      CallableStatement cs = connection.prepareCall("{call display_all_sections()}");
      ResultSet rs = cs.executeQuery();
      table.populateTable(rs);
      waitForInput();
    } catch (SQLException e) {
      System.out.println("Error displaying sections");
    }
  }

  private void manageProfessor() {
    while (true) {
      System.out.println("1. Display all professors");
      System.out.println("2. Add a professor");
      System.out.println("3. Update professor details");
      System.out.println("4. Delete a professor");
      System.out.println("5. Return to Main Menu");
      System.out.print("Enter your choice:");
      int choice = scanner.nextInt();

      switch (choice) {
        case 1:
          displayProfessors();
          break;
        case 2:
          addProfessor();
          break;
        case 3:
          updateProfessor();
          break;
        case 4:
          deleteProfessor();
          break;
        case 5:
          return;
        default:
          System.out.println("Invalid choice");
      }
    }
  }

  private void deleteProfessor() {
    try {

      PreparedStatement ps = connection.prepareStatement("CALL delete_professor(?)");
      System.out.println("Enter professor ID:");
      int id = scanner.nextInt();
      scanner.nextLine();
      ps.setInt(1, id);
      ps.executeUpdate();
      ps.close();
      System.out.println("Professor details are deleted");
      waitForInput();

    } catch (SQLException e) {
      if ("45000".equals(e.getSQLState())) {
        System.out.println(e.getMessage());
      } else {
        System.out.println("Error deleting professor details from database.");
        System.out.println("If the professor is mapped to a section, please try deleting or updating" +
                "the section to a different professor.");
      }
    }
  }

  private void updateProfessor() {
    try {
      PreparedStatement ps = connection.prepareStatement("CALL update_professor(?, ?, ?, ?)");
      System.out.println("Enter the ID of the professor");
      int id = scanner.nextInt();
      scanner.nextLine();
      System.out.println("Enter new name:");
      String name = scanner.nextLine();
      System.out.println("Enter new email:");
      String email = scanner.nextLine();
      System.out.println("Enter new phone number(12 characters including country code");
      String phNo = scanner.nextLine();
      ps.setInt(1, id);
      ps.setString(2, name);
      ps.setString(3, email);
      ps.setString(4, phNo);
      ps.executeUpdate();
      ps.close();
      System.out.println("Professor record has been updated");
      waitForInput();

    } catch (SQLException e) {
      if ("45000".equals(e.getSQLState())) {
        System.out.println(e.getMessage());
      } else {
        System.out.println("Error updating professor data to the database");
      }
    }
  }

  private void addProfessor() {
    try {
      PreparedStatement ps = connection.prepareStatement("CALL add_professor(?, ?, ?, ?, ?, ?)");
      scanner.nextLine();
      System.out.println("Enter SSN(9 digits):");
      String ssn = scanner.nextLine();
      System.out.println("Enter name of the professor:");
      String name = scanner.nextLine();
      System.out.println("Enter email:");
      String email = scanner.nextLine();
      System.out.println("Enter phone number(12 characters including country code):");
      String phNo = scanner.nextLine();
      System.out.println("Enter the ID of the college the professor should be mapped to:");
      int collegeID = scanner.nextInt();
      scanner.nextLine();
      System.out.println("Enter temporary password:");
      String password = scanner.nextLine();
      ps.setString(1, ssn);
      ps.setString(2, name);
      ps.setString(3, email);
      ps.setString(4, phNo);
      ps.setInt(5, collegeID);
      ps.setString(6, password);
      ps.executeUpdate();
      ps.close();
      System.out.println("Professor record has been added");
      waitForInput();

    } catch (SQLException e) {
      if ("45000".equals(e.getSQLState())) {
        System.out.println(e.getMessage());
      } else {
        System.out.println("Error adding professor data to the database");
      }
    }
  }

  private void displayProfessors() {
    try {
      CallableStatement cs = connection.prepareCall("{call get_all_professors()}");
      ResultSet rs = cs.executeQuery();
      table.populateTable(rs);
      waitForInput();
    } catch (SQLException e) {
      System.out.println("Error displaying professors");
    }
  }

  private void managePrerequisite() {
    while (true) {
      System.out.println("1. Display courses and their prerequisites");
      System.out.println("2. Add prerequisite");
      System.out.println("3. Delete prerequisite");
      System.out.println("4. Return to Main Menu");
      System.out.println("Enter your choice:");
      int choice = scanner.nextInt();

      switch (choice) {
        case 1:
          displayPrereqs();
          break;
        case 2:
          addPrereq();
          break;
        case 3:
          deletePrereq();
          break;
        case 4:
          return;
        default:
          System.out.println("Invalid choice");
      }
    }
  }

  private void deletePrereq() {
    try {

      PreparedStatement ps = connection.prepareStatement("CALL delete_prerequisite(?, ?)");
      System.out.println("Enter course ID:");
      int id = scanner.nextInt();
      scanner.nextLine();
      System.out.println("Enter prerequisite course ID:");
      int pid = scanner.nextInt();
      scanner.nextLine();
      ps.setInt(1, id);
      ps.setInt(2, pid);
      ps.executeUpdate();
      ps.close();
      System.out.println("Prerequisite course is deleted");
      waitForInput();

    } catch (SQLException e) {
      if ("45000".equals(e.getSQLState())) {
        System.out.println("Both course ID and prerequsite ID must exist in the database.");
      } else {
        System.out.println("Error deleting the prerequisite course");
      }
    }
  }

  private void addPrereq() {
    try {

      PreparedStatement ps = connection.prepareStatement("CALL add_prerequisite(?, ?)");
      System.out.println("Enter course ID:");
      int id = scanner.nextInt();
      scanner.nextLine();
      System.out.println("Enter prerequisite course ID:");
      int pid = scanner.nextInt();
      scanner.nextLine();
      ps.setInt(1, id);
      ps.setInt(2, pid);
      ps.executeUpdate();
      ps.close();
      System.out.println("Prerequisite course is added");
      waitForInput();

    } catch (SQLException e) {
      if ("45000".equals(e.getSQLState())) {
        System.out.println(e.getMessage());
      } else {
        System.out.println("Error adding the prerequisite course");
      }
    }
  }

  private void displayPrereqs() {
    try {
      CallableStatement cs = connection.prepareCall("{call get_course_prerequisites()}");
      ResultSet rs = cs.executeQuery();
      table.populateTable(rs);
      waitForInput();
    } catch (SQLException e) {
      System.out.println("Error displaying prerequisites for courses");
    }
  }

  private void manageDepartment() throws SQLException {
    while (true) {
      System.out.println("1. Display Department Details");
      System.out.println("2. Add Department");
      System.out.println("3. Update Department");
      System.out.println("4. Delete Department");
      System.out.println("5. Return to Main Menu");
      System.out.println("Choose an option:");
      int choice = scanner.nextInt();

      switch (choice) {
        case 1:
          getDepartment();
          break;
        case 2:
          System.out.print("Enter the ID of the college you want to add department to:");
          int collegeID = scanner.nextInt();
          addDepartment(collegeID);
          break;
        case 3:
          System.out.print("Enter the department ID you want to update:");
          int id1 = scanner.nextInt();
          updateDepartment(id1);
          break;
        case 4:
          deleteDepartment();
          break;
        case 5:
          return;
        default:
          System.out.println("Invalid option");
      }
    }
  }

  private void deleteDepartment() {
    try {

      PreparedStatement ps = connection.prepareStatement("CALL delete_department(?)");
      System.out.println("Enter the ID of department to delete:");
      int id = scanner.nextInt();
      ps.setInt(1, id);
      ps.executeUpdate();
      ps.close();
      System.out.println("Department " + id + " is successfully deleted");
      waitForInput();

    } catch (SQLException e) {
      if ("45000".equals(e.getSQLState())) {
        System.out.println("Department with given id does not exist in the database");
      } else {
        System.out.println("Error deleting the department");
      }
    }
  }

  private void updateDepartment(int id) {
    try {
      PreparedStatement ps = connection.prepareStatement("CALL update_department(?, ?, ?)");
      ps.setInt(1, id);
      scanner.nextLine();
      System.out.println("Enter the new name of the department:");
      String departmentName = scanner.nextLine();
      System.out.println("Enter the new budget of the department:");
      double budget = scanner.nextDouble();
      ps.setString(2, departmentName);
      ps.setDouble(3, budget);
      ps.executeUpdate();
      ps.close();
      System.out.println("Record successfully updated");
      waitForInput();
    } catch (SQLException e) {
      if ("45000".equals(e.getSQLState())) {
        System.out.println("Missing mandatory data");
      } else {
        System.out.println("Error updating the department");
      }
    }

  }

  private void addDepartment(int collegeID) {
    try {
      PreparedStatement ps = connection.prepareStatement("CALL add_department(?, ?, ?)");
      System.out.print("Enter the name of the department:");
      String departmentName = scanner.nextLine();
      System.out.println("Enter the budget of the department:");
      double budget = scanner.nextDouble();
      ps.setString(1, departmentName);
      ps.setDouble(2, budget);
      ps.setInt(3, collegeID);
      ps.executeUpdate();
      ps.close();
      waitForInput();
    } catch (SQLException e) {
      if ("45000".equals(e.getSQLState())) {
        System.out.println("College with given id does not exist in the database");
      } else {
        System.out.println("Error adding a new department");
      }
    }
  }

  private void getDepartment() throws SQLException {
    try {
      CallableStatement cs = connection.prepareCall("{call get_department_details()}");
      ResultSet rs = cs.executeQuery();
      table.populateTable(rs);
      waitForInput();
    } catch (SQLException e) {
      System.out.println("Error getting department details.");
    }

  }

  private void manageCourse() throws SQLException {
    while (true) {
      System.out.println("1. Display Course Details");
      System.out.println("2. Add Course");
      System.out.println("3. Update Course");
      System.out.println("4. Delete Course");
      System.out.println("5. Return to Main Menu");
      System.out.println("Choose an option:");
      int choice = scanner.nextInt();

      switch (choice) {
        case 1:
          getCourse();
          break;
        case 2:
          System.out.println("Enter the department ID you want to add the course to:");
          int did = scanner.nextInt();
          addCourse(did);
          break;
        case 3:
          System.out.println("Enter the ID of the course want to update:");
          int cid = scanner.nextInt();
          updateCourse(cid);
          break;
        case 4:
          deleteCourse();
          break;
        case 5:
          return;
        default:
          System.out.println("Invalid option");
      }
    }
  }

  private void deleteCourse() {
    try {

      PreparedStatement ps = connection.prepareStatement("CALL delete_course(?)");
      System.out.println("Enter the ID of course to delete:");
      int id = scanner.nextInt();
      ps.setInt(1, id);
      ps.executeUpdate();
      ps.close();
      System.out.println("Course " + id + " is successfully deleted!");
      waitForInput();

    } catch (SQLException e) {
      if ("45000".equals(e.getSQLState())) {
        System.out.println("Course with given id does not exist in the database");
      } else {
        System.out.println("Error deleting the course");
      }
    }
  }

  private void updateCourse(int cid) {
    try {
      PreparedStatement ps = connection.prepareStatement("CALL update_course(?, ?, ?, ?, ?)");
      ps.setInt(1, cid);
      scanner.nextLine();
      System.out.println("Enter new course name:");
      String cName = scanner.nextLine();
      System.out.println("Enter the new course description:");
      String cDesc = scanner.nextLine();
      System.out.println("Enter new credits for this course:");
      int cred = scanner.nextInt();
      scanner.nextLine();
      System.out.println("Enter new department ID for this course:");
      int did = scanner.nextInt();
      scanner.nextLine();
      ps.setString(2, cName);
      ps.setString(3, cDesc);
      ps.setInt(4, cred);
      ps.setInt(5, did);
      ps.executeUpdate();
      ps.close();
      System.out.println("Record successfully updated");
      waitForInput();
    } catch (SQLException e) {
      if ("45000".equals(e.getSQLState())) {
        System.out.println(e.getMessage());
      } else {
        System.out.println("Error updating the course");
      }
    }
  }

  private void addCourse(int did) {
    try {
      PreparedStatement ps = connection.prepareStatement("CALL add_course(?, ?, ?, ?, ?)");
      scanner.nextLine();
      System.out.println("Enter the name of the course:");
      String courseName = scanner.nextLine();
      System.out.println("Enter the description of the course:");
      String desc = scanner.nextLine();
      System.out.println("Enter the credits for the course:");
      int credits = scanner.nextInt();
      scanner.nextLine();
      System.out.println("Enter the level of the course(Graduate or Undergraduate):");
      String level = scanner.nextLine();
      ps.setString(1, courseName);
      ps.setString(2, desc);
      ps.setInt(3, credits);
      ps.setInt(4, did);
      ps.setString(5, level);
      ps.executeUpdate();
      System.out.println("Course is successfully added to the database.");
      ps.close();
      waitForInput();
    } catch (SQLException e) {
      if ("45000".equals(e.getSQLState())) {
        System.out.println(e.getMessage());
      } else {
        System.out.println("Error adding a new course");
      }
    }
  }

  private void manageCollege() throws SQLException {
    while (true) {
      System.out.println("1. Display College Details");
      System.out.println("2. Add College");
      System.out.println("3. Update College Name");
      System.out.println("4. Return to Main Menu");
      System.out.println("Choose an option:");
      int choice = scanner.nextInt();
      scanner.nextLine();
      switch (choice) {
        case 1:
          getCollege();
          break;
        case 2:
          manageCollegeOperations("add");
          break;
        case 3:
          manageCollegeOperations("update");
          break;
        case 4:
          return;
        default:
          System.out.println("Invalid option");
      }
    }
  }

  private void manageCollegeOperations(String operation) throws SQLException {
    try {
      if (operation.equals("add")) {
        System.out.println("Enter College Name:");
        String name = scanner.nextLine();
        System.out.println("Enter Street Number:");
        String number = scanner.nextLine();
        System.out.println("Enter Street Name:");
        String stname = scanner.nextLine();
        System.out.println("Enter City:");
        String city = scanner.nextLine();
        System.out.println("Enter State(2 characters):");
        String state = scanner.nextLine();
        System.out.println("Enter zipcode(5 digits):");
        String zip = scanner.nextLine();

        CallableStatement cs = connection.prepareCall("{call add_college(?,?,?,?,?,?)}");
        cs.setString(1, name);
        cs.setString(2, number);
        cs.setString(3, stname);
        cs.setString(4, city);
        cs.setString(5, state);
        cs.setString(6, zip);
        cs.execute();
        System.out.println("Record successfully added to the database");
        waitForInput();
        cs.close();

      } else if (operation.equals("update")) {
        System.out.print("Enter the ID of the college to be updated:");
        int id = scanner.nextInt();
        scanner.nextLine();
        System.out.print("Enter New College Name:");
        String name = scanner.nextLine();
        CallableStatement cs = connection.prepareCall("{call update_college(?,?)}");
        cs.setInt(1, id);
        cs.setString(2, name);
        cs.executeUpdate();
        System.out.println("College name successfully updated.");
        waitForInput();
        cs.close();
      } 
    } catch (SQLException e) {
      if (e.getSQLState().equals("45000")) {
        System.out.println(e.getMessage());
      } else {
        System.out.println("Error performing operation on college table");
      }
    }

  }


  private void placeHoldOnStudent(String operation) throws SQLException {
    System.out.println("Enter the student ID if the student you want to " + operation + " hold on");
    Scanner scanner = new Scanner(System.in);
    int studentID = scanner.nextInt();

    try {
      String sql = "{ ? = CALL place_remove_hold_on_student(?, ?) }";
      CallableStatement callableStatement = connection.prepareCall(sql);

      callableStatement.registerOutParameter(1, Types.BOOLEAN);

      callableStatement.setInt(2, studentID);
      callableStatement.setString(3, operation);

      callableStatement.execute();

      boolean result = callableStatement.getBoolean(1);

      if (result) {
        String display = operation.equals("place_hold") ? "Hold placed" : "Hold removed";
        System.out.println(display + " on student with ID: " + studentID);
      } else {
        System.out.println("Failed to " + operation + " hold on student with ID: " + studentID);
      }

      waitForInput();
      callableStatement.close();

    } catch (SQLException e) {
      if (e.getSQLState().equals("45000")) {
        System.out.println(e.getMessage());
      } else {
        System.out.println("Error performing hold operations!");
      }
    }
  }

  private void getStudents() throws SQLException {
    try {
      PreparedStatement ps = connection.prepareStatement("select student_id,name,level,hold " +
              "from student");
      ResultSet rs = ps.executeQuery();
      table.populateTable(rs);
      waitForInput();
      ps.close();
      rs.close();
    } catch (SQLException e) {
      System.out.println("Error retrieving student details!");
    }
  }

  private void getCollege() throws SQLException {
    try {
      PreparedStatement ps = connection.prepareStatement("select * from college");
      ResultSet rs = ps.executeQuery();
      table.populateTable(rs);
      waitForInput();
      ps.close();
      rs.close();
    } catch (SQLException e) {
      System.out.println("Error retrieving college details!");
    }
  }

  private void getCourse() throws SQLException {
    try {
      PreparedStatement ps = connection.prepareStatement("CALL get_course_details()");
      ResultSet rs = ps.executeQuery();
      table.populateTable(rs);
      waitForInput();
      ps.close();
      rs.close();
    } catch (SQLException e) {
      System.out.println("Error retrieving course details!");
    }
  }

  private void waitForInput() {
    System.out.print("Hit enter to continue...");
    Scanner scanner = new Scanner(System.in);
    scanner.nextLine();
  }

  private Boolean isValidUser(String email, String password, String type) throws SQLException {
    boolean isValidUser = false;
    try {
      String studentName = "{ ? = CALL is_valid_user(?,?,?) }";
      CallableStatement cs = connection.prepareCall(studentName);
      cs.registerOutParameter(1, Types.BOOLEAN);
      cs.setString(2, email);
      cs.setString(3, password);
      cs.setString(4, type);

      cs.execute();

      isValidUser = cs.getBoolean(1);

      cs.close();

    } catch (SQLException e) {
      if (e.getSQLState().equals("45000")) {
        System.out.println(e.getMessage());
      } else {
        System.out.println("Error performing operation on college table");
      }
    }
    return isValidUser;
  }

  private void updatePassword(String email, String type) throws SQLException {
    try {
      System.out.println("Enter your current password:");
      String old_password = scanner.nextLine();
      System.out.println("Enter your new password:");
      String new_password = scanner.nextLine();

      String pass = "{CALL update_password(?,?,?,?) }";
      CallableStatement cs = connection.prepareCall(pass);
      cs.setString(1, email);
      cs.setString(2, old_password);
      cs.setString(3, new_password);
      cs.setString(4, type);

      cs.execute();

      System.out.println("Password updated successfully!");
      waitForInput();
      cs.close();

    } catch (SQLException e) {
      if (e.getSQLState().equals("45000")) {
        System.out.println(e.getMessage());
      } else {
        System.out.println("Error updating password.");
      }
    }

  }
  
  private void exit() throws SQLException {
    try {
      connection.close();
      System.exit(0);
    } catch (SQLException e) {
      System.out.println("Error closing connection");
    }
  }
}
