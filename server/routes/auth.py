    
from http.client import HTTPException
import uuid

import bcrypt
from server.models.user import User
from fastapi import APIRouter
from server.pydantic_schemas.user_create import UserCreate # pyright: ignore[reportMissingImports]

router  = APIRouter()



@router.post('/signup')
def signup_user(user:UserCreate):
    #extract the data that is coming from the request
    #check if the user exists in the db 
    user_db = db.query(User).filter(User.email == user.email).first()
    if  user_db:
        raise HTTPException(400, 'User does not exist with the same email')
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

   