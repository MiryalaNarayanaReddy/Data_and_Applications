import pymysql 
import subprocess as sp
import pymysql.cursors
import complaints 
import owner_and_tenant as oats
import accounts
import visitors

def dispatch(ch,cur,con):
    """
    Function that maps helper functions to option entered
    """

    if ch == 1:
       oats.insert_new_owner(cur,con)
    elif ch==2:
        oats.list_owners_and_their_emails(cur,con)
    elif ch == 3:
        oats.remove_owner(cur,con)
    elif ch == 4:
        oats.apartments_with_tenants(cur,con)
    elif ch ==5 :
        oats.apartments_without_tenants(cur,con)
    elif ch == 6:
        complaints.lodge_complaint(cur,con)
    elif ch == 7:
        complaints.show_complaints(cur,con)
    elif ch == 8:
        complaints.update_complaint_status(cur,con)
    elif ch ==9:
        complaints.remove_comaplaint(cur,con)
    elif ch == 10:
        accounts.add_this_months_expenditure(cur,con)
    elif ch == 11:
        accounts.show_accounts_analysis(cur,con)
    elif ch == 12:
        visitors.add_vistor(cur,con)
    elif ch == 13: 
        accounts.list_apartments_with_pending_mmc(cur,con)
    elif ch ==14:
        accounts.update_mmc_paid_upto_date(cur,con)
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
                print("________________________________\n")
                print("0. exit")
                print('1 new_owner') 
                print('2 list owners and email ids')
                print('3 remove an owner')
                print('4 list all apartments with tenants')
                print('5 list all apartments without tenants')
                print('6 Lodge compalaint')
                print('7 show compaliants')
                print('8 update complaint status')
                print('9 remove a complaint')
                print('10 add this months expenditure')
                print('11 show accounts analysis')
                print('12 Add a visitor')
                print('13 list all apartments with pending MMC')
                print('14 update_mmc_paid_upto_date')
                ch = input("\nEnter choice> ")
                # tmp = sp.call('clear', shell=True)
                print("---------------------------------\n")
                if ch == '0':
                    exit()
                elif ch == '' :
                    continue
                elif ch == 'clear':
                    tmp = sp.call('clear', shell=True)
                else:
                    dispatch(int(ch),cur,con)

    except Exception as e:
        tmp = sp.call('clear', shell=True)
        print(e)
        print("Connection Refused: Either username or password is incorrect or user doesn't have access to database")
