
import mysql.connector
from mysql.connector import Error

def test_connection():
    try:
        
        connection = mysql.connector.connect(
            host='localhost',
            user='nezam', 
            password='nezam123@#$',
            database='banking_system'
        )
        
        if connection.is_connected():
            db_info = connection.get_server_info()
            print(f"Connected to MySQL Server version {db_info}")
            
           
            cursor = connection.cursor()
            
          
            cursor.execute("SELECT COUNT(*) FROM customers")
            result = cursor.fetchone()
            print(f"Total customers in database: {result[0]}")
            
           
            cursor.execute("SELECT COUNT(*) FROM accounts")
            result = cursor.fetchone()
            print(f"Total accounts in database: {result[0]}")
            
    except Error as e:
        print(f"Error connecting to MySQL: {e}")
    finally:
        if 'connection' in locals() and connection.is_connected():
            cursor.close()
            connection.close()
            print("MySQL connection is closed")

if __name__ == "__main__":
    print("Testing connection to Banking System database...")
    test_connection()
