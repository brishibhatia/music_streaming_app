from server.database.database import engine, get_db
from fastapi import FastAPI
from server.models.base import Base
from server.routes import auth

app = FastAPI()
app.include_router(auth.router)
Base.metadata.create_all(bind=engine)