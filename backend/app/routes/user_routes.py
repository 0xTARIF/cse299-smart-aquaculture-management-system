from fastapi import APIRouter, HTTPException
from app.db.database import SessionLocal
from app.models.user_model import User
from fastapi import Body

router = APIRouter()

@router.get("/user/{user_id}")
def get_user(user_id: str):
    db = SessionLocal()
    
    user = db.query(User).filter(User.id == user_id).first()
    
    if not user:
        raise HTTPException(status_code=404, detail="User not found")

    return {
        "id": user.id,
        "name": user.name,
        "email": user.email,
        "phone": user.phone,
        "about": user.about,
        "experience": user.experience
    }

@router.put("/user/{user_id}")
def update_user(user_id: str, data: dict = Body(...)):
    db = SessionLocal()

    user = db.query(User).filter(User.id == user_id).first()

    if not user:
        raise HTTPException(status_code=404, detail="User not found")

    # Update fields safely
    if "phone" in data:
        user.phone = data["phone"]

    if "about" in data:
        user.about = data["about"]

    if "experience" in data:
        user.experience = data["experience"]

    if "name" in data:
        user.name = data["name"]

    db.commit()
    db.refresh(user)

    return {
        "message": "User updated successfully",
        "user": {
            "id": user.id,
            "phone": user.phone,
            "about": user.about,
            "experience": user.experience,
        }
    }