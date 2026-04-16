from fastapi import APIRouter, Depends
from sqlalchemy.orm import Session
from datetime import datetime, timedelta

from app.db.database import get_db
from app.models.otp_model import OTP
from app.utils.otp import generate_otp
from app.utils.email_service import send_email

from app.models.user_model import User
from app.schemas.user_schema import UserCreate
from app.utils.hash import hash_password
from app.utils.hash import verify_password

from pydantic import BaseModel

router = APIRouter()


@router.post("/send-otp")
def send_otp(email: str, db: Session = Depends(get_db)):
    otp = generate_otp()

    expires = datetime.utcnow() + timedelta(minutes=5)

    otp_entry = OTP(
        email=email,
        otp=otp,
        expires_at=expires
    )

    db.add(otp_entry)
    db.commit()

    send_email(email, otp)

    return {"message": "OTP sent successfully"}

@router.post("/verify-otp")
def verify_otp(email: str, otp: str, db: Session = Depends(get_db)):
    record = (
        db.query(OTP)
        .filter(OTP.email == email)
        .order_by(OTP.expires_at.desc())
        .first()
    )

    if not record:
        return {"error": "No OTP found"}

    if record.otp != otp:
        return {"error": "Invalid OTP"}

    from datetime import datetime
    if record.expires_at < datetime.utcnow():
        return {"error": "OTP expired"}

    return {"message": "OTP verified successfully"}

@router.post("/create-user")
def create_user(user: UserCreate, db: Session = Depends(get_db)):
    # Check if user already exists
    existing_user = db.query(User).filter(User.email == user.email).first()

    if existing_user:
        return {"error": "User already exists"}

    # Hash password
    hashed_password = hash_password(user.password)

    # Create user
    new_user = User(
        name=user.name,
        email=user.email,
        password=hashed_password,
    )

    db.add(new_user)
    db.commit()

    return {"message": "User created successfully"}

class LoginRequest(BaseModel):
    email: str
    password: str


@router.post("/login")
def login(data: LoginRequest, db: Session = Depends(get_db)):
    user = db.query(User).filter(User.email == data.email).first()

    if not user:
        return {"error": "User not found"}

    if not verify_password(data.password, user.password):
        return {"error": "Invalid password"}

    return {"message": "Login successful"}