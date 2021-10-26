from datetime import date, datetime, time
from os import EX_CANTCREAT
import pymysql 
import pymysql.cursors
import date_time as dt
import numpy as np
import matplotlib.pyplot as plt
import pandas as pd

def show_accounts_analysis(cur,con):
    query = f"SELECT *FROM ACCOUNTS"
    cur.execute(query)
    con.commit()
    result = cur.fetchall()
    # print(result)
    barwidth = 0.25
    a_date = []
    a_income = []
    a_expenditure = []
    for r in result:
        a_date.append(r['Period'])
        a_income.append(r['Income'])
        a_expenditure.append(r['Total_expenditure'])
    
    # print(a_date)
    # print(a_income)
    # print(a_expenditure)

    x = np.arange(len(a_date))
    width = 0.2

    plt.bar(x-0.1,a_income,width,color='orange',label='Income')
    plt.bar(x+0.1,a_expenditure,width,color='blue',label='Expenditure')
    plt.xticks(x,a_date)
    plt.xlabel('Date')
    plt.ylabel('amount in rupee')
    plt.legend()
    plt.show()

# def show_expediture_analysis(cur,con):
#     query=f"SELECT *FROM EXPEDITURE "
#     cur.execute(query)
#     con.commit()
#     # print(query)


def get_this_months_income(cur,con):
    query = f"SELECT SUM(Monthly_maintenance_charges) as income FROM APARTMENT"
    # print(query)
    cur.execute(query)
    con.commit()
    result = cur.fetchone()
    return result['income']


def add_this_months_expenditure(cur,con):
    try:
        query = f"SELECT SUM(Amount_spent) as expenditure FROM EXPENDITURE WHERE month(Transaction_time) = %d"%(datetime.now().month)
        # print(query)
        cur.execute(query)
        con.commit()
        result = cur.fetchone()
        expenditure = result['expenditure']
    except Exception as e:
        print(e)
        return
    # print(result)
    try:
        query = f"SELECT MAX(Committee_id) as id FROM ACCOUNTS"
        cur.execute(query)
        con.commit()
        result = cur.fetchone()
        id = result['id']

        try:
            query = f"INSERT INTO ACCOUNTS VALUES (%d,'%s',%f,%f)"%(id,dt.date_now(),get_this_months_income(cur,con),expenditure)
            # print(query)
            cur.execute(query)
            con.commit()
        except Exception as e:
            print(e)
            return
    
    except Exception as e:
        print(e)
        return
    return


def list_apartments_with_pending_mmc(cur,con):
    try:
        query = f"SELECT * FROM MMC WHERE paid_upto < '%s'"%(dt.date_now())
        cur.execute(query)
        con.commit()
        result = cur.fetchall()
        t = pd.DataFrame(result) # make table
        t = t.to_string(index=False) # remove indexing
        print(t)
    except Exception as e:
        print(e)


def update_mmc_paid_upto_date(cur,con):
    try:
        Block_name = input("Block name : ")
        Apartment_number = input("Apartment number: ")
        paid_upto = input("Paid upto: ")

        query = f"UPDATE MMC SET paid_upto = '%s' WHERE Block_name = '%s' and Apartment_number = '%s'"%(paid_upto,Block_name,Apartment_number)

        cur.execute(query)
        con.commit()
    except Exception as e:
        print(e)


