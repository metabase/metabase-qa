import docker, shutil, sqlite3, gzip, os, sys, pathlib

# This code might be the most horrible one you've ever seen, but works! all the focus was put into building 
# the dockerfiles to have more databases to test on :D

client = docker.from_env()

def build_image(database, version):
    image = f"{database}/{version}"
    print (f"starting to build {image}")
    if database == 'sqlite':
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
    else:
        step = '1. Moving data'
        log_step(step)
        move_data(f"dbs/{database}/data/", f"dbs/{image}/")
        step = '2. Building image'
        log_step(step)
        client.images.build(path=f"dbs/{image}/", tag=f"qa-databases:{database}-sample-{version}", forcerm=True)
        step = '3. Releasing data'
        log_step(step)
        move_data(f"dbs/{image}/", f"dbs/{database}/data/")
    print (f"finished building {image}")

def move_data(source, dest):
    file_names = os.listdir(source)
    for file_name in file_names:
        if file_name != 'Dockerfile':
            shutil.move(os.path.join(source, file_name), dest)

def create_database_and_output():
    """
    Creates a database file for SQLite.

    """
    try: 
        pathlib.Path('dbs/sqlite/sample_data.db').unlink()
    except:
        print(f'sqlite database non-existent, creating new')
    finally:
        pathlib.Path('dbs/sqlite/sample_data.db').touch()

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
        con = sqlite3.connect('dbs/sqlite/sample_data.db')
        cur = con.cursor()
        file = gzip.open('dbs/sqlite/data/sample_data.sql.gz', 'rb')
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
    if len(sys.argv) == 1:
        print("let's build all images and all versions")
        for images in available_versions:
                for versions in available_versions[images]:
                    build_image(images, versions)
    else: 
        if len(sys.argv) == 2:
            print("let's build all versions of an image")
            for versions in available_versions[sys.argv[1]]:
                build_image(sys.argv[1], versions)
        else:
            print(f"let's build version {sys.argv[2]} of {sys.argv[1]}")
            build_image(sys.argv[1], sys.argv[2])

available_versions = {
    "postgres": {
        11,
        12,
        13
    },
    "mysql": {
        5.7,
        8
    },
    "mssql": {
        2017,
        # 2019
    },
    "sqlite": {
        0
    }
}

if __name__ == '__main__':
    start()