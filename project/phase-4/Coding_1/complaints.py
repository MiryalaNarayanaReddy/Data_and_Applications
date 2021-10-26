from datetime import date, datetime, time
from os import execle
import pymysql 
import pymysql.cursors
import date_time as dt

def show_complaints(cur,con):
    try:
        query = f"SELECT * FROM COMPLAINT"
        cur.execute(query)
        con.commit()
        result = cur.fetchall()
        for i in result:
            print("Complaint_number :",i['Complaint_number'])
            print("\n")
            print("Block_name       : ",i['Block_name'])
            print("Apartment_number : ",i['Apartment_number'])
            print("Complainant      : ",i['Complainant'])
            print("Complaint        : ",i['Complaint'])
            print("Lodge_time       : ",i['Lodge_time'])
            print("Complaint_status : ",i['Complaint_status'])
            print("Complaint_type   : ",i['Complaint_type'])
            print("\n")
            print("-------")
    except Exception as e:
        print(e)
    return


def get_compaint_num(cur,con):
    try:
        query = f"SELECT MAX(Complaint_number) as cn FROM COMPLAINT"
        cur.execute(query)
        con.commit()
        complaint_num1 = cur.fetchone()
        query = f"SELECT MAX(Complaint_number) as cn FROM COMPLAINT_HISTORY"
        cur.execute(query)
        con.commit()
        complaint_num2 = cur.fetchone()
    
        complaint_num1 = complaint_num1['cn']
        complaint_num2 = complaint_num2['cn']

        return max(complaint_num1,complaint_num2)+1
    except Exception as e:
        print(e)

def lodge_complaint(cur,con):
    Block_name = input("Block_name: ")
    Apartment_number = input("Apartment_number: ")
    Complainant = input("Complainant: ")
    Complaint_type = input("Complaint_type: ")
    Complaint = input("Comaplaint: ")
    Lodge_time  = dt.date_time_now()
    Complaint_status = "Pending"
    Complaint_number = get_compaint_num(cur,con)
    # print(Complaint_number)
    try:
        query = f"INSERT INTO COMPLAINT VALUES ('%s',%s,%d,'%s','%s','%s','%s','%s')"%(Block_name,Apartment_number,Complaint_number,Complainant,Complaint,Lodge_time,Complaint_status,Complaint_type)
        cur.execute(query)
        con.commit()
        return
    except Exception as e:
        print(e)

def update_complaint_status(cur,con):
    try:
        complaint_number = input("Comalaint_number: ")
        complaint_status = input("New complaint status: ")
        query=f"UPDATE COMPLAINT SET Complaint_status = '%s' WHERE Complaint_number = %s"%(complaint_status,complaint_number)
        cur.execute(query)
        con.commit()
    except Exception as e:
        print(e)


# Block_name: C    
# Apartment_number: 204
# Complainant: Gopal
# Complaint_type: Electrical
# Comaplaint: Fan in bed room stopped working
# not enough arguments for format string