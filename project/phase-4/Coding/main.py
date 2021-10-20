import pymysql 
import subprocess as sp
import pymysql.cursors


import owner_and_tenant as oats

def dispatch(ch,cur,con):
    """
    Function that maps helper functions to option entered
    """

    if(ch == 1):
       oats.insert_new_owner(cur,con)
    else:
        print("invalid input")

    return


if __name__ == "__main__":
    tmp = sp.call('clear', shell=True)
    
    # Can be skipped if you want to hardcode username and password
    # username = input("Username: ")
    # password = input("Password: ")
    username = "my_dna"
    password = "password"
    try:
        # Set db name accordingly which have been create by you
        # Set host to the server's address if you don't want to use local SQL server 
        con = pymysql.connect(host='localhost',
                              port=30306,
                              user="root",
                              password=password,
                              db='APARTMENT_MANAGEMENT_SYSTEM',
                              cursorclass=pymysql.cursors.DictCursor)
        tmp = sp.call('clear', shell=True)

        if(con.open):
            print("Connected")
        else:
            print("Failed to connect")

        with con.cursor() as cur:
            while(1):
                # tmp = sp.call('clear', shell=True)
                print("0. exit")
                print('1 new_owner') 
                ch = int(input("Enter choice> "))
                # tmp = sp.call('clear', shell=True)
                if ch == 0:
                    exit()
                else:
                    dispatch(ch,cur,con)
                


    except Exception as e:
        tmp = sp.call('clear', shell=True)
        print(e)
        print("Connection Refused: Either username or password is incorrect or user doesn't have access to database")
