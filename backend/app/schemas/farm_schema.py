from pydantic import BaseModel
from typing import Optional


class FarmBase(BaseModel):
    name: str
    location: Optional[str] = None


class FarmResponse(FarmBase):
    id: str
    user_id: str

    class Config:
        from_attributes = True