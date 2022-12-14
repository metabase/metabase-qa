import sqlite3, pathlib, gzip

def create_database_and_output():
    """
    Creates a database file for SQLite.

    """
    try: 
        pathlib.Path('sample_data.db').unlink()
    except:
        print(f'sqlite database non-existent, creating new')
    finally:
        pathlib.Path('sample_data.db').touch()

def connect():
    """
    Instantiates a connection and a cursor.

    Returns
    -------
    none

    Raises
    ------
    Exception
        If the script cannot connect to the database for some odd reason (as it is on the same directory).
    """
    try:
        con = sqlite3.connect('sample_data.db')
        cur = con.cursor()
        file = gzip.open('data/sample_data.sql.gz', 'rb')
        syntax = file.read()
        syntax = syntax.decode('utf-8')
        cur.executescript(syntax)
        file.close()
        con.close()
    except Exception:
        error = 'Could not connect to database'
        log_error(error)
        raise

def log_step(step):
    """
    A function that logs steps in the flow

    Parameters
    ----------
    step: str
        a step in the process
    """
    print(f"{step} went fine")

def log_error(error):
    """
    A function that logs errors in the process

    Parameters
    ----------
    error: str
        an error in the process
    """
    print (f"{error}")

def start():
    try:
        step = '1. Creating databases'
        log_step(step)
        create_database_and_output()
    
        step = '2. Connecting to SQLite'
        connect()
        log_step(step)
    except Exception:
        error = 'something happened on the way'
        log_error(error)
        raise

if __name__ == '__main__':
    start()