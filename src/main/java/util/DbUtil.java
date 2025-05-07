// src/main/java/util/DbUtil.java
package util;

import java.sql.*;

public class DbUtil {
    private static final String URL  = "jdbc:postgresql://localhost:5432/webappdb";
    private static final String USER = "webuser";
    private static final String PASS = "securepass123";

    static {
        try { Class.forName("org.postgresql.Driver"); }
        catch (ClassNotFoundException e) { throw new RuntimeException(e); }
    }

    public static Connection getConn() throws SQLException {
        return DriverManager.getConnection(URL, USER, PASS);
    }
}
