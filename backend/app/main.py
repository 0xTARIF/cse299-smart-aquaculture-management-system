from fastapi import FastAPI
from app.db.database import engine, Base
from app.routes.auth_routes import router as auth_router
from fastapi.middleware.cors import CORSMiddleware
from app.routes.farm_routes import router as farm_router

#db models
from app.models.user_model import User
from app.models.farm import Farm
from app.models.otp_model import OTP
from app.routes.user_routes import router as user_router

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

app.include_router(farm_router)

app.include_router(user_router)

@app.get("/")
def root():
    return {"status": "running"}

