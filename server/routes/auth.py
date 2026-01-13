    
from http.client import HTTPException
import uuid

import bcrypt
from server.database.database import get_db
from server.models.user import User
from fastapi import APIRouter  , Depends# type: ignore
from server.pydantic_schemas.user_create import UserCreate # pyright: ignore[reportMissingImports]
from sqlalchemy.orm import Session

from server.pydantic_schemas.user_login import UserLogin

router = APIRouter(prefix="/auth", tags=["Auth"])




@router.post('/signup' , status_code = 201)
def signup_user(user:UserCreate , db : Session= Depends(get_db)):
    #extract the data that is coming from the request
    #check if the user exists in the db 
    user_db = db.query(User).filter(User.email == user.email).first()
    if  user_db:
        raise HTTPException(400, 'User does  exist with the same email')
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

@router.post('/login')
def login_user(user : UserLogin ,  db : Session= Depends(get_db)):
    user_db = db.query(User).filter(User.email == user.email).first()
   
    if not user_db :
     raise HTTPException(400, 'User with this email does not exist')
    
    is_match = bcrypt.checkpw(user.password.encode() , user_db.password)
    
    if not is_match :
     raise HTTPException(400, 'password is wrong')
    return user_db

    
   