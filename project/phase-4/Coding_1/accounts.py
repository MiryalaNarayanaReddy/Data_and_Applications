from datetime import date, datetime, time
import pymysql 
import pymysql.cursors
import date_time as dt
import numpy as np
import matplotlib.pyplot as plt

def show_accounts_analysis(cur,con):
    query = f"SELECT *FROM ACCOUNTS"
    cur.execute(query)
    con.commit()
    result = cur.fetchall()
    print(result)
    barwidth = 0.25
    a_date = []
    a_income = []
    a_expenditure = []
    for r in result:
        a_date.append(r['Period'])
        a_income.append(r['Income'])
        a_expenditure.append(r['Total_expenditure'])
    
    print(a_date)
    print(a_income)
    print(a_expenditure)

    x = np.arange(len(a_date))
    width = 0.2

    plt.bar(x-0.1,a_income,width,color='orange',label='Income')
    plt.bar(x+0.1,a_expenditure,width,color='blue',label='Expenditure')
    plt.xticks(x,a_date)
    plt.xlabel('Date')
    plt.ylabel('amount in rupee')
    plt.legend()
    plt.show()

def show_expediture_analysis(cur,con):
    query=f"SELECT *FROM EXPEDITURE "
    cur.execute(query)
    con.commit()
    print(query)


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
        query = f"SELECT COUNT(Committee_id) as id FROM ACCOUNTS"
        cur.execute(query)
        con.commit()
        result = cur.fetchone()
        id = result['id']+1
    except Exception as e:
        print(e)
        return
    try:
        query = f"INSERT INTO ACCOUNTS VALUES (%d,'%s',%f,%f)"%(id,dt.date_now(),get_this_months_income(cur,con),expenditure)
        # print(query)
        cur.execute(query)
        con.commit()
    except Exception as e:
        print(e)
        return
    return