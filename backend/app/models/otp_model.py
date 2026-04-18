from sqlalchemy import Column, String, DateTime
from app.db.database import Base
import uuid

class OTP(Base):
    __tablename__ = "otp_codes"

    id = Column(String, primary_key=True, default=lambda: str(uuid.uuid4()))
    email = Column(String, nullable=False)
    otp = Column(String, nullable=False)
    expires_at = Column(DateTime, nullable=False)