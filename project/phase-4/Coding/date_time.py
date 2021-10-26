from datetime import date, datetime, time

def date_time_now():
    d = datetime.now()
    dt = d.strftime("%Y-%m-%d %H:%M:%S")
    # dt = f"%d-%d-%d %d:%d:%d"%(d.year,d.month,d.day,d.hour,d.minute,d.second)
    return dt

def date_now():
    d = datetime.now()
    dt = d.strftime("%Y-%m-%d")
    # dt = f"%d-%d-%d %d:%d:%d"%(d.year,d.month,d.day,d.hour,d.minute,d.second)
    return dt
