from fastapi import FastAPI  # pyright: ignore[reportMissingImports]
from pydantic import BaseModel # pyright: ignore[reportMissingImports]
from sqlalchemy import TEXT, UUID, VARCHAR, Column, Integer, LargeBinary, create_engine
from sqlalchemy.orm import sessionmaker
from sqlalchemy.ext.declarative import declarative_base
import uuid 
import bcrypt

app = FastAPI()
DATABASE_URL = 'postgresql://postgres:root@localhost:5432/fluttermusicapp'    
engine = create_engine(DATABASE_URL)
SessionLocal = sessionmaker(autocommit = False , autoflush=False, bind=engine)

db = SessionLocal()

class UserCreate(BaseModel):
    name : str
    email : str
    password: str

Base = declarative_base()
class User(Base):
    __tablename__ = 'users'
    id = Column(UUID(as_uuid=True), primary_key=True, default=uuid.uuid4)
    name = Column(VARCHAR(100))
    email = Column(VARCHAR(100))
    password = Column(LargeBinary)

    



    
@app.post('/signup')
def signup_user(user:UserCreate):
    #extract the data that is coming from the request
    #check if the user exists in the db 
    user_db = db.query(User).filter(User.email == user.email).first()
    if  user_db:
        return 'User does not exist with the same email'
    #create a new user in db
    hashed_pwd = bcrypt.hashpw(user.password.encode("utf-8") ,salt=bcrypt.gensalt())
    user_db = User(id=str(uuid.uuid4()) , email = user.email , password = hashed_pwd , name= user.name )
    db.add(user_db)
    db.commit()
    db.refresh(user_db)
    return {
       "id": user_db.id,
        "name": user_db.name,
        "email": user_db.email
    }

    pass




Base.metadata.create_all(bind=engine)
    



