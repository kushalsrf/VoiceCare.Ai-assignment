from fastapi import FastAPI
from app.health import router as health_router
from app.routes import router as api_router

app = FastAPI(
    title="Voicecare Backend API",
    version="1.0.0"
)

app.include_router(health_router)
app.include_router(api_router, prefix="/api")
