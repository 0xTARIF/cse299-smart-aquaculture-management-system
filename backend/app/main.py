from fastapi import FastAPI
from app.db.database import engine, Base
from app.models.otp_model import OTP
from app.routes.auth_routes import router as auth_router
from fastapi.middleware.cors import CORSMiddleware

#db models
from app.models.user_model import User

app = FastAPI()

app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],  # for development
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

Base.metadata.create_all(bind=engine)

app.include_router(auth_router, prefix="/auth")

@app.get("/")
def root():
    return {"status": "running"}