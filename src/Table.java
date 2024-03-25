import javax.swing.*;
import javax.swing.table.DefaultTableModel;
import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.sql.*;
import java.util.Vector;

public class Table extends JFrame {
  private JTable table;
  private DefaultTableModel tableModel;
  private JDialog dialog;

  public Table() {
    initializeUI();
    //dialog.setVisible(true);
  }

  private void initializeUI() {
    setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
    setTitle("Dynamic JTable Example");
    setSize(600, 400);

    tableModel = new DefaultTableModel();
    table = new JTable(tableModel);

    JScrollPane scrollPane = new JScrollPane(table);
    getContentPane().add(scrollPane, BorderLayout.CENTER);
  }

  public void populateTable(ResultSet resultSet) {
    try {
      ResultSetMetaData metaData = resultSet.getMetaData();
      int columnCount = metaData.getColumnCount();

      // Clear existing columns and rows
      tableModel.setColumnCount(0);
      tableModel.setRowCount(0);

      // Add columns to the table model
      for (int i = 1; i <= columnCount; i++) {
        tableModel.addColumn(metaData.getColumnName(i));
      }

      // Add rows to the table model
      while (resultSet.next()) {
        Vector<Object> row = new Vector<>();
        for (int i = 1; i <= columnCount; i++) {
          row.add(resultSet.getObject(i));
        }
        tableModel.addRow(row);
      }

      // Create and display the dialog without using SwingUtilities.invokeLater
      JDialog dialog = new JDialog(this, "Table Data", true);
      dialog.setSize(600, 300);

      JButton closeButton = new JButton("Close");
      closeButton.addActionListener(e -> {
        // Close the dialog
        dialog.dispose();
      });

      dialog.setLayout(new BorderLayout());
      dialog.add(new JScrollPane(new JTable(tableModel)), BorderLayout.CENTER);
      dialog.add(closeButton, BorderLayout.SOUTH);

      // Make the JFrame visible
      dialog.setAlwaysOnTop(true);
      this.requestFocusInWindow();
      dialog.setVisible(true);


    } catch (SQLException e) {
      System.out.println("Error displaying results in the table.");
    }
  }
}

