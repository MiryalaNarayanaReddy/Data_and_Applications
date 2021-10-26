# Running
**run dump.sql**
        
        - by pasting the code in mysql terminal
        or
        - by using mysql workbench and connecting the 
        database
**Run main.py**
        
        - connect to the same database used by you above

# sequence of commands used in video and supported by this program

## 2 list all owners and their email_ids
    - lists owners with their apartment numbers and email_ids

## 3 remove owner
    - remove an owner
    - removes owner from both APARTMENT and OWNERS tables and adds it to OWNERSHIP_HISTORY

## 1 new owner
    - add a new owner to the database
    - changes 
        - Apartment table
        - Owners table

## 4 list all apartments with tenants
    - gives a list of all apartments with tenants
    - uses left join

## 5 list all apartments without tenants
    - gives list of apartments which are not rented by tenants

## 6 Lodge complaint
    - add a complaint in COMPLAINT table

## 7 show complaints
    - lists all the complaints which are not resolved completely in COMPLAINT table

## 8 Update complaint status
    - update complaint status in COMPLAINT table

## 9 remove a complaint
    - remove a complaint in COMPLAINT table and insert it into COMPLAINTS_HISTORY

## 10 add this months expenditure
    - compute this months expenditure from EXPENDITURE table and inserts it into ACCOUNTS table along with income
 
## 11 show accounts analysis
    - plots a graph with income and expenditure of every month

## 12 Add a visitor
    - adds a visitor to VISITORS table

## 13 list all apartments with pending MMC
    - lists all apartments who did not pay mmc upto end of this month

## 14 update mmc paid upto date
    - updates mmc paid_upto date in MMC table

## 0 exit
    - exits from the code
