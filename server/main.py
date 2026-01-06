from database import engine
from fastapi import FastAPI # pyright: ignore[reportMissingImports]
from server.models.base import Base
from server.routes import auth  # pyright: ignore[reportMissingImports]


app = FastAPI()

app.include_router(auth.router, )

Base.metadata.create_all(bind=engine)
    



