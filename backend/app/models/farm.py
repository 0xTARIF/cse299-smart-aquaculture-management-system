from sqlalchemy import Column, String, ForeignKey
from app.db.database import Base
import uuid


class Farm(Base):
    __tablename__ = "farms"

    id = Column(String, primary_key=True, default=lambda: str(uuid.uuid4()))
    name = Column(String, nullable=False)
    location = Column(String, nullable=True)

    # Link to user
    user_id = Column(String, ForeignKey("users.id"), nullable=False)