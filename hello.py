def run_lab_queries():
    try:
        connection = mysql.connector.connect(
            host='localhost',
            user='nezam', 
            password='nezam123@#$',
            database='banking_system'
        )
        
        if connection.is_connected():
            cursor = connection.cursor()
            
            # Read the SQL file
            with open('lab2_queries.sql', 'r') as file:
                sql_commands = file.read().split(';')
                
            # Execute each query
            for command in sql_commands:
                if command.strip():
                    print(f"Executing: {command[:50]}...")
                    cursor.execute(command)
                    if cursor.with_rows:
                        result = cursor.fetchall()
                        print(f"Results: {len(result)} rows")
            
            connection.commit()
            print("All queries executed successfully")
            
    except Error as e:
        print(f"Error: {e}")
    finally:
        if 'connection' in locals() and connection.is_connected():
            cursor.close()
            connection.close()
            print("MySQL connection is closed")

if __name__ == "__main__":
    run_lab_queries()
