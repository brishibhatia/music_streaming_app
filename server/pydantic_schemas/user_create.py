from pydantic import BaseModel # pyright: ignore[reportMissingImports]
class UserCreate(BaseModel):
    name : str
    email : str
    password: str