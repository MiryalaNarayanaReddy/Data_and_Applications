from datetime import date, datetime, time
import pymysql 
import pymysql.cursors
import date_time as dt

def add_vistor(cur,con):
    try:
        name = input("Name: ")
        phno = input("phno: ")
        purpose = input("Purpose: ")
        query = f"INSERT INTO VISITOR (Visitor_name, Visit_time, Vistor_phno, Purpose) VALUES ('%s','%s','%s','%s')"%(name,dt.date_time_now(),phno,purpose)
        cur.execute(query)
        con.commit()
    except Exception as e:
        print(e)
