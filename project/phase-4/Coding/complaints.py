from datetime import date, datetime, time
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
            print(i,"\n")
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
        query = f"INSERT INTO COMPLAINT VALUES ('%s',%s,%d,'%s','%s','%s','%s','%s')"%(Block_name,Apartment_number,Complaint_number,Complainant,Complaint,Lodge_time,"pending",Complaint_type)
        cur.execute(query)
        con.commit()
        return
    except Exception as e:
        print(e)


# Block_name: C    
# Apartment_number: 204
# Complainant: Gopal
# Complaint_type: Electrical
# Comaplaint: Fan in bed room stopped working
# not enough arguments for format string