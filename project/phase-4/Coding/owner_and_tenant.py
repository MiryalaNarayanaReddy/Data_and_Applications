from datetime import date, datetime, time
import pymysql 
import pymysql.cursors
import pandas as pd

def insert_new_owner(cur,con):
    new_owner = {}
    new_owner['Owner_name'] = input('Owner name: ')
    new_owner['Block_name'] = input('Block_name')
    new_owner['Apartment_number'] = input('Apartment_number')
    new_owner['Email_id'] = input('Email_id')
    new_owner['Owner_since'] = input('Owner_since')
    # new_owner['Owner_since'] = datetime.now().strftime("%Y-%M-%D %H:%M:%S")

    # creation of owner_id
    query = f"SELECT Owner_id FROM APARTMENT WHERE Apartment_number = {new_owner['Apartment_number']} and Block_name = '{new_owner['Block_name']}';"
   
   # print(query)
    try:
        cur.execute(query)
        con.commit()
        result = cur.fetchone()
        new_owner['owner_id'] = int(new_owner['Owner_since'][0:4] + new_owner['Apartment_number'])*100+(result['Owner_id']%100+1)
    except Exception as e:
        print(e)
        new_owner['owner_id'] = int(new_owner['Owner_since'][0:4] + new_owner['Apartment_number'])*100 +1
    print(new_owner['owner_id'])


def remove_owner(cur,con):
    Block_name = input("Block_name: ")
    Apartment_number = input("Apartment_number: ")
    try:
        query = f"SELECT Owner_id FROM APARTMENT WHERE Block_name = '%s' and Apartment_number = %s"%( Block_name, Apartment_number)
        cur.execute(query)
        con.commit()
        owner_id = cur.fetchone()
       # print(owner_id['Owner_id'])
        query  = f"SELECT * FROM OWNERS WHERE Owner_id = %s"%(owner_id['Owner_id'])
        try:
            cur.execute(query)
            con.commit()
            result = cur.fetchone()
            d = datetime.now()
            dt = f"%d-%d-%d %d:%d:%d"%(d.year,d.month,d.day,d.hour,d.minute,d.second)
            print(dt)
            # print(result)
            query = f"INSERT INTO OWNERSHIP_HISTORY VALUES ('%s',%d,'%s','%s','%s','%s')"%(result['Owner_name'],owner_id['Owner_id'],Block_name,result['Email_id'],result['Owner_since'], dt)
            
            # print(query)
            cur.execute(query)
            con.commit()
            query = f"DELETE FROM APARTMENT,OWNER WHERE Owner_id = %d"%(owner_id['Owner_id'])
            cur.execute(query)
            con.commit()
            query = f"DELETE FROM OWNERS WHERE Owner_id = %d"%(owner_id['Owner_id'])
            cur.execute(query)
            con.commit()
        
        except Exception as e:
            print(e)
    except Exception as e:
        print(e)
    return

    
def list_owners_and_their_emails(cur,con):
    Block_name = input("Block name: ")
    query = f"SELECT Owner_name, Email_id FROM OWNERS where Block_name = '%s' "%(Block_name)
    try:
        cur.execute(query)
        con.commit()
        # print("Name","\t\t\t","Email_id")
        result =  cur.fetchall()
        # for item in result:
        #     print(item['Owner_name'],"\t\t",item['Email_id'])

        print(pd.DataFrame(result))


    except Exception as e:
        print(e)
    return

def apartments_with_tenants(cur,con):
    try:
        query = f"SELECT Block_name,Apartment_number FROM TENANT"
        cur.execute(query)
        con.commit()
        result = cur.fetchall()
        print("Block_name","\t","Apartment_number")
        for r in result:
            print(r['Block_name'],r['Apartment_number'])
    except Exception as e:
        print(e)
    return

def apartments_without_tenants(cur,con):
    try:
        query = f"SELECT a.Block_name, a.Apartment_number FROM APARTMENT a  LEFT JOIN TENANT t ON a.Owner_id  = t.Owner_id WHERE t.Owner_id IS NULL"
        cur.execute(query)
        con.commit()
        result = cur.fetchall()

        print("Block_name","\t","Apartment_number")
        for r in result:
            print(r['Block_name'],"\t\t",r['Apartment_number'])
    except Exception as e:
        print(e)

