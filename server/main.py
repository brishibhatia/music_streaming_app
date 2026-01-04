from fastapi import FastAPI  # pyright: ignore[reportMissingImports]
from pydantic import BaseModel # pyright: ignore[reportMissingImports]
from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker

app = FastAPI()
DATABASE_URL = 'postgresql://postgress:root@localhost:5433/fluttermusicapp'    
engine = create_engine(DATABASE_URL)
SessionLocal = sessionmaker(autocommit = False , autoflush=False, bind=engine)

db = SessionLocal()

class UserCreate(BaseModel):
    name : str
    email : str
    password: str

@app.post('/signup')
def signup_user(user:UserCreate):
    #extract the data that is coming from the request
    #check if the user exists in the db 
    #create a new user in db 
    print(user.name)
    return '$user.name'
    
    pass



