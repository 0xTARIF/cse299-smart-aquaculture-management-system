from fastapi import APIRouter, Depends
from sqlalchemy.orm import Session
from typing import List

from app.db.database import get_db
from app.models.farm import Farm
from app.schemas.farm_schema import FarmResponse

router = APIRouter()


@router.get("/farms", response_model=List[FarmResponse])
def get_user_farms(user_id: str, db: Session = Depends(get_db)):
    farms = db.query(Farm).filter(Farm.user_id == user_id).all()
    return farms