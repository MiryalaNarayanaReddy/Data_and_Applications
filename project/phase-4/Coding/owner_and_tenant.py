from datetime import datetime
import pymysql 
import pymysql.cursors

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
   
    print(query)
    try:
        cur.execute(query)
        con.commit()
        result = cur.fetchone()
        new_owner['owner_id'] = int(new_owner['Owner_since'][0:4] + new_owner['Apartment_number'])*100+(result['Owner_id']%100+1)
        
        # old_owner = {}
        # try:
        #     query = "SELECT * FROM APARTMENT WHERE Apartment_number = %d and Block_name = %s" %(new_owner['Apartment_number'],new_owner['Block_name'l])
        #     cur.execute(query)
        #     con.commit()
        # except Exception as f:
        #     print(f)

    except Exception as e:
        print(e)
        new_owner['owner_id'] = int(new_owner['Owner_since'][0:4] + new_owner['Apartment_number'])*100 +1
    print(new_owner['owner_id'])
    

