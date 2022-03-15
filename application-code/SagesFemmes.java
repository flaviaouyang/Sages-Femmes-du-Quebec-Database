import java.sql.*;
import java.util.Scanner;
import java.util.ArrayList;

class SagesFemmes {
    // store all practitionerId into an arrayList
    static ArrayList<String> getAllPracIDs (Statement statement) throws SQLException{
        ArrayList<String> practIds = new ArrayList<String>();
        ResultSet pracRS = statement.executeQuery("SELECT practitionerID FROM Midwife");
        while (pracRS.next()) {
            practIds.add(pracRS.getString("practitionerID"));
        }
        pracRS.close();
        return practIds;
    }

    // exit if user input "E"
    static void checkToExit (String input, Statement statement, Connection con) throws SQLException {
        if (input.equals("E")) {
            statement.close();
            con.close();
            System.exit(0);
        }
    }

    // find all appointments on date
    static ResultSet findAppOnDate (String practitionerId, String date, Connection con, PreparedStatement ps) throws SQLException {
        ps.setString(1, practitionerId);
        ps.setDate(2, java.sql.Date.valueOf(date));
        ResultSet appRS = ps.executeQuery();
        return appRS;
    }

    // print out appointments on date
    static void displayApp (ResultSet appRS, ArrayList<Integer> appIDs, ArrayList<Integer> coupleIDs, ArrayList<Integer> pregNum, ArrayList<String> mname, ArrayList<String> mHealthNum, int count, String practitionerId) throws SQLException {
         // reset cursor
         appRS.beforeFirst();
        //  display
         while (appRS.next()) {
             // append data to arrayLists for later use
             appIDs.add(appRS.getInt("appointmentID"));
             coupleIDs.add(appRS.getInt("coupleID"));
             pregNum.add(appRS.getInt("pregnancyNum"));
 
             String time = appRS.getTime("time").toString();
             String backup = appRS.getString("backup");
             String isPrimary = "P";
             if (backup.equals(practitionerId)) {
                 isPrimary = "B";
             }
             String momName = appRS.getString("name");
             mname.add(momName);
             String RAMQ = appRS.getString("RAMQ");
             mHealthNum.add(RAMQ);
 
             System.out.println(count + "   " + time + "   " + isPrimary + "   " + momName + "   " + RAMQ);
             count++;
         }
    }

    // take appointment number from user
    static String getAppointmentNumber(Scanner scannerObj) {
        System.out.println("Enter the appointment number that you would like to work on.");
        System.out.print("[E] to exit [D] to go back to another date : ");
        String appNum = scannerObj.nextLine();
        return appNum;
    }

    // print option menu
    // return user's choice
    static int fiveOptions (String name, String healthNum, Scanner scannerObj) {
        System.out.println("For " + name + " " + healthNum);
        System.out.println();
        System.out.println("1. Review notes");
        System.out.println("2. Review tests");
        System.out.println("3. Add a note");
        System.out.println("4. Prescribe a test");
        System.out.println("5. Go back to the appointments.");
        System.out.println();
        System.out.print("Enter your choice: ");
        int decision = scannerObj.nextInt();
        System.out.println();
        return decision;
    }

    // get latest noteId from database
    static int getLastNoteId(Statement statement) throws SQLException{
        int last = 0;
        ResultSet rs = statement.executeQuery("SELECT observationID FROM Observation");
        while (rs.next()) {
            last = rs.getInt("observationID");
        }
        rs.close();
        return last;
    }

    // get latest observationId from database
    static int getLastTestId(Statement statement) throws SQLException{
        int last = 0;
        ResultSet rs = statement.executeQuery("SELECT testID FROM MedicalTest");
        while (rs.next()) {
            last = rs.getInt("testID");
        }
        rs.close();
        return last;
    }

    public static void main(String[] args) throws SQLException {
        int sqlCode = 0; // Variable to hold SQLCODE
        String sqlState = "00000"; // Variable to hold SQLSTATE

        // JDBC Driver Manager
        try {
            DriverManager.registerDriver(new com.ibm.db2.jcc.DB2Driver());
        } catch (Exception cnfe) {
            System.out.println("Class not found");
        }

        // your JDBC url
        // username, and password
        String url = null;
        String your_userid = null;
        String your_password = null;

        if (your_userid == null && (your_userid = System.getenv("SUSER")) == null) {
            System.err.println("Error!! do not have a password to connect to the database!");
            System.exit(1);
        }
        if (your_password == null && (your_password = System.getenv("PASSWORD")) == null) {
            System.err.println("Error!! do not have a password to connect to the database!");
            System.exit(1);
        }

        // connection and statement
        Connection con = DriverManager.getConnection(url, your_userid, your_password);
        Statement statement = con.createStatement();

        // all practitioner ids in a list
        ArrayList<String> practIds = getAllPracIDs(statement);

        // user input
        Scanner scannerObj = new Scanner(System.in);

        // take practitionerId from user
        System.out.print("Please enter your practitioner id [E] to exit: ");
        String practitionerId = scannerObj.nextLine();

        // if user practitionerId is not found in database
        // or if user input "E"
        while (!practIds.contains(practitionerId)) {
            // check if user wants to exit
            checkToExit(practitionerId, statement, con);

            System.out.println("Input practitioner ID does not exist in the database. Try again.");
            System.out.print("Please enter your practitioner id [E] to exit: ");
            practitionerId = scannerObj.nextLine();
        }

        // take appointment date
        System.out.print("Please enter the date for appointment list [E] to exit: ");
        String date = scannerObj.nextLine();

        // check if user wants to exit
        checkToExit(date, statement, con);

        // query for find app on date
        String findAppointments = "SELECT Appointment.time as time, Mother.mname as name, Mother.RAMQNum as RAMQ, Pregnancy.primaryPractitionerID as primary, Pregnancy.backupPractitionerID as backup, Appointment.appointmentID as appointmentID, Appointment.coupleID as coupleID, Appointment.pregnancyNum as pregnancyNum FROM Appointment LEFT JOIN Pregnancy ON Appointment.coupleID = Pregnancy.coupleID AND Appointment.pregnancyNum = Pregnancy.pregnancyNum LEFT JOIN Couple ON Pregnancy.coupleID = Couple.coupleID LEFT JOIN Mother ON Couple.RAMQNum = Mother.RAMQNum WHERE Appointment.practitionerID = ? AND Appointment.date = ?";
        // prepare statement
        PreparedStatement ps = con.prepareStatement(findAppointments, ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
        ResultSet appRS = findAppOnDate (practitionerId, date, con, ps);

        // check if appointments exist on this date
        while (!appRS.next()) {
            System.out.println("There are no recorded appointments on " + date + ". Try another date.");
            System.out.print("Please enter the date for appointment list [E] to exit: ");
            date = scannerObj.nextLine();
            checkToExit(date, statement, con);
            appRS = findAppOnDate (practitionerId, date, con, ps);
        }

        // store data in arrayLists
        ArrayList<Integer> appIDs = new ArrayList<Integer>();
        ArrayList<Integer> coupleIDs = new ArrayList<Integer>();
        ArrayList<Integer> pregNum = new ArrayList<Integer>();
        ArrayList<String> mname = new ArrayList<String>();
        ArrayList<String> mHealthNum = new ArrayList<String>();
        
        // label the printed entries
        int count = 1;
        // display
        displayApp(appRS, appIDs, coupleIDs, pregNum, mname, mHealthNum, count, practitionerId);
        // close resultSet and preparedStatement
        appRS.close();
        ps.close();
        System.out.println();

        // take appointment number to check for
        String appNum = getAppointmentNumber(scannerObj);

        // exit if user input "E"
        checkToExit(appNum, statement, con);

        // go back if user input "D"
        while (appNum.equals("D")) {
            System.out.print("Please enter the date for appointment list [E] to exit: ");
            date = scannerObj.nextLine();

            checkToExit(date, statement, con);

            ps = con.prepareStatement(findAppointments, ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
            appRS = findAppOnDate (practitionerId, date, con, ps);

            while (!appRS.next()) {
                System.out.println("There are no recorded appointments on " + date + ". Try another date.");
                System.out.print("Please enter the date for appointment list [E] to exit: ");
                date = scannerObj.nextLine();
                
                checkToExit(date, statement, con);

                appRS = findAppOnDate (practitionerId, date, con, ps);
            }

            count = 1;
            appIDs.clear();
            coupleIDs.clear();
            pregNum.clear();
            mname.clear();
            mHealthNum.clear();

            displayApp(appRS, appIDs, coupleIDs, pregNum, mname, mHealthNum, count, practitionerId);
            // close resultSet and preparedStatement
            appRS.close();
            ps.close();
            System.out.println();

            appNum = getAppointmentNumber(scannerObj);

            checkToExit(appNum, statement, con);
        }

        // user input an appointment number
        // parse user input appointment number into an int
        int appIndex = Integer.parseInt(appNum);
        // mother's name and RAMQ
        String name = mname.get(appIndex-1);
        String healthNum = mHealthNum.get(appIndex-1);

        int decision = fiveOptions(name, healthNum, scannerObj);

        while (true) {
            // review notes
            if (decision == 1) {
                int cid = coupleIDs.get(appIndex - 1);
                int pnum = pregNum.get(appIndex - 1);
                String getNotes = "SELECT Observation.date as date, Observation.time as time, SUBSTRING(content,1, 50) as content FROM Observation LEFT JOIN Appointment ON Observation.appointmentID = Appointment.appointmentID WHERE Appointment.coupleID = ? AND Appointment.pregnancyNum = ?";
                PreparedStatement notePS = con.prepareStatement(getNotes, ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
                notePS.setInt(1, cid);
                notePS.setInt(2, pnum);
                ResultSet noteRS = notePS.executeQuery();
    
                if (!noteRS.next()) {
                    System.out.println("There are no notes associated with this pregnancy.");
                }
    
                noteRS.beforeFirst();
                while (noteRS.next()) {
                    String dateNote = noteRS.getDate("date").toString();
                    String dateTime = noteRS.getTime("time").toString();
                    String content = noteRS.getString("content");
    
                    System.out.println(dateNote + "  " + dateTime + "  " + content);
                }

                notePS.close();
                noteRS.close();
                System.out.println();
                decision = fiveOptions(name, healthNum, scannerObj);
            }
    
            // review tests
            if (decision == 2) {
                int cid = coupleIDs.get(appIndex - 1);
                int pnum = pregNum.get(appIndex - 1);
                String getTest = "SELECT prescribedDate as date, type, SUBSTRING(result, 1, 50) as result FROM MedicalTest WHERE coupleID = ? AND pregnancyNum = ? ORDER BY prescribedDate DESC;";
                PreparedStatement testPS = con.prepareStatement(getTest, ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
                testPS.setInt(1, cid);
                testPS.setInt(2, pnum);
                ResultSet testRS = testPS.executeQuery();
    
                if (!testRS.next()) {
                    System.out.println("There are no tests associated with this pregnancy.");
                }
    
                testRS.beforeFirst();
                while (testRS.next()) {
                    String testDate = testRS.getDate("date").toString();
                    String type = testRS.getString("type");
                    String result = testRS.getString("result");
                    if (testRS.wasNull()) {
                        result = "PENDING";
                    }
                    System.out.println(testDate + "   [" + type + "]   " + result);
                }

                testPS.close();
                testRS.close();
                System.out.println();
                decision = fiveOptions(name, healthNum, scannerObj);
            }
    
            // add note
            if (decision == 3) {
                // get note from user
                System.out.print("Please type your observation: ");
                scannerObj.nextLine();
                String observation = scannerObj.nextLine();
    
                System.out.println("Note to add: " + observation);
    
                int aid = appIDs.get(appIndex -1);
                Date today =new Date(System.currentTimeMillis()); 
                Time now = new Time(System.currentTimeMillis());
                int nid = getLastNoteId(statement) + 1;
    
                String addNote = " INSERT INTO Observation (observationID, time, date, content, appointmentID) VALUES (?, ?, ?, ?, ?)";
                PreparedStatement addNotePS = con.prepareStatement(addNote);
                addNotePS.setInt(1, nid);
                addNotePS.setTime(2, now);
                addNotePS.setDate(3, today);
                addNotePS.setString(4, observation);
                addNotePS.setInt(5, aid);
                addNotePS.executeUpdate();

                addNotePS.close();
    
                System.out.println("Note added.");
                System.out.println();
                decision = fiveOptions(name, healthNum, scannerObj);
            }

            // prescribe test
            if (decision == 4) {
                // get type from user
                System.out.print("Please enter the type of test: ");
                scannerObj.nextLine();
                String type = scannerObj.nextLine();

                int tid = getLastTestId(statement) + 1;
                int cid = coupleIDs.get(appIndex - 1);
                int pnum = pregNum.get(appIndex - 1);
                Date today =new Date(System.currentTimeMillis()); 

                String addTest = "INSERT INTO MedicalTest (testID, type, labworkDate, prescribedDate, takenDate, result, practitionerID, pregnancyNum, coupleID, babyID, techID) VALUES (?, ?, NULL, ?, ?, NULL, ?, ?, ?, NULL, NULL)";
                PreparedStatement addTestPS = con.prepareStatement(addTest);
                addTestPS.setInt(1, tid);
                addTestPS.setString(2, type);
                addTestPS.setDate(3, today);
                addTestPS.setDate(4, today);
                addTestPS.setString(5, practitionerId);
                addTestPS.setInt(6, pnum);
                addTestPS.setInt(7, cid);
                addTestPS.executeUpdate();

                addTestPS.close();

                System.out.println("Test prescribed");
                System.out.println();
                decision = fiveOptions(name, healthNum, scannerObj);
            }

            // go back to appointments and loop
            if (decision == 5) {
                ps = con.prepareStatement(findAppointments, ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
                appRS = findAppOnDate (practitionerId, date, con, ps);
    
                count = 1;
                appIDs.clear();
                coupleIDs.clear();
                pregNum.clear();
                mname.clear();
                mHealthNum.clear();
    
                displayApp(appRS, appIDs, coupleIDs, pregNum, mname, mHealthNum, count, practitionerId);
    
                appRS.close();
                ps.close();
                System.out.println();
    
                System.out.println("Enter the appointment number that you would like to work on.");
                System.out.print("[E] to exit [D] to go back to another date : ");
                scannerObj.nextLine();
                appNum = scannerObj.nextLine();
                checkToExit(appNum, statement, con);
    
                // if appNum is "D"
                while (appNum.equals("D")) {
                    System.out.print("Please enter the date for appointment list [E] to exit: ");
                    date = scannerObj.nextLine();
        
                    checkToExit(date, statement, con);
        
                    ps = con.prepareStatement(findAppointments, ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
                    appRS = findAppOnDate (practitionerId, date, con, ps);
        
                    while (!appRS.next()) {
                        System.out.println("There are no recorded appointments on " + date + ". Try another date.");
                        System.out.print("Please enter the date for appointment list [E] to exit: ");
                        date = scannerObj.nextLine();
                        
                        checkToExit(date, statement, con);
        
                        appRS = findAppOnDate (practitionerId, date, con, ps);
                    }
        
                    count = 1;
                    appIDs.clear();
                    coupleIDs.clear();
                    pregNum.clear();
                    mname.clear();
                    mHealthNum.clear();
        
                    displayApp(appRS, appIDs, coupleIDs, pregNum, mname, mHealthNum, count, practitionerId);
                    // close resultSet and preparedStatement
                    appRS.close();
                    ps.close();
                    System.out.println();
        
                    appNum = getAppointmentNumber(scannerObj);
        
                    checkToExit(appNum, statement, con);
                }

                appIndex = Integer.parseInt(appNum);
                name = mname.get(appIndex-1);
                healthNum = mHealthNum.get(appIndex-1);
    
                decision = fiveOptions(name, healthNum, scannerObj);
            }
        }
    }
}
